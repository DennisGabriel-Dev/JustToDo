demo = User.find_or_initialize_by(email: "demo@justtodo.dev")
if demo.new_record?
  demo.password = "Demo1234"
  demo.password_confirmation = "Demo1234"
  demo.save!
end

sample_lists = {
  "Pessoal e casa" => [
    { title: "Pagar contas do mês", status: false, priority: "high", tags: "finanças,urgente", due_at: 1.day.ago },
    { title: "Comprar café", status: true, priority: "low", tags: "casa" },
    { title: "Agendar dentista", status: false, priority: "medium", tags: "saúde", due_at: Date.current }
  ],
  "Trabalho da semana" => [
    { title: "Revisar pull requests", status: false, priority: "high", tags: "dev,código" },
    { title: "Atualizar o README", status: true, priority: "medium", tags: "docs" },
    { title: "Preparar demo da sexta", status: false, priority: "high", tags: "demo,trabalho", due_at: 3.days.from_now }
  ],
  "Estudos de Rails" => [
    { title: "Ler guia do Hotwire", status: false, priority: "medium", tags: "rails,estudo" },
    { title: "Praticar turbo frames", status: true, priority: "low", tags: "rails" }
  ]
}

sample_lists.each do |name, tasks|
  list = demo.task_lists.find_or_create_by!(name: name)
  tasks.each do |attrs|
    list.tasks.find_or_create_by!(title: attrs[:title]) do |task|
      task.status = attrs[:status]
      task.priority = attrs[:priority]
      task.tags = attrs[:tags]
      task.due_at = attrs[:due_at] if attrs[:due_at]
    end
  end
end
