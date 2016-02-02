require 'optparse'
require 'json'

# capture args
args = {}
OptionParser.new do |opts|
  opts.banner = "Usage: gizmo.rb [args] "

  opts.on("-h", "--host HOSTNAME", "Target hostname") do |host|
    args[:host] = host
  end

  opts.on("-u", "--user USERNAME", "connect as user") do |user|
    args[:user] = user
  end

  opts.on("-p", "--password PASSWORD", "password to use") do |password|
    args[:password] = password
  end
end.parse!

manifest_filename = ARGV.pop

# guard against bad args
raise Exception.new("hostname not provided") if args[:host].nil?
raise Exception.new("username not provided") if args[:user].nil?
raise Exception.new("password not provided") if args[:password].nil?
raise Exception.new("manifest file not provided") if manifest_filename.nil?

# load up a gizmo and execute
puts "Gizmo loading up!"


puts "\thost: #{args[:host]}"
puts "\tuser: #{args[:user]}"
puts "\tpass: #{args[:password]}"
puts "\tmanifest_filename: #{manifest_filename}"
