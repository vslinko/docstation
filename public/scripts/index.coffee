window.docstation = docstation = angular.module "docstation", [
  "ngResource"
]


docstation.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"


docstation.config ($routeProvider) ->
  $routeProvider.otherwise redirectTo: "/"


docstation.factory "Document", ($resource) ->
  $resource "/documents/:id", {},
    update: method: "PUT", params: id: "@_id"


docstation.controller "DocumentsCtrl", ($scope, Document) ->
  $scope.documents = Document.query()

  do initNewDocument = ->
    $scope.document = new Document
      date: new Date
      iterations: [files: []]
      editable: true

  $scope.newDocument = (document) ->
    $scope.documents.push document
    initNewDocument()


docstation.filter "filetype", ->
  (filename) ->
    matches = /\.(.+)$/.exec filename

    if matches
      type = switch matches[1].toLowerCase()
        when "zip", "tar", "gz", "bz2", "tgz", "tbz2" then "compressed"
        when "xls", "xlsx" then "excel"
        when "ai" then "illustrator"
        when "png", "jpg", "jpeg", "gif", "bmp" then "image"
        when "key" then "keynote"
        when "numbers" then "numbers"
        when "pages" then "pages"
        when "pdf" then "pdf"
        when "psd" then "photoshop"
        when "ppt", "pptx" then "powerpoint"
        when "txt", "md" then "text"
        when "doc", "docx" then "word"

    if type then type else "fileicon_bg"


docstation.directive "document", ->
  scope: document: "=", onsave: "&"
  templateUrl: "/views/document.html"
  link: (scope, element, attrs) ->
    scope.addIteration = (document) ->
      document.iterations.push files: []

    scope.addFile = (iteration, file, location) ->
      iteration.files.push
        name: file.name
        link: location
        description: file.name

    scope.saveDocument = (document) ->
      callback = (document) ->
        scope.document = document
        scope.$eval "onsave({document: document})"

      if document._id
        document.$update callback
      else
        document.$save callback


docstation.directive "datepicker", (dateFilter) ->
  scope: datepicker: "="
  link: (scope, element) ->
    do updateInputValue = ->
      element.val dateFilter scope.datepicker, "dd.MM.yyyy"

    datepicker = element.datepicker
      format: "dd.mm.yyyy"
      weekStart: 1
      todayHighlight: true
      language: "ru"

    datepicker.on "changeDate", (event) ->
      scope.datepicker = event.date
      scope.$apply()
      updateInputValue()


docstation.directive "fileupload", ->
  scope: fileupload: "&"
  link: (scope, element, attrs) ->
    element.bind "click", ->
      fileupload = $("<input type=\"file\">").fileupload
        url: "/uploads"
        paramName: "file"
        done: (event, data) ->
          scope.file = data.files[0]
          scope.location = data.jqXHR.getResponseHeader "Location"
          scope.$apply "fileupload({file: file, location: location})"

      fileupload.click()
