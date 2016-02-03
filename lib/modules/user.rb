require_relative "./base"

class UserModule < BaseModule
  def execute
    check_exists = "sudo id -u #{@options['name']}"

    case @options['state']
      when "present"
        if check_exists
          # no-op
        else
          @command = "sudo useradd #{@options['name']}"
          @changed = true
        end
      when "absent"
        if check_exists
          @command = "sudo userdel #{@options['name']}"
          @changed = true
        else
          # no-op
        end
      else
    end

    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
