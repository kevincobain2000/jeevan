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
                    options: [
                        {title: 'Hindu'},
                        {title: 'Muslim'},
                        {title: 'Christian'}
                        {title: 'Buddhist'}
                        {title: 'Jain'}
                        {title: 'Parsi'}
                        {title: 'Other'}
                    ],
                    create: false
                });

  select_caste = $('#select-caste').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {title: 'Hindu caste'},
                        {title: 'Muslim Caste'},
                        {title: 'Christian'}
                        {title: 'Buddhist'}
                        {title: 'Jain'}
                        {title: 'Khatri'}
                        {title: 'Other'}
                    ],
                    create: false
                });
  select_sub_caste = $('#select-sub-caste').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {title: 'Sub Caste'},
                        {title: 'Muslim Caste'},
                        {title: 'Christian'}
                        {title: 'Buddhist'}
                        {title: 'Jain'}
                        {title: 'Khatri'}
                        {title: 'Other'}
                    ],
                    create: false
                });

  select_native_place = $('#select-native-place').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: [
                        {title: 'Delhi'},
                        {title: 'Punjab'},
                        {title: 'Mumbai'}
                        {title: 'PlaceName'}
                        {title: 'Other'}
                    ],
                    create: false
                });

  # These values are loaded from DB
  select_religion[0].selectize.setValue([$("#select-religion").attr('value')])
  select_mother_tongue[0].selectize.setValue([$("#select-mother-tongue").attr('value')])
  select_caste[0].selectize.setValue([$("#select-caste").attr('value')])
  select_sub_caste[0].selectize.setValue([$("#select-sub-caste").attr('value')])
  select_native_place[0].selectize.setValue([$("#select-native-place").attr('value')])

  console.log(gon.select_religion);
