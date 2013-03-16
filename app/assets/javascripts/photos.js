// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var Photo = {
  init: function(){
    $('form.new_photo').on('ajax:success', this.appendPhoto);
    $('form.new_photo').on('ajax:error', this.showErrors);
  },

  appendPhoto: function(event, data){
    debugger
    $('.photos').append(data);
  },

  showErrors: function(xhr, data, status) {
    debugger
    $('.photos').append(data);
  }

}


$(document).ready(function(){
  Photo.init();
});
