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
                    options: gon.select_profile_edit_items.best_time_f
                    create: false
                });
  select_best_time_t = $('#select-best-time-t').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.best_time_t
                    create: false
                });

  /#==========  Religion  ==========#/
  select_religion = $('#select-religion').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.religion
                    create: false
                });

  select_mother_tongue = $('#select-mother-tongue').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.mother_tongue
                    create: false
                });

  select_caste = $('#select-caste').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.caste
                    create: false
                });
  select_sub_caste = $('#select-sub-caste').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.sub_caste
                    create: false
                });

  select_native_place = $('#select-native-place').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.native_place
                    create: false
                });

  /#==========  Kundali  ==========#/
  select_birth_country = $('#select-birth-country').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.birth_country
                    create: false
                });
  select_birth_city = $('#select-birth-city').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.birth_city
                    create: false
                });
  select_tob = $('#select-tob').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.tob
                    create: false
                });
  select_manglik = $('#select-manglik').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.manglik
                    create: false
                });
  select_sun_sign = $('#select-sun-sign').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.sun_sign
                    create: false
                });
  select_moon_sign = $('#select-moon-sign').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.moon_sign
                    create: false
                });
  select_nakshatra = $('#select-nakshatra').selectize({
                    maxItems: 1,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.nakshatra
                    create: false
                });

  /#==========  Hobby  (Multiple) ==========#/
  select_hobby = $('#select-hobby').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.hobby
                    create: false
                });

  select_interest = $('#select-interest').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.interest
                    create: false
                });
  select_music = $('#select-music').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.music
                    create: false
                });

  select_read = $('#select-read').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.read
                    create: false
                });

  select_dress = $('#select-dress').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.dress
                    create: false
                });

  select_tv = $('#select-tv').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.tv
                    create: false
                });

  select_movie = $('#select-movie').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.movie
                    create: false
                    render:
                      option: (item, escape) ->
                        '<div><i class="icon-search"></i> '+item.title+'</div>'

                });

  select_sport = $('#select-sport').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.sport
                    create: false
                });

  select_cuisine = $('#select-cuisine').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.cuisine
                    create: false
                });

  select_vacation = $('#select-vacation').selectize({
                    delimiter: ',',
                    maxItems: 10,
                    valueField: 'title',
                    labelField: 'title',
                    searchField: 'title',
                    options: gon.select_profile_edit_items.vacation
                    create: false
                });