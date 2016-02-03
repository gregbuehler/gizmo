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
    {}
  end
end
