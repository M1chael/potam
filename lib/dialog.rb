require 'highline/import'
require 'unicode'

module Dialog

  attr_reader :new_task_title, :new_task_description, :new_note_text, :new_subtask_title

  TRANSLATION = {
    task:     'задача',
    subtask:  'подзадача',
    note:     'заметка',
    created:  'создана',
    finished: 'завершена'
  }

  WEEK = [nil, 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']

  def self.ask_new_task
    @new_task_title = ask('Введите имя задачи: ') { |q| q.readline }
    @new_task_description = ask('Введите описание задачи: ')
  end

  def self.ask_new_subtask
    @new_subtask_title = ask('Введите подзадачу: ')
  end

  def self.ask_new_note
    @new_note_text = ask('Введите текст заметки: ')
  end

  def self.say_tasks(tasks, indentation = '')
    tasks.each do |task|
      id = spaces("##{task[:id]}", 8)
      title = spaces(task[:title], 70)
      created_at = ts_to_date(task[:created_at])
      say("#{indentation}#{id}#{title}#{created_at}")
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

  def self.say_report(report)
    say('Проведена работа по следующим задачам:')
    self.say_tasks(report[:tasks], '  ')
    say('=' * 27)
    report[:tasks].each do |task|
      say(task[:title] + ':')
      separator = false
      report[:events].select{ |event| event[:task_id] == task[:id] }.each do |event|
        say("\n") if separator
        separator = true
        wd = WEEK[ts_to_date(event[:timestamp], "%u").to_i]
        say('  ' + ts_to_date(event[:timestamp], "%Y-%m-%d (#{wd}) %H:%M:%S"))
        status = Unicode::capitalize(TRANSLATION[event[:status]])
        object = TRANSLATION[event[:object]]
        text = "\"#{event[:text]}\""
        say("  #{status} #{object} #{text}")
      end
      say('-' * 27)
    end
  end

  private

  def spaces(text, width)
    spaces = ' ' * (width - text.length)
    return "#{text}#{spaces}"
  end

  def ts_to_date(timestamp, template = "%Y-%m-%d")
    Time.at(timestamp.to_i).strftime(template)
  end

end