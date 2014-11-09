require 'highline/import'

module Dialog

  attr_accessor :new_task_title, :new_task_description

  def self.ask_new_task
    @new_task_title = ask('Введите имя задачи: ')
    @new_task_description = ask('Введите описание задачи: ')
  end

end