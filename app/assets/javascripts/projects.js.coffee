'use strict';

app = angular.module("ToDo", ["ngResource", "ui.sortable"])

app.factory "Project", ($resource) ->
  $resource("projects/:id", {id: "@id"}, {update: {method: "PUT"}})

app.factory 'Task', ($resource) ->
  $resource('/projects/:projectId/tasks/:sort:id',
    {projectId: '@projectId', sort: '@sort', id: '@id'},
    {update: {method: "PUT"},
    sort: {method: 'POST', params: {sort: 'sort'}}})

app.directive "datepicker", ->
  require: "ngModel"
  link: (scope, el, attr, ngModel) ->
    $(el).datepicker(format: "yyyy-mm-dd").on "changeDate", (ev) ->
      ngModel.$setViewValue $(this).val()
      $(this).datepicker "hide"


@ProjectsCtrl = (Project, $scope, Task) ->
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


@TasksCtrl = (Task, $scope) ->

  $scope.check_deadline = (task) ->
    return false if task.deadline == null
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
        console.log "list : stop"
    options

  $scope.sort_task = ->
    Sscope.projects

  $scope.sortableOptionsList = (project) ->
    createOptions(project)
