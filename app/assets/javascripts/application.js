// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery.ui.tabs
//= require bootstrap-datepicker/core
//= require selectize
//= require dropzone
//= require jquery.inputmask
//= require gritter
//= require private_pub


$(document).ready(function($) {
  /*===============================
  =            SOCKETS            =
  ===============================*/
  PrivatePub.subscribe("/messages/"+$("#user").data("id"), function(data, channel) {
  	dt = data.data
  	$.gritter.add({ image: dt.img, title: dt.title, text: '<a class="txt-color-white" href="/profiles/'+dt.profile_id+'">view profile</a>' });
  });
  /*-----  End of SOCKETS  ------*/

});

