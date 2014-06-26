app = angular.module("app")

app.factory "Project", [
  "$resource"
  ($resource) ->
    return $resource("/projects/:id",
      id: "@id"
    )
]
app.factory "Task", [
  "$resource"
  ($resource) ->
    return $resource("/projects/:projectId/tasks/:id",
      projectId: "@projectId"
      id: "@id"
    )
]