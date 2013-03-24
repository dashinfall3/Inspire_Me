// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// var Photo = {
//   init: function(){
//     $('form.new_photo').on('ajax:success', this.appendPhoto);
//     $('form.new_photo').on('ajax:error', this.showErrors);
//   },

//   appendPhoto: function(event, data){
//     debugger
//     $('.photos').append(data);
//   },

//   showErrors: function(xhr, data, status) {
//     debugger
//     $('.photos').append(data);
//   }

// }



$(document).ready(function(){
  var $container = $('#container');
  $container.imagesLoaded(function(){
    $container.masonry({
      columnWidth: 1,
      isAnimated: true,
      isFitWidth: true
    });
  });

  $("#file_field_button").click(function(){
    $("#file_field").click();
  });

  $("#photo_upload_button").click(function(){
    $(".btn").click();
  });

  $("#file_field").val('').change(function(){
    $("#file_field_button").hide();
    $('#caption').show();
    $('#photo_upload_button').show(); 
  });
});
