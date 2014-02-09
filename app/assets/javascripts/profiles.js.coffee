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

  /#==========  Kundali  ==========#/
  select_birth_country = $('#select-birth-country').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_birth_country
                    create: false
                });
  select_birth_city = $('#select-birth-city').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_birth_city
                    create: false
                });

  select_dob = $('#select-dob').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_dob
                    create: false
                });
  select_tob = $('#select-tob').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_tob
                    create: false
                });
  select_manglik = $('#select-manglik').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_manglik
                    create: false
                });
  select_sun_sign = $('#select-sun-sign').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_sun_sign
                    create: false
                });
  select_moon_sign = $('#select-moon-sign').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_moon_sign
                    create: false
                });
  select_nakshatra = $('#select-nakshatra').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_nakshatra
                    create: false
                });

  select_birth_country[0].selectize.setValue([$("#select-birth-country").attr('value')])
  select_birth_city[0].selectize.setValue([$("#select-birth-city").attr('value')])
  select_dob[0].selectize.setValue([$("#select-dob").attr('value')])
  select_tob[0].selectize.setValue([$("#select-tob").attr('value')])
  select_manglik[0].selectize.setValue([$("#select-manglik").attr('value')])
  select_sun_sign[0].selectize.setValue([$("#select-sun-sign").attr('value')])
  select_moon_sign[0].selectize.setValue([$("#select-moon-sign").attr('value')])
  select_nakshatra[0].selectize.setValue([$("#select-nakshatra").attr('value')])





