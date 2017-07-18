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
//= require jquery-ui
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  $('#navcart').on('click',function(event){
    event.preventDefault();
    $('#cart').slideToggle(500);
  });
});  

$(document).on('turbolinks:load', function() {
  $('#list').click(function(event){
    event.preventDefault();$('.products .columns').removeClass('col-xs-4 col-lg-4 grid');
    $('.products .columns').addClass('col-xs-12 col-lg-12 list');});
  $('#grid').click(function(event){
    event.preventDefault();$('.products .columns').removeClass('col-xs-12 col-lg-12 list');
    $('.products .columns').addClass('col-xs-4 col-lg-4 grid');});
});