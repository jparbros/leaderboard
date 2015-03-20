ownerApp.factory "Departament", ($resource) ->
  $resource("/api/organizations/:organization_id/departaments/:id", {id: '@id'},
  {
   get:    {method: 'GET'},
   save:   {method: 'POST'},
   query:  {method: 'GET', isArray: true},
   remove: {method: 'DELETE'},
   delete: {method: 'DELETE'}
   update: {method: "PUT"}
  })