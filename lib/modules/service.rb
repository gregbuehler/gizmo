require_relative "./base"

class ServiceModule < BaseModule
  def execute
    # assume this changes for now
    @command = "sudo systemctl #{@options['state']} #{@options['name']}.service"
    @output = @session.exec!(@command)
    @changed = true

    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
