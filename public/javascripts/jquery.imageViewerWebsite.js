new function($) {
    $.fn.imageViewerWebsite = function(in_data, options) {
      var container = $(this);
       
       
    var defaults = {
      "arrow_left":"/images/handle-small-left.png",
      "arrow_right":"/images/handle-small-right.png",
      'sensetiveContainer':false
    };
           
      $.extend(defaults, options)
       
        if(in_data.length == 0){
            return;
        }
         
      $("*", container).remove();
         
        container.css({'position':'relative'})
         
        var data = in_data;
         
        $.each(data, function(i, item){
          var img = new Image(1,1);
          img.src = item['url']
        })
         
        var i = 0;
         
        var timeout;
         
        var image2 = $('<a>').addClass('lastActiveImage').attr('rel', 'leghtbox');
         
        var image = $('<a>').addClass('activeImage').attr('rel','leghtbox').html('<img>');
        var overlay = $('<div></div>').addClass('imageViewerOverlay').addClass('hud').hide();
        var overlayText = $('<div></div>').addClass('imageViewerOverlayText').addClass('hud').hide();
         
        var arrowLeft = $('<img>').attr('src', defaults["arrow_left"]).
          addClass('imageViewerOverlayArrowLeft').addClass('arrows').hide().click(toLeft);
           
        var arrowRight = $('<img>').attr('src', defaults["arrow_right"]).
          addClass('imageViewerOverlayArrowRight').addClass('arrows').hide().click(toRight);
         
      container
          .empty()
          .append(image2, image, overlay, overlayText, arrowLeft, arrowRight)
          .mouseover(showOverlay).mouseout(hideOverlay)
          .addClass('imageViewerContainer')
           
        if(defaults["sensetiveContainer"]){
        container.parent().mouseover(showOverlay).mouseout(hideOverlay)
        }
           
        updateImage();
        updateCredits();
         
         
        if(in_data.length > 1){
      showArrows()
      autoNext()
        }
         
        function autoNext(){
          timeout = setTimeout(toRight, 10000)
        }
         
        function updateImage(){     
          image.stop(true,true);
          image2.stop(true,false);
      var newImg = data[i]['url']
      var newImg_maximum = data[i]['maximum_url']
      var oldUrl = image.attr('href')
       
      if (oldUrl){
        var leftMargin = (container.width() - image.width() ) / 2;
        image2.attr('href', oldUrl).css('opacity', 1.0).css('left', leftMargin)
         
        var newDom = $('<a>').addClass('activeImage').attr('href', newImg_maximum).attr('rel','lightbox').html('<img src="'+newImg+'">').css('opacity', 0.0)
         
        image.before(newDom)
        image.remove()
         
        image = newDom
          .appendTo(container)
          .animate({'opacity':1.0}, 1500)
         
        setTimeout(function(){
          image2.animate({'opacity':0.0}, 650)
        }, 500)
      }else{
        image.attr('href', newImg_maximum).attr('rel','lightbox').html('<img src="'+newImg+'">');
      }
             
            if(defaults["callback"]){
              defaults["callback"](data[i])
            }
        }
         
        function showArrows(){
            var topArrowMargin = (container.height()-40)/2;
             
            arrowLeft.css({bottom:'31px', left: '-9px'})//.show()
            arrowRight.css({bottom:'31px', right:'-9px'})//.show()
        }
         
        function showOverlay(){
          if($.trim(overlayText.text()) != ""){
        $('.hud', container).show().css('bottom', '25px');
      }
           
          if(in_data.length > 1){
            $('.arrows', container).show();
          }
        }
         
        function updateCredits(){
            overlayText.text(data[i]['credit'])
             
            if($.trim(data[i]['credit']) == ""){
              $('.hud', container).hide();
            }else if($('.arrows:visible', container).length > 1){
              $('.hud', container).show();
            }
        }
         
        function hideOverlay(){
            $('.hud, .arrows', container).hide();
        }
         
        function toLeft(){
          clearTimeout(timeout)
            --i;
             
            if(i < 0){
                i = data.length - 1;
            }
            updateImage();
            updateCredits();
             
            if(in_data.length > 1){
              autoNext();
          }
        }
         
        function toRight(){
          clearTimeout(timeout)
           
            ++i;
            if(i >= data.length){
                i = 0;
            }
            updateCredits();
             
            if(in_data.length > 1){
              autoNext();
          }
           
          updateImage();
             
      // alert('ok')
        }
         
    }
}(jQuery);