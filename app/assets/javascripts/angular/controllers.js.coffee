'use strict';

app = angular.module('ToDo')

@ProjectsCtrl = ["Project", "$scope", "Task", (Project, $scope, Task) ->
  $scope.projects = Project.query()

  $scope.addProject = ->
    project = new Project({name: '', pr_new: true})
    $scope.projects.push(project)

  $scope.prUpdate = (project) ->
    return project.error = true if project.name == ''
    if project.id == undefined
      project.$save()
    else
      project.$update()
    project.pr_new = false

  $scope.prEdit = (project) ->
    project.pr_new = true

  $scope.prDestroy = (index) ->
    $scope.projects[index].$delete() unless $scope.projects[index].id == undefined
    $scope.projects.splice index, 1
]

@TasksCtrl = ["Task", "$scope", (Task, $scope) ->

  $scope.check_deadline = (task) ->
    return false if task.deadline == null
    return false if task.done == true
    return new Date(task.deadline).valueOf() < new Date().valueOf()

  $scope.addTask = (project, newTask) ->
    return if newTask == undefined || newTask.name == ''
    task = new Task({name: newTask.name, projectId: project.id})
    task.$save()
    project.tasks.push(task)
    newTask.name = ''

  $scope.sortTask = (project, index) ->
    task.edit

  $scope.updTask = (project, index) ->
    task = new Task(project.tasks[index])
    task.projectId = project.id
    task.$update()
    project.tasks[index].edit = false if task.edit

  $scope.destroyTask = (project, index) ->
    Task.remove
      projectId: project.id
      id: project.tasks[index].id
    , ->
      project.tasks.splice index, 1

  createOptions = (project) ->
    options =
      connectWith: ".sort_task"
      handle: ".sortable-activeitem"
      stop: ->
        priority = []
        $.each $scope.project.tasks, ->
          priority.push this.id
        Task.sort
          task: {priority: priority}
          projectId: $scope.project.id
    options

  $scope.sort_task = ->
    Sscope.projects

  $scope.sortableOptionsList = (project) ->
    createOptions(project)
]


@CommentsCtrl = ["Comment", "$scope", (Comment, $scope) ->
  $scope.file = null;

  $scope.loadComment = (task) ->
    task.show_comment = !task.show_comment
    task.comments = Comment.query({task_id: task.id}) if task.show_comment && task.comments == undefined

  $scope.destroyComment = (task, index) ->
    Comment.remove
      task_id: task.id
      id: task.comments[index].id
    , ->
      task.comments.splice index, 1

  $scope.complete = (content, task) ->
    task.comments.push(content)
    $scope.body = null
    $scope.file = null
]