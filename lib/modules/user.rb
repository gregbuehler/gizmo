require_relative "./base"

class UserModule < BaseModule
  def execute
    check_exists = @session.exec!("sudo id -u #{@options['name']} | grep 'no such user' | wc -l").to_i != 0

    case @options['state']
      when "present"
        if check_exists
          # no-op
        else
          @command = "sudo useradd #{@options['name']}"
          @output = @session.exec!(@command)
          @changed = true
        end
      when "absent"
        if check_exists
          @command = "sudo userdel #{@options['name']}"
          @output = @session.exec!(@command)
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
