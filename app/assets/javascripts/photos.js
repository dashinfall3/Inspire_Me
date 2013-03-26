$(document).ready(function(){
  var $container = $('#container');
  $container.imagesLoaded(function(){
    $container.masonry({
      columnWidth: 1,
      isAnimated: true,
      isFitWidth: true
    });
  });
  $('#share-button').click(function() {
    $('#share-mobile').toggle();
  });

  $('#share-mobile, .twitter-button').click(function() {
    $('#share-mobile').hide();
  });

    var chooseButton = new Button;
    chooseButton.connect("#file_field_button", "#file_field");
    
    var upload = new Button;
    upload.connect("#photo_upload_button", ".btn");

    var vote = new Button;
    vote.connect('.star', '.vote-button');

    var photo = new Image;
    photo.choose("#file_field");

    var chooseButtonMobile = new Button;
    vote.connect('#file_field_button_mobile', '#file_field_mobile');

    var uploadMobile = new Button;
    upload.connect("#photo_upload_button_mobile", ".btn_mobile");

    var photoMobile = new Image;
    photo.chooseMobile("#file_field_mobile");

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
    $('.btn').click();
    $('#myModal').modal();
  });   
};

Image.prototype.chooseMobile = function(selector) {
  $(selector).val('').change(function(){
    $('.btn_mobile').click();
    $('#myModal').modal();
  }); 
};
