# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $("#search-project").selectize({
     maxItems: 1,
     valueField: "title",
     labelField: "title",
     searchField: "title",
     options: [{title: 'brian@thirdroute.com', title: 'Brian Reavis'}],
     create: true
     plugins: []
     render:
        option: (item, escape) ->
          '<div> <strong>'+item.title+'</strong><br></div>'
  });