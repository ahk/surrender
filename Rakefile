namespace 'create' do
  desc "Create .rb file and spec for a new module, name=<name>"
  task :module do
    unless ENV.include?("name")
      raise "usage: rake create:module name=<module name>"
    end
    name = ENV['name']
    lib_file = "lib/#{name}.rb"
    spec_file = "spec/#{name}_spec.rb"
    
    if FileUtils.touch(lib_file) && FileUtils.touch(spec_file)
      puts "added file and spec for #{name}.rb"
    else
      FileUtils.rm lib_file
      FileUtils.rm spec_file
      puts "failed."
    end
  end
end