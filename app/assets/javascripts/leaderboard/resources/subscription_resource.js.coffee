LeaderboardApp.factory "Subscription", ($resource) ->
  $resource("/api/organizations/:organization_id/subscription", {},
  {
   get:    {method: 'GET'},
   save:   {method: 'POST'},
   query:  {method: 'GET'},
   remove: {method: 'DELETE'},
   delete: {method: 'DELETE'},
   update: {method: "PUT"}
  })