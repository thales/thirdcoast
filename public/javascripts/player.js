var popupID = $.cookie('popupID');

if(!popupID){
    popupID =0;
}

++popupID
// For accessing URL parameters.
function gup( name )
{
  name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
  var regexS = "[\\?&]"+name+"=([^&#]*)";
  var regex = new RegExp( regexS );
  var results = regex.exec( window.location.href );
  if( results == null )
    return "";
  else
    return results[1];
}

function parse_hash_param( )
{
	switch(window.location.hash) {
		case '#story':
		  return 0;
		case '#producer':
		  return 1;
		case '#extra':
		  return 2;
		case '#comments':
		  return 3;
		default:
		  return 0;
	}
	
}

$(document).ready(function() {
	if ($(window).height() < $(document).height()) {
		window.resizeTo(638, parseInt($(document).height()));
	}
  $('.sectionWrapper .section').hide();
 	$('.sectionWrapper h2').addClass('inactive');
 	$('.sectionWrapper').addClass('inactiveStroke');
  var sectionNumber = parse_hash_param();
  $('.sectionWrapper .section:eq('+sectionNumber+')').show();
  $('.sectionWrapper h2:eq('+sectionNumber+')').addClass('active').parent().addClass('activeStroke').removeClass('inactiveStroke');
  $('.sectionWrapper h2').click(function() {
		var section = $(this).next('.section');
	
  	if (!$(this).hasClass('active')) {
	    section.slideDown().removeClass('inactive');
	    $(this).addClass('active');
	    $(this).parent().removeClass('inactiveStroke').addClass('activeStroke');
			
			var sectionText = $.trim(section.text());
					
			if(sectionText == ''){
				section.html('&nbsp;')
			}
		
  	}
		else {
	    $(this).removeClass("active").addClass("inactive");
	    section.slideUp()
	    $(this).parent().removeClass('activeStroke').addClass('inactiveStroke');
		} 

  	return false;
  });



	// ---------------OpenStory-----------------------------------------------
  $('.openstory').toggle(function() {
  $('.sectionWrapper .section:eq(0)').slideDown('slow');
  $('.sectionWrapper h2:eq(0)').addClass('active').parent().addClass('activeStroke').removeClass('inactiveStroke');
  },function(){
    $('.sectionWrapper .section:eq(0)').slideUp('slow');
    $('.sectionWrapper h2:eq(0)').removeClass('active').parent().addClass('inactiveStroke').removeClass('activeStroke');
  });
	// -----------------------------------------------------------------------
	// ---------------OpenProducer--------------------------------------------
  $('.openproducer').toggle(function() {
  $('.sectionWrapper .section:eq(1)').slideDown('slow');
  $('.sectionWrapper h2:eq(1)').addClass('active').parent().addClass('activeStroke').removeClass('inactiveStroke');
  },function(){
    $('.sectionWrapper .section:eq(1)').slideUp('slow');
    $('.sectionWrapper h2:eq(1)').removeClass('active').parent().addClass('inactiveStroke').removeClass('activeStroke');
  });
	// -----------------------------------------------------------------------
	// ------------------OpenExtra--------------------------------------------
	$('.openextra').toggle(function() {
  $('.sectionWrapper .section:eq(2)').slideDown('slow');
  $('.sectionWrapper h2:eq(2)').addClass('active').parent().addClass('activeStroke').removeClass('inactiveStroke');
  },function(){
    $('.sectionWrapper .section:eq(2)').slideUp('slow');
    $('.sectionWrapper h2:eq(2)').removeClass('active').parent().addClass('inactiveStroke').removeClass('activeStroke');
  });
	// -----------------------------------------------------------------------
	// ---------------OpenComments--------------------------------------------
  $('.opencomments').toggle(function() {
  $('.sectionWrapper .section:eq(3)').slideDown('slow');
  $('.sectionWrapper h2:eq(3)').addClass('active').parent().addClass('activeStroke').removeClass('inactiveStroke');
  },function(){
    $('.sectionWrapper .section:eq(3)').slideUp('slow');
    $('.sectionWrapper h2:eq(3)').removeClass('active').parent().addClass('inactiveStroke').removeClass('activeStroke');

  });
	// -----------------------------------------------------------------------

	$('.new_comment_link a').click(function(){
		var dom = $('#new_comment').clone();
		
		$('.new_comment_chars_count', dom).after( $('<div id="recaptcha_container">') )
		
		$.facebox(dom)
		
		$('#facebox').css('left', 40)
		
		dom.show();
		
		$('input', dom).placeholder();
		
		$('form', dom).submit(function(){
			submit_comment(this);
			return false;
		});

		$('#comment_comment', dom).keyup(recount_in_comment).change(recount_in_comment)
		
		
		Recaptcha.create('6LeURwkAAAAAAKdykUvcD1Ic09AfmSSbOm-iX_50', 'recaptcha_container')
		return false;
	});
	
	function recount_in_comment(){
	  var chars = $(this).val().length;
	  
	  var left = 140 - chars;
	  
	  $('.new_comment_chars_count_integer').text(left);
	};
	
	function submit_comment(form){
		var data = $(form).serializeArray();
		
		if($('#comment_comment', form).hasClass('placeholder')){
			data[1]['value'] = '';
		}
		
		if($.trim(data[1]['value']) == ''){
			 alert("Oops, You can't post an empty comment!");
			 return false
		}
		
		$('#comment_submit', form).attr('disabled', true);
		
		$.post('/library/'+player_id+'/comments', data, function(data, status){
			Recaptcha.reload('r');
			$('#comment_submit', form).attr('disabled', false);
			
			if(data == '--bad captcha--'){
				alert('Oops, words you entered didn\'t match captcha you entered');
				return false;
			}
			
			$('#jq_comment_link').text('Add new comment');
			
			$(document).trigger('close.facebox');
			$('#comment_comment', form).val('');
			recount_in_comment()
			
			var dom = $(data).prependTo('#comments').effect("highlight", {}, 3000);
			
			var newBottomLine = dom.offset().top + dom.height() + 5;
			var totalHeight = $(window).height();
			var scroll = newBottomLine - totalHeight;
			$().scrollTop(scroll);
			
		})

		return false;
	};
	
	$('a:not(.recaptchatable *)').live('click', function(){    
	  if($.inArray( $(this).attr('rel'), ['file', 'share', 'playerPopup'] ) > -1){
	    return true
	  }
	  
		url = $(this).attr('href');
		if($(this).attr('rel') != 'facebox' || url=='#' || url[0] == '#'){
			if(window.opener && isLocalLink(url)){
				window.opener.location.href = url;
				window.opener.focus();
			}else{
				window.open(url)
			}
		}
		return false;
	});
  
   // $('#play_share').click(function(){
   //   var content = $('.share_container:first').clone().show();
    
  //   $.facebox(content)
    
  //   $('#facebox').css('left', 210);
  //   $('#facebox .body').css('width', 150);
    
   //  return false
   // })
  
  $('.downloadable #play_download').click(function(){
    window.location.href = $(this).attr('rel')
  });
  
  $('#play_print').click(function(){
    var windowName = "popup" + popupID;
    var win = window.open(window.location+'/print', windowName, "width=800,height=650,scrollbars=yes");
    ++popupID;
    $.cookie('popupID', popupID);
    
    return false
  });
});

function isLocalLink(url){
  if(url[0] == "/" || url.match(/^http:\/\/(|www\.)thirdcoastfestival.org/) ){
    return true
  }else{
    return false
  }
}