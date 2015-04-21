LeaderboardApp.factory "GuestUser", ($resource) ->
  $resource("/api/organizations/:organization_id/guest_user", {},
  {
   get:    {method: 'GET'},
   save:   {method: 'POST'},
   query:  {method: 'GET'},
   remove: {method: 'DELETE'},
   delete: {method: 'DELETE'}
   update: {method: "PUT"}
  })