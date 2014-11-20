require 'sequel'
require 'db'

CLEANDB = "#{File.expand_path(File.dirname(__FILE__))}/../test/clean.db"
TESTDB = "#{File.expand_path(File.dirname(__FILE__))}/../test/test.db"