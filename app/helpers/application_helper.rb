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
end
