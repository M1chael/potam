require 'aruba/cucumber'
require 'sequel'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')
CLEANDB = "#{File.expand_path(File.dirname(__FILE__))}/../../test/clean.db"
TESTDB = "#{File.expand_path(File.dirname(__FILE__))}/../../test/test.db"

Before do |scenario|
  # Using "announce" causes massive warnings on 1.9.2
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s
  ENV['POTAM'] = 'test'
  FileUtils.cp(CLEANDB, TESTDB) if !defined? scenario.scenario_outline
end

After do
  ENV['RUBYLIB'] = @original_rubylib
end

at_exit do
  ENV['POTAM'] = 'production'
  FileUtils.cp(CLEANDB, TESTDB)
end