require 'timer'

class Report

  include Timer

  def initialize(db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
    @db = db
  end

  def week
    tasks = @db[:tasks]
  end

end