require 'highline/import'

module Dialog

  attr_reader :new_task_title, :new_task_description, :new_note_text, :new_subtask_title

  def self.ask_new_task
    @new_task_title = ask('Введите имя задачи: ')
    @new_task_description = ask('Введите описание задачи: ')
  end

  def self.ask_new_subtask
    @new_subtask_title = ask('Введите подзадачу: ')
  end

  def self.ask_new_note
    @new_note_text = ask('Введите текст заметки: ')
  end

  def self.say_tasks(tasks)
    tasks.each do |task|
      id = spaces("##{task[:id]}", 8)
      title = spaces(task[:title], 41)
      created_at = ts_to_date(task[:created_at])
      say("#{id}#{title}#{created_at}")
    end
  end

  def self.say_task(task: task, subtasks: subtasks, notes: notes)
    say("##{task[:id]} \"#{task[:title]}\"")
    say(ts_to_date(task[:created_at]))
    say(task[:description])
    if subtasks[0]
      say('Подзадачи:')
      subtasks.each do |subtask|
        created_at = ts_to_date(subtask[:created_at])
        say("  #{created_at} #{subtask[:title]} (##{subtask[:id]})")
      end
    end
    if notes[0]
      notes.each do |note|
        say("\n#{ts_to_date(note[:created_at])}")
        say(note[:text])
      end
    end
  end

  def spaces(text, width)
    spaces = ' ' * (width - text.length)
    return "#{text}#{spaces}"
  end

  def ts_to_date(timestamp)
    Time.at(timestamp.to_i).strftime("%Y-%m-%d")
  end

end