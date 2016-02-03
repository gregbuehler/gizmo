require_relative './modules/package'
require_relative './modules/service'
require_relative './modules/user'
require_relative './modules/file'

class Runner
  attr_accessor :args, :manifest
  def initialize(params = {})
    @args = params.fetch(:args, nil)
    @manifest = params.fetch(:manifest, nil)
  end

  def prepare()
    puts "preparing to apply #{@manifest['name']}@#{@manifest['version']}"
  end

  def run()
    @manifest['actions'].each do |action|
      puts "#{action['description']}"
      case action['module'].downcase
      when "package"
        PackageModule.new(action['options']).execute
      when "service"
        ServiceModule.new(action['options']).execute
      when "user"
        UserModule.new(action['options']).execute
      when "file"
        FileModule.new(action['options']).execute
      else
        raise Exception.new("Unknown module!")
      end
    end
  end
end
