require_relative "./base"

class PackageModule < BaseModule
  def execute
    check_exists = "sudo dpkg -s #{@options['name']}"

    case @options['state']
      when "present"
        if check_exists
          # no-op
        else
          @command = "sudo apt-get install #{@options['name']}"
          @changed = true
        end
      when "absent"
        if check_exists
          @command = "sudo apt-get remove #{@options['name']}"
          @changed = true
        else
          # no-op
        end
      else
    end

    # execute command capture, capture success
    @success = @command

    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
