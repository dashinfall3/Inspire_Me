// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var Photo = {
  init: function(){
    $('#photo-button').on('ajax:success', this.appendPhoto);
  },

  appendPhoto: function(event, data){
    debugger
    $('.photos').append(data);
  }

}


$(document).ready(function(){
  Photo.init();
});
