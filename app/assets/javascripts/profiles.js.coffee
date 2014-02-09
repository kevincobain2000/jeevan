# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(".typeahead").typeahead
    name: "planets"
    local: ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

  $("[data-behaviour~=datepicker]").datepicker()
  $('.timepicker').timepicker();
  $('textarea').autosize();



  /#==========  Contact  ==========#/
  select_best_time_f = $('#select-best-time-f').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_best_time_f
                    create: false
                });
  select_best_time_t = $('#select-best-time-t').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_best_time_t
                    create: false
                });
  select_best_time_f[0].selectize.setValue([$("#select-best-time-f").attr('value')])
  select_best_time_t[0].selectize.setValue([$("#select-best-time-t").attr('value')])

  /#==========  Religion  ==========#/
  select_religion = $('#select-religion').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_religion
                    create: false
                });

  select_mother_tongue = $('#select-mother-tongue').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_mother_tongue
                    create: false
                });

  select_caste = $('#select-caste').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_caste
                    create: false
                });
  select_sub_caste = $('#select-sub-caste').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_sub_caste
                    create: false
                });

  select_native_place = $('#select-native-place').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_native_place
                    create: false
                });

  # These values are loaded from DB
  select_religion[0].selectize.setValue([$("#select-religion").attr('value')])
  select_mother_tongue[0].selectize.setValue([$("#select-mother-tongue").attr('value')])
  select_caste[0].selectize.setValue([$("#select-caste").attr('value')])
  select_sub_caste[0].selectize.setValue([$("#select-sub-caste").attr('value')])
  select_native_place[0].selectize.setValue([$("#select-native-place").attr('value')])

