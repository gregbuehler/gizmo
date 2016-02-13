require_relative "./base"

class FileModule < BaseModule
  def upload
    begin
      puts @session.exec!("whoami")
      puts "attempting to upload #{@options['file']}"
      @output = @session.scp.upload(@options['source'], @options['file'])
    rescue Exception => e
      puts "wtf!"
      puts "#{e.message}"
      @output = "E: ${e.message}"
      @success = false
    end
  end

  def execute
    @command = ":"
    @output = ""
    @changed = false
    @success = true

    check_exists = @session.exec!("file #{@options['file']} | grep -v ERROR | wc -l").to_i > 0

    case @options['state']
      when "present", "sync"
        if check_exists
          # update remote if hashes don't match
          existing_hash = @session.exec!("md5sum #{@options['file']}  | cut -d ' ' -f 1")
          candidate_hash = `md5sum #{@options['source']} | cut -d ' ' -f 1`

          puts "#{existing_hash} <=> #{candidate_hash}"

          if existing_hash != candidate_hash
            @changed = true
            upload
            @output = "replaced remote file #{@options['file']} from #{existing_hash.strip} to #{candidate_hash.strip}"
          else
            @output = "remote file #{@options['file']} is already current"
          end
        else
          @changed = true
          upload
          @output = "uploaded new remote file #{@options['file']}"
        end
      when "absent"
        if check_exists
          @command = "rm -f #{@options['file']}"
          @changed = true
          @output = "removed remote file #{@options['file']}, #{@session.exec!(@command)}"
        else
          @output = "remote file #{@options['file']} did not exist"
        end
      else
    end

    if @success == true
      @success = false if @output.nil? || @output.include?("E: ")
    end

    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
