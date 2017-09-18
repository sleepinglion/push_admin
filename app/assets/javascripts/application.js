// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap/alert
//= require bootstrap/modal

$(document).ready(function(){
$('#myModal').on('hidden.bs.modal', function () {
    $(this).removeData('bs.modal');
});

$('.modal_link').click(function(event){
  event.preventDefault();
  $('#myModal').removeData("modal");
  $('#myModal').load($(this).attr('href')+'?no_layout=true',function(){
    $('#myModal').modal();
  });
});
});
