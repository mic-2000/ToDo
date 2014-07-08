json.id           @project.id
json.name         @project.name
json.tasks @project.tasks do |task|
  json.id            task.id
  json.name          task.name
  json.done          task.done
  json.deadline      task.deadline
  json.priority      task.priority
  json.show_comment  false
end