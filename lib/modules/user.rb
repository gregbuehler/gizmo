require_relative "./base"

class UserModule < BaseModule
  def execute
    puts "\tModule: user"
    command = "sudo useradd #{@options['name']}"
    puts "\t\tRaw Command: #{command}"
  end
end
