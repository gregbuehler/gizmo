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
    ssh = nil
    @manifest['actions'].each do |action|
      puts "#{action['description']}"
      case action['module'].downcase
      when "package"
        action['result'] = PackageModule.new(ssh, action['options']).execute
      when "service"
        action['result'] = ServiceModule.new(ssh, action['options']).execute
      when "user"
        action['result'] = UserModule.new(ssh, action['options']).execute
      when "file"
        action['result'] = FileModule.new(ssh, action['options']).execute
      else
        raise Exception.new("Unknown module!")
      end
    end
  end

  def result()
    puts @manifest.to_json
  end
end
