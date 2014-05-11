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
// require jquery.ui.all
//= require jquery.ui.tabs
// require parsley
//= require bootstrap-datepicker/core
// require parsley.extend
//= require selectize
// require jquery.remotipart
//= require dropzone
//= require jquery.inputmask
// require jquery.inputmask.extensions
// require jquery.inputmask.numeric.extensions
// require jquery.inputmask.date.extensions
// require angular
//  require dataTables/jquery.dataTables
//  require dataTables/jquery.dataTables.bootstrap3
// require bootstrap-tagsinput
// require twitter/typeahead
//= require gritter
//= require websocket_rails/main



$(document).ready(function($) {
  /*===============================
  =            SOCKETS            =
  ===============================*/

  pathArray = window.location.href.split( '/' );
  protocol = pathArray[0];
  host = pathArray[2];
  url = protocol + '//' + host + "/websocket";
  var dispatcher = new WebSocketRails(url);
  // var channel = dispatcher.subscribe('socket_user_'+$("#user").data("id"));
  var channel = dispatcher.subscribe("channel_name");
  channel.bind('event', function(data) {
    $.gritter.add({ image: data.img, title: data.title, text: '<a class="txt-color-white" href="/profiles/'+data.profile_id+'">view profile</a>' });
  });
  channel.bind('visitor', function(data) {
    $.gritter.add({ image: data.img, title: data.title, text: '<a class="txt-color-white" href="/profiles/'+data.profile_id+'">view profile</a>' });
  });
  channel.bind('interest', function(data) {
    $.gritter.add({ image: data.img, title: data.title, text: '<a class="txt-color-white" href="/profiles/'+data.profile_id+'">view profile</a>' });
  });
  channel.bind('accepted', function(data) {
    $.gritter.add({ image: data.img, title: data.title, text: '<a class="txt-color-white" href="/profiles/'+data.profile_id+'">view profile</a>' });
  });
  channel.bind('rejected', function(data) {
    $.gritter.add({ image: data.img, title: data.title, text: '<a class="txt-color-white" href="/profiles/'+data.profile_id+'">view profile</a>' });
  });

  /*-----  End of SOCKETS  ------*/

});

