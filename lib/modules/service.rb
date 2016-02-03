require_relative "./base"

class ServiceModule < BaseModule
  def execute
    puts "\tModule: service"
    command = "sudo service #{@options['name']} #{@options['state']}"
    puts "\t\tRaw Command: #{command}"
  end
end
