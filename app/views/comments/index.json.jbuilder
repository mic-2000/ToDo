json.array! @comments do |comment|
  json.id           comment.id
  json.task_id      comment.task_id
  json.body         comment.body
  json.file_name    comment[:file_name].nil? ? nil : link_to(comment[:file_name], comment.file_name.url)
end