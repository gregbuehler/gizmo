class BaseModule
  @command = ":"
  @output = ""
  @changed = false
  @success = true

  def initialize(session=nil, options=nil)
    @session = session
    @options = options
  end

  def execute
    {
      command: "#{@command}",
      output: "#{@output}",
      changed: "#{@changed}",
      success: "#{@success}"
    }
  end
end
