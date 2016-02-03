class BaseModule
  @command = ":"
  @output = ""
  @changed = false
  @success = true

  def initialize(ssh=nil, options=nil)
    @ssh = ssh
    @options = options
  end

  def execute
    {}
  end
end
