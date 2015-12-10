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
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require redactor
//= require bootstrap-datepicker

$('tr').on('click', function(event) {
  event.stopPropagation();
  if(event.target.nodeName == 'TD') {
    popupId = $(this).data('popup');
    $(popupId).modal('show');
  }
});

$(document).ready(function() {
  $('.bfh-datepicker').datepicker().on('changeDate', function(event) {
    $('.bfh-datepicker').datepicker('hide');
  });
})