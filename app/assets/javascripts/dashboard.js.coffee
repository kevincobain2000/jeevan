# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $('#tabs').tabs()

  inv = []
  if (typeof gon != 'undefined' && gon.inv)
    inv = gon.inv
  $("#inv").dataTable
    aaData:inv

    bFilter: true
    bLengthChange:false