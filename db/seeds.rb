demo = User.find_or_initialize_by(email: "demo@justtodo.dev")
if demo.new_record?
  demo.password = "Demo1234"
  demo.password_confirmation = "Demo1234"
  demo.save!
end

sample_lists = {
  "Pessoal e casa" => [
    { title: "Pagar contas do mês", status: false },
    { title: "Comprar café", status: true },
    { title: "Agendar dentista", status: false }
  ],
  "Trabalho da semana" => [
    { title: "Revisar pull requests", status: false },
    { title: "Atualizar o README", status: true },
    { title: "Preparar demo da sexta", status: false }
  ],
  "Estudos de Rails" => [
    { title: "Ler guia do Hotwire", status: false },
    { title: "Praticar turbo frames", status: true }
  ]
}

sample_lists.each do |name, tasks|
  list = demo.task_lists.find_or_create_by!(name: name)
  tasks.each do |attrs|
    list.tasks.find_or_create_by!(title: attrs[:title]) do |task|
      task.status = attrs[:status]
    end
  end
end
