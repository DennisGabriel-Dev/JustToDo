module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then "alert alert--info"
    when :success then "alert alert--success"
    when :error then "alert alert--error"
    when :alert then "alert alert--error"
    end
  end

  def task_list_progress(task_list)
    tasks = task_list.tasks
    total = tasks.size
    return { percent: 0, done: 0, total: 0 } if total.zero?

    done = tasks.count { |t| t.status }
    { percent: (done * 100.0 / total).round, done: done, total: total }
  end

  def task_filter_class(current, value)
    base = "task-filter"
    current == value ? "#{base} #{base}--active" : base
  end

  def empty_task_message(filter)
    case filter
    when "pending" then "Nenhuma tarefa pendente."
    when "done" then "Nenhuma tarefa concluída ainda."
    else "Nenhuma tarefa ainda. Crie a primeira!"
    end
  end
end
