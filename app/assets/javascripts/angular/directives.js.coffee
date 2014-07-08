'use strict';

app = angular.module('ToDo')

app.directive "datepicker", ->
  require: "ngModel"
  link: (scope, el, attr, ngModel) ->
    $(el).datepicker(format: "yyyy-mm-dd").on "changeDate", (ev) ->
      ngModel.$setViewValue $(this).val()
      $(this).datepicker "hide"

app.directive "fileSelect", ->
  template = "<input type=\"file\" name=\"comment[file_name]\"/>"
  (scope, elem, attrs) ->
    selector = $(template)
    elem.append selector
    selector.bind "change", (event) ->
      scope.$apply ->
        scope[attrs.fileSelect] = event.originalEvent.target.files
    scope.$watch attrs.fileSelect, (file) ->
      selector.val file unless file?