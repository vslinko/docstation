window.docstation = docstation = angular.module "docstation", [
  "ngResource"
]


docstation.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"


docstation.config ($routeProvider) ->
  $routeProvider.otherwise redirectTo: "/"


docstation.factory "Document", ($resource) ->
  $resource "/documents"


docstation.controller "DocumentsCtrl", ($scope, Document) ->
  $scope.documents = Document.query()


docstation.directive "document", ->
  scope: document: "="
  templateUrl: "/views/document.html"
