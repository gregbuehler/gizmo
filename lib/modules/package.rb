require_relative "./base"

class PackageModule < BaseModule
  def execute
    @command = ":"
    @output = ""
    @changed = false
    @success = true

    check_exists = @session.exec!("sudo dpkg-query -l | grep \"#{@options['packages'].join("\\|")}\" | wc -l").to_i > 0

    case @options['state']
      when "present"
        if check_exists
          # no-op
          puts "check exists, #{@changed}"
        else
          @command = "sudo apt-get install -qq #{@options['packages'].join(" ")}"
          @changed = true
          @output = @session.exec!(@command)

          puts "not check exists, #{@changed}"
        end
      when "absent"
        if check_exists
          @command = "sudo apt-get remove --purge -qq #{@options['packages'].join(" ")}"
          @changed = true
          @output = @session.exec!(@command)

          puts "check exists, #{@changed}"
        else
          # no-op
          puts "not check exists, #{@changed}"
        end
      else
    end

    # execute command capture, capture success
    @success = false if @output.nil? || @output.include?("E: ")
    #@success = true if @changed === false

    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
