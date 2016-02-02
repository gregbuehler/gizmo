require_relative "./base"

class PackageModule < BaseModule
  def execute
    puts "\tModule: package"
    command = "sudo apt-get install #{@options['name']}"
    puts "\t\tRaw Command: #{command}"
  end
end
