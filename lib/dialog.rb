require 'highline/import'

module Dialog

  attr_reader :new_task_title, :new_task_description

  def self.ask_new_task
    @new_task_title = ask('Введите имя задачи: ')
    @new_task_description = ask('Введите описание задачи: ')
  end

  def self.say_tasks(tasks)
    tasks.each do |task|
      say("##{task[:id]}\t#{task[:title]}\t#{Time.at(task[:created_at].to_i).strftime("%Y-%m-%d")}\n")
    end
  end

end