'use strict';

app = angular.module('ToDo')

app.factory "Project", [ "$resource", ($resource) ->
  $resource("projects/:id", {id: "@id"}, {update: {method: "PUT"}})
]

app.factory 'Task', ["$resource", ($resource) ->
  $resource('/projects/:projectId/tasks/:sort:id',
    {projectId: '@projectId', sort: '@sort', id: '@id'},
    {update: {method: "PUT"},
    sort: {method: 'POST', params: {sort: 'sort'}}})
]

app.factory 'Comment', ["$resource", ($resource) ->
  $resource('/comments/:id', {id: '@id'})
]