# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $('#tabs').tabs()

  if (typeof gon != 'undefined' && gon.dashboard)
    # $("#in_interests").dataTable().fnDestroy()
    # $("#out_interests").dataTable().fnDestroy()
    # $("#in_visitors").dataTable().fnDestroy()

    $("#in_interests").dataTable
      aaData:gon.dashboard['in_interests']
      bFilter: true
      bLengthChange:false
    $("#out_interests").dataTable
      aaData:gon.dashboard['out_interests']
      bFilter: true
      bLengthChange:false
    $("#in_visitors").dataTable
      aaData:gon.dashboard['in_visitors']
      bFilter: true
      bLengthChange:false
