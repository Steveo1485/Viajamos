app = angular.module("cotrippingApp", ["rails"])

app.factory 'Location', ['railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory
    url: "/locations",
    name: "location"
]