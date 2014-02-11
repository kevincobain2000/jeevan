# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $("[data-behaviour~=datepicker]").datepicker()
  $('.timepicker').timepicker();
  $('textarea').autosize();


  selectize_items =
                    best_time_f:true #remove true if nesting child
                    best_time_t:true
                    religion:true
                    mother_tongue:true
                    caste:true
                    sub_caste:true
                    native_place:true
                    birth_country:true
                    birth_city:true
                    tob:true
                    manglik:true
                    sun_sign:true
                    moon_sign:true
                    nakshatra:true
                    hobby:true
                    interest:true
                    music:true
                    read:true
                    dress:true
                    tv:true
                    movie:
                      delimiter:','
                      maxItems:10
                    sport:true
                    cuisine:true
                    vacation:true
                    income:true
                    father:true
                    mother:true
                    brother:true
                    sister:true
                    profile_handler:true
                    school:true
                    grad_college:true
                    grad:true
                    post_grad:true
                    highest_degree:
                      maxItems: 10
                      create:true
                    blood:true
                    weight:true
                    height:true
                    residence:true
                    desired_height:true
                    desired_age:true
                    desired_country:true
                    desired_city:true
                    desired_religion:true
                    desired_caste:true
                    desired_mother_tongue:true
                    desired_education:true
                    desired_occupation:true
                    desired_income:true

  for name, options of selectize_items
    css_id = name.replace /_/g, "-"
    $("#select-" + css_id).selectize({
                    maxItems: if options.maxItems then options.maxItems else 1,
                    valueField: if options.valueField then options.valueField else "title",
                    labelField: if options.labelField then options.labelField else "title",
                    searchField: if options.searchField then options.searchField else "title",
                    options: gon.select_profile_edit_items[name]
                    create: if options.create then options.create else false,
                    render:
                      option: (item, escape) ->
                        '<div><i class="icon-plus"></i> '+item.title+'</div>'
    });
