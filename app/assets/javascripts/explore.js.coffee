$(document).on "page:change", ->
  if (typeof gon != 'undefined' && gon.search)
    console.log(gon.search);
    oTable = $("#search").dataTable
      aaData:gon.search['profiles']
      bFilter: true
      bLengthChange:false
      iDisplayLength: 30

    $(".dataTables_filter input").hide()
    $(".dataTables_filter").children("label").hide()
    $("#search-query").keyup ->
      oTable.fnFilter $("#search-query").val()
