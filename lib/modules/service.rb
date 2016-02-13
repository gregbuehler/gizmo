require_relative "./base"

class ServiceModule < BaseModule
  def execute
    # assume this changes for now
    @command = "sudo service #{@options['name']} #{@options['state']}"
    @output = @session.exec!(@command)
    @changed = true
    @success = true

    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
