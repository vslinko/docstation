symfio = require "symfio"

container = symfio "docstation", __dirname
loader = container.get "loader"

container.set "components", [
  "angular#~1.0"
  "angular-resource#~1.0"
  "bootstrap#~2.3"
  "jquery-ui#~1.10"
  "bootstrap-datepicker#~1.0"
  "jquery-file-upload#~7.2"
]

loader.use symfio.plugins.express
loader.use symfio.plugins.expressLogger
loader.use symfio.plugins.assets
loader.use symfio.plugins.bower
loader.use symfio.plugins.mongoose
loader.use symfio.plugins.crud
loader.use symfio.plugins.uploads

loader.use (container, callback) ->
  connection = container.get "connection"
  mongoose = container.get "mongoose"
  crud = container.get "crud"
  app = container.get "app"

  FileSchema = new mongoose.Schema
    name: type: String, required: true
    link: type: String, required: true
    description: type: String, required: true

  IterationSchema = new mongoose.Schema
    files: type: [FileSchema], required: true

  DocumentSchema = new mongoose.Schema
    name: type: String, required: true
    date: type: Date, required: true
    iterations: type: [IterationSchema]

  Document = connection.model "documents", DocumentSchema

  app.get "/documents", crud.list(Document).make()
  app.post "/documents", crud.post(Document).make()

  callback()

loader.load() if require.main is module
