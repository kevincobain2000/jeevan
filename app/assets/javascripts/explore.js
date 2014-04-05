
$(document).on("page:change", function() {
  var oTable;
  try {
    $("#search").dataTable().fnDestroy();
  } catch (e) {

  }
  if (typeof gon !== 'undefined' && gon.search) {
    console.log(gon.search);
    oTable = $("#search").dataTable({
      aaData: gon.search['profiles'],
      bFilter: true,
      bLengthChange: false,
      iDisplayLength: 30
    });
    $(".dataTables_filter input").hide();
    $(".dataTables_filter").children("label").hide();
    return $("#search-query").keyup(function() {
      return oTable.fnFilter($("#search-query").val());
    });
  }
});
