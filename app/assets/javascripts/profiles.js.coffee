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
                    religion:true
                    mother_tongue:
                      create:true
                    caste:true
                    sub_caste:
                      create:true
                    native_place:
                      create:true
                    birth_country:
                      create:true
                    birth_city:
                      create:true
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
                    father:true
                    mother:true
                    brother:true
                    sister:true
                    profile_handler:true
                    school:
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    grad_college:
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    graduation:
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    post_grad:
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    post_grad_college:
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    highest_degree:
                      create: true
                      plugins: ['remove_button', 'restore_on_backspace']
                    desired_country:
                      create:true
                    desired_city:
                      create:true
                    desired_religion:true
                    desired_caste:true
                    desired_mother_tongue:true
                    desired_education:true
                    desired_occupation:true

  for name, options of selectize_items
    css_id = name.replace /_/g, "-"
    #push user items set previously for selectize to show
    val = $('#select-' + css_id).val()
    if val
      for key, value of val.split ","
        gon.select_profile_edit_items[name].push title: value

    if (typeof gon != 'undefined' && gon.select_profile_edit_items)
      obj = $("#select-" + css_id).selectize({
                    maxItems: if options.maxItems then options.maxItems else 1,
                    valueField: if options.valueField then options.valueField else "title",
                    labelField: if options.labelField then options.labelField else "title",
                    searchField: if options.searchField then options.searchField else "title",
                    options: gon.select_profile_edit_items[name],
                    create: if options.create then options.create else false,
                    plugins: if options.plugins then options.plugins else [],
                    delimeter: if options.delimeter then options.delimeter else ",",
                    render:
                      option: (item, escape) ->
                        desc = if item.desc then item.desc else ""
                        '<div> <strong>'+item.title+'</strong><br><small>'+desc+'</small></div>'
      });

  Dropzone.autoDiscover = false;
  $(".dropzone").dropzone init: ->
    return
  Dropzone.options.myDropzone =
    dictDefaultMessage: '<div class="hero" style="height:500px;"><h2>Drag & Drop</h2><p>or click to upload images</p></div>'
    paramName: "avatar"
    maxFilesize: 2 #mb
    addRemoveLinks: false
    acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF"
    thumbnailWidth: 300
    thumbnailHeight: 300
    init: ->
      @on 'addedfile', (file) ->

  $(".phone").inputmask("mask", {"mask": "(999) 9999-999-999"});

  $(".interest").click ->
    $(this).hide()

  $(".edit").click ->
    $(this).addClass('disabled')

  $('form').change ->
    $(".edit").removeClass('disabled')
  $('form').submit ->
    $.smallBox
      title : "Done !"
      content : "<i class='fa fa-clock-o'></i> <i>You selection was made ..</i>"
      color : "#296191"
      iconSmall : "fa fa-thumbs-up bounce animated"
      timeout : 2000

    # Removing the image
    jq_superbox_remov = $("#imageid").attr("value")
    $("#"+jq_superbox_remov).remove()
    $(".superbox-list").removeClass "active"
    $(".superbox-current-img").animate
      opacity: 0, 200, ->
        $(".superbox-show").slideUp()
        return

  $("#tab-desire").click (e) ->
    console.log("desire")
    $("#desired-income-slider").ionRangeSlider
      prettify: false
      hasGrid: true
      onFinish:(obj) -> # callback, is called on every change
        $(".edit").removeClass('disabled')
    $("#desired-height-slider").ionRangeSlider
      prettify: false
      hasGrid: true
      onFinish:(obj) -> # callback, is called on every change
        $(".edit").removeClass('disabled')
    $("#desired-age-slider").ionRangeSlider
      prettify: false
      hasGrid: true
      onFinish:(obj) -> # callback, is called on every change
        $(".edit").removeClass('disabled')

  $("#tab-family").click (e) ->
    $("#family-income-slider").ionRangeSlider
      prettify: false
      hasGrid: true
      onFinish:(obj) -> # callback, is called on every change
        $(".edit").removeClass('disabled')

  $('.superbox').SuperBox()
  $(".superbox-list").click ->
    currentimg = $(this).find(".superbox-img")
    $("#imageid").attr("value", currentimg.attr("id"))
    return