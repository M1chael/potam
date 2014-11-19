class DB

  # attr_reader :new_test_id

  def initialize(db = Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../db/potam.db"))
    self.class.__send__(:attr_reader, "new_#{self.class.name.downcase}_id")
    @db = db
    # Sequel.sqlite("#{File.expand_path(File.dirname(__FILE__))}/../test/test.db")
    # @db = db
    # @tasks = @db[:tasks]
  end

  # def create(options = {})
  #   options.each do |key, value|
  #     instance_variable_set("@#{key}", value)
  #   end
  #   @new_task_id = @tasks.insert(title: @title, description: @description, created_at: @created_at)
  # end

  # def last
  #   @tasks.order(Sequel.desc(:id)).limit(10).all
  # end

  # def list
  #   @tasks.order(Sequel.desc(:id)).all
  # end

  # def info(id)
  #   @tasks.where("id = ?", id.to_i).first
  # end

end