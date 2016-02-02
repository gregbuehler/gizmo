class Runner
  attr_accessor :args, :manifest
  def initialize(params = {})
    @args = params.fetch(:args, nil)
    @manifest = params.fetch(:manifest, nil)
  end

  def prepare()
    puts "#{@manifest['name']}"
    puts "preparing to apply #{@manifest['name']}@#{@manifest['version']}"
  end

  def run()
    @manifest['actions'].each do |action|
      puts "#{action['description']}"
    end
  end
end
