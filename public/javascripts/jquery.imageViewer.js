new function($) {
	$.fn.imageViewer = function(in_data, options) {
	  var container = $(this);
	  
	  
    var defaults = {
      "arrow_left":"/images/lt.png",
      "arrow_right":"/images/rt.png"
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
		
	 	var image2 = $('<img>').addClass('lastActiveImage');
		
		var image = $('<img>').addClass('activeImage');
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
      
      var oldUrl = image.attr('src')
      
      if (oldUrl){
        image2.attr('src', oldUrl).css('opacity', 1.0)
        
        var newDom = $('<img>').addClass('activeImage').attr('src', newImg).css('opacity', 0.0)
        
        image.before(newDom)
        image.remove()
        
        image = newDom
          .appendTo(container)
          .animate({'opacity':1.0}, 3000)
        
        setTimeout(function(){
          image2.animate({'opacity':0.0}, 1000)
        }, 1000)
      }else{
        image.attr('src', newImg)
      }
			
			if(defaults["callback"]){
			  defaults["callback"](data[i])
			}
		}
		
		function showArrows(){
			var topArrowMargin = (container.height()-40)/2;
			
			arrowLeft.css({top:topArrowMargin+'px'})//.show()
			arrowRight.css({top:topArrowMargin+'px', right:'5px'})//.show()
		}
		
		function showOverlay(){
		  $('.hud', this).show();
		  
		  if(in_data.length > 1){
		    $('.arrows', this).show();
		  }
		}
		
		function updateCredits(){
			overlayText.text(data[i]['credit'])
		}
		
		function hideOverlay(){
			$('.hud, .arrows', this).hide();
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