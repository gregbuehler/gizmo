require_relative './modules/package'

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
      case action['module']
      when "package"
        PackageModule.new(action['options']).execute
      when "service"
        puts "\tModule: service"
        command = "sudo service #{action['options']['name']} #{action['options']['state']}"
        puts "\t\tRaw Command: #{command}"
      when "user"
        puts "\tModule: user"
        command = "sudo useradd #{action['options']['name']}"
        puts "\t\tRaw Command: #{command}"
      when "file"
        puts "\tModule: file"
        puts "\t\tTODO"
      else
        puts "\tModule: Unknown"
        puts "\t\tNOOP"
      end
    end
  end
end
