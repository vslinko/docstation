symfio = require "symfio"

container = symfio "docstation", __dirname
loader = container.get "loader"

container.set "components", [
  "angular#~1.0"
  "bootstrap#~2.3"
]

loader.use symfio.plugins.express
loader.use symfio.plugins.assets
loader.use symfio.plugins.bower

loader.load() if require.main is module
