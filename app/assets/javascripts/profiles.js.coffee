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

  select_religion = $('#select-religion').selectize({
                    maxItems: 1,
                    valueField: 'id',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {id: 1, title: 'Hindu'},
                        {id: 2, title: 'Muslim'},
                        {id: 3, title: 'Christian'}
                        {id: 4, title: 'Buddhist'}
                        {id: 5, title: 'Jain'}
                        {id: 6, title: 'Parsi'}
                        {id: 7, title: 'Other'}
                    ],
                    create: false
                });

  select_mother_tongue = $('#select-mother-tongue').selectize({
                    maxItems: 1,
                    valueField: 'id',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {id: 1, title: 'Hindu'},
                        {id: 2, title: 'Muslim'},
                        {id: 3, title: 'Christian'}
                        {id: 4, title: 'Buddhist'}
                        {id: 5, title: 'Jain'}
                        {id: 6, title: 'Parsi'}
                        {id: 7, title: 'Other'}
                    ],
                    create: false
                });

  select_caste = $('#select-caste').selectize({
                    maxItems: 1,
                    valueField: 'id',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {id: 1, title: 'Hindu caste'},
                        {id: 2, title: 'Muslim Caste'},
                        {id: 3, title: 'Christian'}
                        {id: 4, title: 'Buddhist'}
                        {id: 5, title: 'Jain'}
                        {id: 6, title: 'Khatri'}
                        {id: 7, title: 'Other'}
                    ],
                    create: false
                });
  select_sub_caste = $('#select-sub-caste').selectize({
                    maxItems: 1,
                    valueField: 'id',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {id: 1, title: 'Sub Caste'},
                        {id: 2, title: 'Muslim Caste'},
                        {id: 3, title: 'Christian'}
                        {id: 4, title: 'Buddhist'}
                        {id: 5, title: 'Jain'}
                        {id: 6, title: 'Khatri'}
                        {id: 7, title: 'Other'}
                    ],
                    create: false
                });

  select_native_place = $('#select-native-place').selectize({
                    maxItems: 1,
                    valueField: 'id',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {id: 1, title: 'Delhi'},
                        {id: 2, title: 'Punjab'},
                        {id: 3, title: 'Mumbai'}
                        {id: 4, title: 'PlaceName'}
                        {id: 5, title: 'Blah'}
                    ],
                    create: false
                });

  # These values are loaded from DB
  select_religion[0].selectize.setValue([$("#select-religion").attr('value')])
  select_mother_tongue[0].selectize.setValue([$("#select-mother-tongue").attr('value')])
  select_caste[0].selectize.setValue([$("#select-caste").attr('value')])
  select_sub_caste[0].selectize.setValue([$("#select-sub-caste").attr('value')])
  select_native_place[0].selectize.setValue([$("#select-native-place").attr('value')])







