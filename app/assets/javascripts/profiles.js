$(document).on("page:change", function() {
  var css_id, key, name, obj, options, selectize_items, val, value, _ref;
  pageSetUp();
  $("#tabs").tabs();
  $("[id^=side]").click(function() {
    console.log(this);
    return $("#hidden-" + this.id)[0].click();
  });
  selectize_items = {
    religion: true,
    mother_tongue: {
      create: true
    },
    caste: true,
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
    nakshatra: true,
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
      create: true
    },
    desired_city: {
      create: true
    },
    desired_religion: true,
    desired_caste: true,
    desired_mother_tongue: true,
    desired_education: true,
    desired_occupation: true
  };
  for (name in selectize_items) {
    options = selectize_items[name];
    css_id = name.replace(/_/g, "-");
    val = $('#select-' + css_id).val();
    if (val) {
      _ref = val.split(",");
      for (key in _ref) {
        value = _ref[key];
        gon.select_profile_edit_items[name].push({
          title: value
        });
      }
    }
    if (typeof gon !== 'undefined' && gon.select_profile_edit_items) {
      obj = $("#select-" + css_id).selectize({
        maxItems: options.maxItems ? options.maxItems : 1,
        valueField: options.valueField ? options.valueField : "title",
        labelField: options.labelField ? options.labelField : "title",
        searchField: options.searchField ? options.searchField : "title",
        options: gon.select_profile_edit_items[name],
        create: options.create ? options.create : false,
        plugins: options.plugins ? options.plugins : [],
        delimeter: options.delimeter ? options.delimeter : ",",
        render: {
          option: function(item, escape) {
            var desc;
            desc = item.desc ? item.desc : "";
            return '<div> <strong>' + item.title + '</strong><br><small>' + desc + '</small></div>';
          }
        }
      });
    }
  }
  Dropzone.autoDiscover = false;
  $(".dropzone").dropzone({
    init: function() {}
  });
  Dropzone.options.myDropzone = {
    dictDefaultMessage: '<div class="hero" style="height:500px;"><h2>Drag & Drop</h2><p>or click to upload images</p></div>',
    paramName: "avatar",
    maxFilesize: 2,
    addRemoveLinks: false,
    acceptedFiles: ".jpeg,.jpg,.png,.gif,.JPEG,.JPG,.PNG,.GIF",
    thumbnailWidth: 300,
    thumbnailHeight: 300,
    init: function() {
      return this.on('addedfile', function(file) {});
    }
  };
  $(".phone").inputmask("mask", {
    "mask": "(999) 9999-999-999"
  });
  $(".interest").click(function() {
    return $(this).hide();
  });
  $(".edit").click(function() {
    return $(this).addClass('disabled');
  });
  $('form').change(function() {
    return $(".edit").removeClass('disabled');
  });
  $('form.smart-form').submit(function() {
    var jq_superbox_remov;
    $.smallBox({
      title: "Done !",
      content: "<i class='fa fa-clock-o'></i> <i>You selection was made ..</i>",
      color: "#296191",
      iconSmall: "fa fa-thumbs-up bounce animated",
      timeout: 2000
    });
    jq_superbox_remov = $("#imageid").attr("value");
    $("#" + jq_superbox_remov).remove();
    $(".superbox-list").removeClass("active");
    return $(".superbox-current-img").animate({
      opacity: 0
    }, 200, function() {
      $(".superbox-show").slideUp();
    });
  });
  $("#tab-desire").click(function(e) {
    console.log("desire");
    $("#desired-income-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        return $(".edit").removeClass('disabled');
      }
    });
    $("#desired-height-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        return $(".edit").removeClass('disabled');
      }
    });
    return $("#desired-age-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        return $(".edit").removeClass('disabled');
      }
    });
  });
  $("#tab-family").click(function(e) {
    return $("#family-income-slider").ionRangeSlider({
      prettify: false,
      hasGrid: true,
      onFinish: function(obj) {
        return $(".edit").removeClass('disabled');
      }
    });
  });
  $('.superbox').SuperBox();
  return $(".superbox-list").click(function() {
    var currentimg;
    currentimg = $(this).find(".superbox-img");
    $("#imageid").attr("value", currentimg.attr("id"));
  });
});
