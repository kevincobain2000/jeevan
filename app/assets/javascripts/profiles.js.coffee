# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  pageSetUp();
  $("#tabs").tabs()
  # Dirty Hack for ajax calls Vanilla
  $("[id^=side]").click ->
    console.log(this)
    $("#hidden-" + this.id)[0].click()

  selectize_items =
                    # best_time_f:true #remove true if nesting child
                    # best_time_t:true
                    religion:true
                    mother_tongue:true
                    caste:true
                    sub_caste:true
                    native_place:true
                    birth_country:true
                    birth_city:true
                    tob:
                      maxItems: 1
                      create:true
                      plugins: ['remove_button', 'restore_on_backspace']
                    manglik:true
                    sun_sign:true
                    moon_sign:true
                    nakshatra:true
                    hobby:
                      maxItems: 10
                      create:true
                      plugins: ['remove_button', 'restore_on_backspace']
                      delimeter: ","
                    interest:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    music:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    read:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    dress:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button','restore_on_backspace']
                    tv:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    movie:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    sport:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    cuisine:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    vacation:
                      maxItems: 10
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    # family_income:true
                    father:true
                    mother:true
                    brother:true
                    sister:true
                    profile_handler:true
                    school:true
                    grad_college:true
                    grad:true
                    post_grad:true
                    highest_degree:true
                    blood:true
                    weight:true
                    height:true
                    residence:true
                    # desired_height:true
                    # desired_age:true
                    desired_country:true
                    desired_city:true
                    desired_religion:true
                    desired_caste:true
                    desired_mother_tongue:true
                    desired_education:true
                    desired_occupation:true
                    # desired_income:true

  for name, options of selectize_items
    css_id = name.replace /_/g, "-"
    #push user items set previously for selectize to show
    val = $('#select-' + css_id).val()
    if val
      for key, value of val.split ","
        gon.select_profile_edit_items[name].push title: value

    if (typeof gon != 'undefined')
      obj = $("#select-" + css_id).selectize({
                    maxItems: if options.maxItems then options.maxItems else 1,
                    valueField: if options.valueField then options.valueField else "title",
                    labelField: if options.labelField then options.labelField else "title",
                    searchField: if options.searchField then options.searchField else "title",
                    options: gon.select_profile_edit_items[name],
                    create: if options.create then options.create else true,
                    plugins: if options.plugins then options.plugins else [],
                    delimeter: if options.delimeter then options.delimeter else ",",
                    render:
                      option: (item, escape) ->
                        '<div><i class="fa fa-plus"></i> <strong>'+item.title+'</strong></div>'
      });


  Dropzone.options.myDropzone =
    dictDefaultMessage: '<div class="hero" style="height:100px;"><h2>Drag & Drop</h2><p>or click to upload images</p></div>'
    paramName: "avatar"
    maxFilesize: 2 #mb
    addRemoveLinks: false
    acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF"
    thumbnailWidth: 300
    thumbnailHeight: 300
    init: ->
      @on 'addedfile', (file) ->

  $(".phone").inputmask("mask", {"mask": "(999) 9999-999-999"});

  # AutoSave Form
  $('form').bind "keyup change", (e) ->
    $(this).find(".autosave").text("Saved")
    $(this).find(":submit.hide").submit()

  $('form').submit ->
    console.log("form was submitted")
    jq_superbox_remov = $("#imageid").attr("value")
    $("#"+jq_superbox_remov).remove()
    $(".superbox-list").removeClass "active"
    $(".superbox-current-img").animate
      opacity: 0, 200, ->
        $(".superbox-show").slideUp()
        return
    $(this).find(".clicksave").text("Saved")

  $("#ta4").click (e) ->
    console.log("desire")
    $("#desired-income-slider").ionRangeSlider
      prettify: false
      hasGrid: true
    $("#desired-height-slider").ionRangeSlider
      prettify: false
      hasGrid: true
    $("#desired-age-slider").ionRangeSlider
      prettify: false
      hasGrid: true

  $("#ta10").click (e) ->
    $("#family-income-slider").ionRangeSlider
      prettify: false
      hasGrid: true

  $(".click2edit").summernote
    height: 350 #set editable area's height
    toolbar: [
      ['style', ['bold', 'italic', 'underline', 'clear']]
      ['fontsize', ['fontsize']]
      ['color', ['color']]
      ['para', ['ul', 'ol', 'paragraph']]
      ['height', ['height']]
      ['help', ['help']]
    ]
  $('.superbox').SuperBox()
  $(".superbox-list").click ->
    currentimg = $(this).find(".superbox-img")
    $("#imageid").attr("value", currentimg.attr("id"))
    return
