require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

desc "build the gemfile"
task :gem do
  system("gem build spooky_core.gemspec")
end

desc "build the gem and install it"
task :install do
  system("gem build spooky_core.gemspec")
  f = Dir["spooky_core-*.gem"][0]
  system("gem install #{f}")
end