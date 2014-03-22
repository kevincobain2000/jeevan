# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $('#tabs').tabs()
  # $("#in_interests").dataTable().fnDestroy()
  # $("#out_interests").dataTable().fnDestroy()
  # $("#in_visitors").dataTable().fnDestroy()

  if (typeof gon != 'undefined' && gon.dashboard)


    in_interests = $("#in_interests").dataTable
      aaData:gon.dashboard['in_interests']
      bFilter: true
      bLengthChange:false
    $("#search-in-interests").keyup ->
      in_interests.fnFilter $(this).val()


    out_interests = $("#out_interests").dataTable
      aaData:gon.dashboard['out_interests']
      bFilter: true
      bLengthChange:false
    $("#search-out-interests").keyup ->
      out_interests.fnFilter $(this).val()

    in_visitors = $("#in_visitors").dataTable
      aaData:gon.dashboard['in_visitors']
      bFilter: true
      bLengthChange:false
    $("#search-in-visitors").keyup ->
      in_visitors.fnFilter $(this).val()

    $(".dataTables_filter input").hide()
    $(".dataTables_filter").children("label").hide()



