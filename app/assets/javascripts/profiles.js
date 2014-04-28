$(document).on("page:change", function() {
  $( "#tabs" ).tabs();
  pageSetUp();

  $("[id^=side]").click(function() {
    $("#hidden-" + this.id)[0].click();
  });

  selectize_items = {
    home:true,
    religion: true,
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
    manglik: true,
    sun_sign: true,
    moon_sign: true,
    nakshatra:{
      create: true
    },
    hobby: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace'],
      delimeter: ","
    },
    interest: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    music: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    read: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    dress: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    tv: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    movie: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    sport: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    cuisine: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    vacation: {
      maxItems: 10,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    father: true,
    mother: true,
    brother: true,
    sister: true,
    profile_handler: true,
    school: {
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    grad_college: {
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    graduation: {
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    post_grad: {
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    post_grad_college: {
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    highest_degree: {
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    desired_country: {
      maxItems: 2,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    desired_city: {
      maxItems: 2,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    desired_religion: true,
    desired_caste: {
      maxItems: 3,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    desired_mother_tongue:{
      maxItems: 3,
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    desired_education: {
      create:true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
    desired_occupation:{
      create: true,
      plugins: ['remove_button', 'restore_on_backspace']
    },
  };

  $(".close-edit-modal").click(function() {
    $("#hidden-side-myprofile")[0].click();
  });
  $(".open-edit-modal").click(function() {
    reinit_family_range_slider();
    reinit_desire_range_slider();
  });


  get_and_populate_selectize()
  function get_and_populate_selectize() {
    $.ajax({
      url: '/profiles/get_selectize',
      type: 'POST',
    })
    .success(function(data) {
      select_profile_edit_items = data.data;
      populate_selectize()
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
          plugins:     options.plugins ? options.plugins : [],
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
  $(".interest").click(function() {
    $(this).html('<i class="fa fa-check"></i>Done!')
    $(this).addClass('disabled');
  });
  $(".edit").click(function() {
    // $(".edit").removeClass('btn-info');
    // $(".edit").addClass('btn-success');
    $(this).removeClass('btn-info');
    $(this).addClass('btn-success');
    $(this).addClass('disabled');
  });
  $('form.edit').bind("keyup change", function(e) {
    show_save_button($(this));
  });

  function show_save_button (el) {
    el.find(':submit').html('<i class="fa fa-save"></i> Save');
    el.find(':submit').removeClass('btn-success');
    el.find(':submit').removeClass('disabled');
    el.find(':submit').addClass('btn-info');
  }

  $('form.edit').submit(function() {
    $(this).find(':submit').html('<i class="fa fa-check"></i>Done!');
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

  /*======================================
  #=            Set up Sliders
  #======================================*/
  $("#tab-desire").click(function(e) {
    reinit_desire_range_slider();
  });

  function reinit_desire_range_slider() {
    $("#desired-income-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        show_save_button($(".edit"))
      }
    });
    $("#desired-height-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        show_save_button($(".edit"))
      }
    });
    $("#desired-age-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        show_save_button($(".edit"))
      }
    });
  }

  $("#tab-family").click(function(e) {
    reinit_family_range_slider();
  });

  function reinit_family_range_slider() {
   $("#family-income-slider").ionRangeSlider({
    prettify: false,
    hasGrid: true,
    onFinish: function(obj) {
      show_save_button($(".edit"))
    }
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
  $(".dropzone").dropzone({
    paramName: "avatar",
    maxFilesize: 2,
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


