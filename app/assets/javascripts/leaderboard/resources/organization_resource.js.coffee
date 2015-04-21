LeaderboardApp.factory "Organization", ($resource) ->
  $resource("/api/organizations/:id", {id: '@id'},
  {
   get:           {method: 'GET'},
   save:          {method: 'POST'},
   query:         {method: 'GET'},
   remove:        {method: 'DELETE'},
   delete:        {method: 'DELETE'},
   update:        {method: 'PUT'},
   availability:  {method: 'GET', url: '/api/organizations/availability'}
  })