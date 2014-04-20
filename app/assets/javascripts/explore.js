
$(document).on("page:change", function() {
  var oTable;
  try {
    $("#search").dataTable().fnDestroy();
  } catch (e) {

  }
  if (typeof gon !== 'undefined' && gon.search) {
    $("#search-query").focus();
    oTable = $("#search").dataTable({
      bFilter: true,
      bLengthChange: false,
      iDisplayLength: 30,
    });

    $(".dataTables_filter input").hide();
    $(".dataTables_filter").children("label").hide();
    $("#search-query").keyup(function() {
       oTable.fnFilter($("#search-query").val());
    });


    if (gon.search.query != "") {
      $("#search-query").val(gon.search.query);
      oTable.fnFilter(gon.search.query)
    }
  }

});
