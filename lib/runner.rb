require 'net/ssh'

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
    Net::SSH.start( @args[:host],
                    @args[:user],
                    :port => @args[:port],
                    :password => @args[:password]
                  ) do |session|

      puts "SSH connection established to #{@args[:host]}"
      @manifest['actions'].each do |action|
        puts "#{action['description']}"
        case action['module'].downcase
        when "package"
          action['result'] = PackageModule.new(session, action['options']).execute
        when "service"
          action['result'] = ServiceModule.new(session, action['options']).execute
        when "user"
          action['result'] = UserModule.new(session, action['options']).execute
        when "file"
          action['result'] = FileModule.new(session, action['options']).execute
        else
          raise Exception.new("Unknown module!")
        end
      end
    end
  end

  def result()
    puts @manifest.to_json
  end
end
