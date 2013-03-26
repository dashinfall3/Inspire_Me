$(document).ready(function(){
  var $container = $('#container');
  $container.imagesLoaded(function(){
    $container.masonry({
      columnWidth: 1,
      isAnimated: true,
      isFitWidth: true
    });
  });

    var chooseButton = new Button;
    chooseButton.connect("#file_field_button", "#file_field");
    
    var upload = new Button;
    upload.connect("#photo_upload_button", ".btn");

    var vote = new Button;
    vote.connect('.star', '.vote-button');

    var photo = new Image;
    photo.choose("#file_field");

    $('.image').hover(
      function(){
        $('.star').show();
      },
      function(){
        $('.star').hide();
      }

    );

});

function Button() {};

Button.prototype.connect = function(selector1, selector2) {
  $(selector1).click(function(){
    $(selector2).click();
  });
};

function Image() {};

Image.prototype.choose = function(selector) {
  $(selector).val('').change(function(){
    $("#file_field_button").hide();
    $('#caption').show();
    $('#photo_upload_button').show(); 
  }); 
};


