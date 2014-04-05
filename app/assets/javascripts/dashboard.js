
$(document).on("page:change", function() {
  var in_interests, in_visitors, out_interests, shortlist;
  $('#tabs').tabs();
  try {
    $("#in-interests").dataTable().fnDestroy();
    $("#out-interests").dataTable().fnDestroy();
    $("#in-visitors").dataTable().fnDestroy();
    $("#shortlist").dataTable().fnDestroy();
  } catch (e) {

  }
  if (typeof gon !== 'undefined' && gon.dashboard) {
    in_interests = $("#in-interests").dataTable({
      aaData: gon.dashboard['in_interests'],
      bFilter: true,
      bLengthChange: false
    });
    $("#search-in-interests").keyup(function() {
      return in_interests.fnFilter($(this).val());
    });
    out_interests = $("#out-interests").dataTable({
      aaData: gon.dashboard['out_interests'],
      bFilter: true,
      bLengthChange: false
    });
    $("#search-out-interests").keyup(function() {
      return out_interests.fnFilter($(this).val());
    });
    in_visitors = $("#in-visitors").dataTable({
      aaData: gon.dashboard['in_visitors'],
      bFilter: true,
      bLengthChange: false
    });
    $("#search-in-visitors").keyup(function() {
      return in_visitors.fnFilter($(this).val());
    });
    shortlist = $("#shortlist").dataTable({
      aaData: gon.dashboard['shortlist'],
      bFilter: true,
      bLengthChange: false
    });
    $("#search-shortlist").keyup(function() {
      return in_visitors.fnFilter($(this).val());
    });
    $(".dataTables_filter input").hide();
    return $(".dataTables_filter").children("label").hide();
  }
});
