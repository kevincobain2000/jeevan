$(document).on("page:change", function() {
  // $( "#tabs" ).tabs();
  // pageSetUp();
  $('textarea').autosize();

  selectize_items = {
    home:true,
    religion: true,
    religion2: true,
    mother_tongue: {
      create: true
    },
    caste: {
      create: true
    },
    sub_caste: {
      create: true
    },
    native_place: {
      create: true
    },
    birth_country: {
      create: true
    },
    birth_city: {
      create: true
    },
    posted_by: true,
    marital_status: true,
    values: true,
    size: true,
    status: true,
    smoke: true,
    drink: true,
    diet: true,
    own_house: true,
    own_pet: true,
    own_car: true,
    complexion: true,
    blood_group: true,
    manglik: true,
    sun_sign: true,
    moon_sign: true,
    nakshatra:{
      create: true
    },
    hobby: {
      maxItems: 10,
      create: true,
      delimeter: ","
    },
    interest: {
      maxItems: 10,
      create: true,
    },
    music: {
      maxItems: 10,
      create: true,
    },
    read: {
      maxItems: 10,
      create: true,
    },
    dress: {
      maxItems: 10,
      create: true,
    },
    tv: {
      maxItems: 10,
      create: true,
    },
    movie: {
      maxItems: 10,
      create: true,
    },
    sport: {
      maxItems: 10,
      create: true,
    },
    cuisine: {
      maxItems: 10,
      create: true,
    },
    vacation: {
      maxItems: 10,
      create: true,
    },
    father: true,
    mother: true,
    brother: true,
    sister: true,
    family_income: true,
    profile_handler: true,
    school: {
      create: true,
    },
    grad_college: {
      create: true,
    },
    graduation: {
      create: true,
    },
    post_grad: {
      create: true,
    },
    post_grad_college: {
      create: true,
    },
    highest_degree: {
      create: true,
    },
    desired_marital_status: true,
    desired_manglik: true,
    desired_diet: true,
    desired_smoke: true,
    desired_drink: true,
    desired_complexion: true,
    desired_income: true,
    desired_height: true,
    desired_age: true,
    desired_country: {
      maxItems: 2,
      create: true,
    },
    desired_city: {
      maxItems: 2,
      create: true,
    },
    desired_religion: true,
    desired_caste: {
      maxItems: 3,
      create: true,
    },
    desired_mother_tongue:{
      maxItems: 3,
      create: true,
    },
    desired_education: {
      create:true,
    },
    desired_occupation:{
      create: true,
    },
    work_status:true,
    occupation: {
      maxItems: 1,
      create: true,
    },
    company: {
      maxItems: 1,
      create: true,
    },
    annual_income:true,
    settling_abroad:true,
  };

  $(".close-edit-modal").click(function() {
     window.location = location.href;
  });


  if ($("#user").data("id")) {
    get_and_populate_selectize();
  };
  function get_and_populate_selectize() {
    $.ajax({
      url: '/profiles/get_selectize',
      type: 'POST',
    })
    .success(function(data) {
      select_profile_edit_items = data.data;
      if (select_profile_edit_items) {
        populate_selectize()
      };
    })
  }


  function populate_selectize() {
    for (name in selectize_items) {
      options = selectize_items[name];
      css_id = name.replace(/_/g, "-");
      val = $('#select-' + css_id).val();
      if (val) {
        _ref = val.split(",");
        for (key in _ref) {
          value = _ref[key];
          select_profile_edit_items[name].push({
            title: value
          });
        }
      }

      $("#select-" + css_id).selectize({
          maxItems:    options.maxItems ? options.maxItems : 1,
          valueField:  options.valueField ? options.valueField : "title",
          labelField:  options.labelField ? options.labelField : "title",
          searchField: options.searchField ? options.searchField : "title",
          options:     select_profile_edit_items[name],
          create:      options.create ? options.create : false,
          plugins:     options.plugins ? options.plugins : ['remove_button', 'restore_on_backspace'],
          delimeter:   options.delimeter ? options.delimeter : ",",
          render: {
            option: function(item, escape) {
             var desc;
             desc = item.desc ? item.desc : "";
             return '<div>' + item.title + '<br><small>' + desc + '</small></div>';
           }
         }
       });
     }
     select_profile_edit_items = null;
  }

  $(".phone").inputmask("mask", {
    "mask": "(999) 9999-999-999"
  });
  $.extend($.gritter.options, { 
        position: 'bottom-left', // defaults to 'top-right' but can be 'bottom-left', 'bottom-right', 'top-left', 'top-right' (added in 1.7.1)
        fade_in_speed: 'medium', // how fast notifications fade in (string or int)
        fade_out_speed: 2000, // how fast the notices fade out
        time: 3000 // hang on the screen for...
  });

  $(".interest").click(function() {
    $.gritter.add({ image: $(this).data("img"), title: $(this).data("title"), text: 'Your have successfully ' + $(this).data("msg") + "<br>" +$(this).data("url") });
    // $(this).html('<i class="fa fa-check"></i> Done!')
    $(this).addClass('disabled');
  });

  $("button.edit").click(function() {
    $(this).addClass('disabled');
  });

  $('form.edit').bind("keyup change", function(e) {
    show_save_button($(this));
  });

  /*======================================
  =            Message Button            =
  ======================================*/

  $('form.message_form').bind("keyup change", function(e) {
       show_save_button($(this));
  });

  $('.message_button').click(function() {
    $(this).addClass('disabled');
  });
  $('form.message_form').submit(function(event) {
    $('.message_button').addClass('disabled');
  });

  $('form.message_form').bind("ajax:success", function(data, status, xhr) {
    current_path = window.location.pathname;
    if (status.status == 200 && $(".message_textarea").val().length != 0 ) {
      append_to_chatbody($(".message_textarea").val(), $("#user").data("img"));

      if ($("#is-on-chat") && current_path == "/messages/" + $("#is-on-chat").data("userid")) {

      } else {
        $.gritter.add({ image: $(".message_button").data("img"), title: 'Message Sent', text: 'We have notified the recipient' });
      }


    } else if (status.status == 422) {
      $.gritter.add({ image: '/assets/warning.png', title: 'Unable to send message', text: status.error });
    }

    $(".message_textarea").val("");

  });

  $('form.message_form').bind("ajax:error", function(xhr, status, error) {
    $.gritter.add({ image: '/assets/warning.png', title: 'Unable to send message', text: 'Something bad has happened' });
  });

  function append_to_chatbody(message, avatar_url) {
    current_path = window.location.pathname;
    if ($("#is-on-chat") && current_path == "/messages/" + $("#is-on-chat").data("userid")) {
      el_in_appending = $("#chat-body").children('ul');
      message = _.escape(message)
      message_html = get_message_html(message, avatar_url)
      el_in_appending.append(message_html);
      $("#chat-body").scrollTop($("#chat-list").height());
    };
  }

  function get_message_html(message, avatar_url) {
    the_msg = ""
    the_msg += '<li class="message">'
            +    '<img src="'+avatar_url+'" class="img-circle" style="width:35px;height:35px;">'
            +  '<span class="message-text">'
            +    '<time>'
            +      $.timeago(new Date())
            +    '</time>'
            +    '<a href="javascript:void(0);" class="username">You</a>'
            +    message
            +  '</span>'
            + '</li>'
            + '<hr>'
    return the_msg;
  }



    /*-----  End of Message button  ------*/

  function show_save_button (el) {
    // el.find(':submit').html('Save');
    el.find(':submit').removeClass('disabled');
  }

  $('form.edit').submit(function() {
    $.gritter.add({ image: '/assets/warning.png', title: 'Success', text: 'Your settings have been saved' });
    // $(this).find(':submit').html('Saved');
  });

  $('.superbox').on('click', '.removeimage', function() {
    remove_image();
  });


  function remove_image () {
    // For deleting images
    var jq_superbox_remov;
    jq_superbox_remov = $("#imageid").attr("value");
    $("#" + jq_superbox_remov).remove();
    $(".superbox-list").removeClass("active");
    $(".superbox-current-img").animate({
      opacity: 0
    }, 200, function() {
      $(".superbox-show").slideUp();
    });
  }

 /*-----  End of Set up Sliders  ------*/
 $('.superbox').SuperBox();
 $(".superbox-list").click(function() {
  var currentimg;
  currentimg = $(this).find(".superbox-img");
  $("#imageid").attr("value", currentimg.attr("id"));
  });


  /*=============================
  =            Hacks            =
  =============================*/
  $('form').on('focus', 'input[type=number]', function (e) {
    $(this).on('mousewheel.disableScroll', function (e) {
      e.preventDefault();
    });
  });
  $('form').on('blur', 'input[type=number]', function (e) {
    $(this).off('mousewheel.disableScroll')
  });
  /*-----  End of Hacks  ------*/

});


$(document).ready(function($) {
  Dropzone.autoDiscover = false;
  $(".images-dropzone").dropzone({
    paramName: "avatar",
    dictDefaultMessage:"<h1 class='text-center'><strong>Your Images (limit 20)</strong></h1><h3 class='text-center'>Drag and Drop Folder/Images <br> <br>or <br><br>Click to upload Images here</h3><br><br><br><br><br><br><br><br>",
    maxFilesize: 1,
    addRemoveLinks: false,
    acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF",
    thumbnailWidth: 300,
    thumbnailHeight: 300,
    init: function() {
      this.on('success', function(file, response){
        if (response.status == 422) {
          file.previewElement.classList.add("dz-error");
          _ref = file.previewElement.querySelectorAll("[data-dz-errormessage]");
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            node = _ref[_i];
            _results.push(node.textContent = response.error);
          }
          return _results;
        };
      });
    }
  });

  $(".avatar-dropzone").dropzone({
    paramName: "avatar",
    dictDefaultMessage:"<h1 class='text-center'><strong>Profile Picture</strong></h1><h3 class='text-center'>Drag and Drop Image <br> <br>or <br><br>Click to upload Images here</h3>",
    maxFilesize: 1,
    addRemoveLinks: false,
    acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF",
    thumbnailWidth: 300,
    thumbnailHeight: 300,
    init: function() {
      this.on('success', function(file, response){
        if (response.status == 422) {
          file.previewElement.classList.add("dz-error");
          _ref = file.previewElement.querySelectorAll("[data-dz-errormessage]");
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            node = _ref[_i];
            _results.push(node.textContent = response.error);
          }
          return _results;
        };
      });
    }
  });

});