window.docstation = docstation = angular.module "docstation", []


docstation.config ($locationProvider) ->
  $locationProvider.hashPrefix "!"


docstation.config ($routeProvider) ->
  $routeProvider.otherwise redirectTo: "/"


docstation.controller "DocumentsCtrl", ($scope) ->
  $scope.documents = [
    {name: "Договор АА1/13", date: new Date, iterations: [
      {files: [
        {type: "pages", link: "#!/", description: "Оригинал"},
        {type: "pdf", link: "#!/", description: "Релиз"},
        {type: "word", link: "#!/", description: "DOC"},
        {type: "image", link: "#!/", description: "Скан, страница 1"},
        {type: "image", link: "#!/", description: "Скан, страница 2"},
        {type: "image", link: "#!/", description: "Скан, страница 3"},
        {type: "image", link: "#!/", description: "Скан, страница 4"}
      ]},
      {files: [
        {type: "pages", link: "#!/", description: "Оригинал"},
        {type: "pdf", link: "#!/", description: "Релиз"},
        {type: "word", link: "#!/", description: "DOC"},
        {type: "image", link: "#!/", description: "Скан, страница 1"},
        {type: "image", link: "#!/", description: "Скан, страница 2"},
        {type: "image", link: "#!/", description: "Скан, страница 3"},
        {type: "image", link: "#!/", description: "Скан, страница 4"}
      ]}
    ]}
  ]


docstation.directive "document", ->
  scope: document: "="
  templateUrl: "/views/document.html"
