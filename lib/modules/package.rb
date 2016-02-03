require_relative "./base"

class PackageModule < BaseModule
  def execute
    puts "\tModule: package"
    state = ""
    state = "install" if @options['state'].downcase === "present"
    state = "remove" if @options['state'].downcase === "absent"
    
    command = "sudo apt-get #{state} #{@options['name']}"

    puts "\t\tRaw Command: #{command}"
  end
end
