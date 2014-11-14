require 'highline/import'

module Dialog

  attr_reader :new_task_title, :new_task_description

  def self.ask_new_task
    @new_task_title = ask('Введите имя задачи: ')
    @new_task_description = ask('Введите описание задачи: ')
  end

  def self.say_tasks(tasks)
    tasks.each do |task|
      id = spaces("##{task[:id]}", 8)
      title = spaces(task[:title], 41)
      created_at = Time.at(task[:created_at].to_i).strftime("%Y-%m-%d")
      say("#{id}#{title}#{created_at}")
    end
  end

  def spaces(text, width)
    spaces = ' ' * (width - text.length)
    return "#{text}#{spaces}"
  end

end