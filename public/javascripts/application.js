var SHOW_BETA_POPUP = false;

$(document).ready(function() {
    $('.store_item_container select').combobox({"width":148})
	
    //if ($('#donate-popup')) $('#donate-popup').enable_popup();
    //if ($('#donate-popup-2')) $('#donate-popup-2').enable_popup();

    if(isMobile()){
      $('#main_menu_wrapper, #searchPlaceholderText').addClass('iphone')
    }
    
    $('#searchPlaceholderText').click(function(){
      $(this).hide();
      
      $('#q').focus();
    })
    
    $('#q').blur(function(){
      if( $.trim($(this).val()) == "" ){
        $('#searchPlaceholderText').show();
      }
    })
      .focus(function(){
        $('#searchPlaceholderText').hide()
      })
    
    $('<a>')
      .attr('href', '/')
      .attr('id', 'pigeon_head_link')
      .appendTo('#main_menu_wrapper')
      
    $('<a>')
      .attr('href', '/')
      .attr('id', 'pigeon_text_link')
      .appendTo('#main_menu_wrapper')
     
    
    $('a[rel*=facebox]').livequery(function(){
      $(this).facebox();
    })
        
    if( $('.tag_cloud').length > 0){
      var tag_cloud_default_height = 84;
      var original_heigth = $('.tag_cloud').css('height', 'auto').height()
      
      if(original_heigth > tag_cloud_default_height){
        $('.tag_cloud').css('height', tag_cloud_default_height+'px')
        
        $('#tags_expand_collapse').click(function(){
          var height = $('.tag_cloud').css('height')

          if(height != tag_cloud_default_height+'px'){
            $('.tag_cloud').animate({'height':tag_cloud_default_height+'px'},1000)
            $(this).text('(more tags)').addClass('tagsExpander');
          }else{
            // $('.tag_cloud').css('height', 'auto')
            var new_height = $('.tag_cloud').css('height', 'auto').height()

            $('.tag_cloud').css('height', tag_cloud_default_height+'px')

            $('.tag_cloud').animate({'height':new_height},1000)
            $(this).text('(fewer tags)').addClass('tagsExpander');
          }

        })
        
      }else{
        $('#tags_expand_collapse').remove();
      }
    }
    
    $("a[href^='/library']").livequery(function(){
      if( $(this).attr('href').match(/\/library\/([\d]+)/) ){
        $(this).attr('rel', 'playerPopup')
        
        if( $.trim($(this).attr('class')) == ""){ //so no other styling exists
          $(this).addClass('playerPopupLink')
        }
      }
    })
    
    $('#store_continue_shopping').livequery('click', function(){
      $(document).trigger('close.facebox');
      return false;
    })
  
    $('input').placeholder({
        'blankSubmit':true
    });
    
    $('#facebox form.ajaxed').livequery('submit', function(){
      var url = $(this).attr('action');

      var args = $(this).serializeArray()

      $.post(url, args, function(data, status){
        $.facebox(data);
      })
      return false;
    })
    
    var popupID = $.cookie('popupID');
    
    if(!popupID){
        popupID =0;
    }
	
    function openPlayerPopup(item){
        var windowName = "popup" + popupID;

        var xPos = Math.random(10) * 100
        var yPos = Math.random(10) * 100
        
        // var win = window.open($(item).attr('href'), windowName, "width=10, height=10, scrollbars=yes");
        window.open($(item).attr('href'), windowName, "width=638, height=480, scrollbars=yes, left=" + xPos + ", top=" + yPos);
        ++popupID;
        
        $.cookie('popupID', popupID);

        

        // win.moveTo(parseInt(xPos), parseInt(yPos))
        // alert(parseInt(xPos));

        return false;
    }

    $('a[rel="playerPopup"]').live("click", function(){
        openPlayerPopup(this);
        return false;
    })

    if(!isMobile()){
      $('#library_filters_order_by').combobox({"width":148})
    }
    
    $('#library_filters_order_by').bind('change', function(){
      var url = library_order_url_base + $(this).val()

      url = url.replace(/order(|\/)$/, "")



      var form = $('<form>')
          .attr('action', url)
          .attr('method', 'get')
          .hide()
          .appendTo('body')
          .submit()
    });
	
    $('.add_to_playlist').live('click', function(){
        var id = $(this).attr('alt');
		
        var existing = $('#playlist #piece_in_playlist_'+id)
		
        if(existing.length > 0){
            existing.parent().effect('highlight', {color:"#5a9a98"}, 3000)
        }else{
            var title = $(this).attr('title');
			
            var curr_cookie = $.cookie('playlist');
			
            if(!curr_cookie){
                curr_cookie = '';
            }
			
            curr_cookie += '||'+id+'---'+title+'||';
			    
            $.cookie('playlist', curr_cookie)
            
            add_song_to_playlist(id, title)
        }
		
        return false;
    });
	
    function add_song_to_playlist(id, title, no_effect){
        var item = $('<a></a>').text(title).addClass('piece_in_playlist')
          .attr({
              'href':'/library/'+id,
              'id':'piece_in_playlist_'+id
          })
          .click(function(){
              $(this).parent().slideUp(1000, function(){
                $(this).remove();
                
                if($('#playlist_songs li').length == 0){
                  $('<p>').attr('id','playListIntro').addClass('playListIntroTxt').hide()
                    .text(intro_txt)
                    .prependTo('#playlist').slideDown(1000)
                }
              });
              
              var curr_cookie = $.cookie('playlist');
              var token = '||'+id+'---'+title+'||';
				
              curr_cookie = curr_cookie.replace(token, '')
              
              
              $.cookie('playlist', curr_cookie)
              
      			  
				
              openPlayerPopup(item);
				
              return false;
          })
        
        $('#playListIntro').slideUp(1000, function(){
          $(this).remove()
        })
			
        var li = $('<li></li>').append(item).appendTo('#playlist_songs')
        
        if(!no_effect){
          li.effect('highlight', {color:"#5a9a98"}, 3000);
        }
    }
	
    var curr_cookie = $.cookie('playlist');
	
	  var intro_txt = $('#playListIntro').text();
	
    if(curr_cookie){
        curr_cookie = curr_cookie.split('||');
		    
        if(curr_cookie.length > 0){
		      $.each(curr_cookie, function(i, item){
              if(item != ''){
                  params = item.split('---')
                  add_song_to_playlist(params[0], params[1], true)
              }
          })
          
          $('#playListIntro').remove();
        }
		
    }
    
	
    $("input#producer_name").autocomplete("auto_complete_for_producer_name")
    $(function() {
        $("#datepicker").datepicker();
    });

    $('.calendar_month_link').live("click", function(){
        var url = $(this).attr('href');
      
        $.get(url, {}, function(data){
            $('#calendar_mainblock').html(data["main"]);
            
            $('.month_link', $('#small_menu')).remove();
            
            $('#small_menu').prepend(data["sidebar"]);
        }, "json")
      
        return false;
    })

    $('.calendar_block_day_has_events, .calendar_block_day_has_deadlines').live("click", function(){
        var day = $(this).attr('alt');
        
        var offset = $(".event_block_for_day_"+day+":first").offset().top - 5;
      
        $(document).scrollTop(offset);
    })
    
    $('#release_pigeons').click(showMovie)
    
    var global_player_id = 0;
    
    $('a[rel=mini_player]').livequery(function(){
      global_player_id += 1;
      var id = global_player_id;
      $(this).addClass('player_mini')
      var isPlaying = false;
      var original_link = $(this);
      
      var player_container = $('<span id="player_'+id+'">').addClass('playContainer')
      var icon = $('<div>').addClass('icon');
      
      original_link.append(icon)
      original_link.append(player_container)
      
      var pre_length = secsToNice( parseInt( $(this).attr('pre_length') ) * 1000 )
      
      var tooltip = $('<div>')
        .addClass('mini_player_tooltip')
        .html('00:00/'+pre_length )
      
      $(this).after(tooltip)
      
      
      var player;
      
      player_container.jPlayer({
        ready: function () {
          player = this;
        
          setTimeout(function(){
            player.setFile(original_link.attr('href'))
          }, 1000)
        },
        oggSupport: false,
        swfPath: "/javascripts"
      })
        .jPlayer('onProgressChange', function(loadPercent, playedPercentRelative, playedPercentAbsolute, playedTime, totalTime){
        if(loadPercent < 100){
          var msg = secsToNice(playedTime)+"/"+pre_length;
        }else{
          var msg = secsToNice(playedTime)+'/'+secsToNice(totalTime);
        }

        tooltip.html(msg);
      });
      
      $(this).click(function(){
        if(isPlaying){
          player.pause();
          isPlaying = false;
        }else{
          player.play();
          isPlaying = true;
        }

        original_link.toggleClass('paused')
        return false;
      })

    })
    
    if(!isMobile()){
      $('.main_menu a').hover(
        function(){
          if($(this).attr('alt') != ""){
            if(!$(this).data('original_title')){
              $(this).data('original_title', $(this).html() );
            }

            $(this).html( $(this).attr('alt') );
          }
          $(this).removeClass('regular')
        },
        function(){
          if($(this).data('original_title') != ""){
            $(this).html( $(this).data('original_title') )
          }
          $(this).addClass('regular')
        }
      )
    }
    
    $('.producers-index-alphabet a').click(function(){
      $('.producers-index-alphabet a').removeClass('selected_link')
      $(this).addClass('selected_link')
      $('.no_features_found').remove()
      
      
      var container = $('.content-block-wrapper')
      
      var letter = $(this).text().toLowerCase();
      
      var columns = $('.producers-column')
      
      columns.each(function(i, el){
        var items = $("li", el);
        
        $( items.slice(0, 30) ) .fadeOut(1500, function(){
          $(this).remove();
        });
        
        $( items.slice(30, items.length) ).remove();
      })
      
      var selected_producers = $.grep(producers, function(item, index){
        if(letter == '#'){
          return (item[1][0].match( /[0-9\!\@\#\$\%\^\&\*\?\<\>]/ ) )
        }else{
          return (item[1][0].toLowerCase() == letter)
        }
      })
      
      if(selected_producers.length ==0){
        $('<div class="no_features_found">No producers matched your criterias</div>').appendTo('.producers-index')
        container.hide();
        return;
      }
      
      container.show();
      
      
      var per_part = parseInt(Math.floor( selected_producers.length / 3.0 ))
      
      var left = selected_producers.length - per_part*3;
      left1 = 0;
      left2 = 0;
      
      if(left == 1){
        left1 = 1;
      }else if(left == 2){
        left1 = 1;
        left2 = 1;
      }
      
      part1_from = 0
      part1_end = per_part + left1
      
      part2_from = part1_end
      part2_end = part2_from + per_part + left2
      
      part3_from = part2_end
      part3_end = selected_producers.length
      
      var part1 = selected_producers.slice(part1_from, part1_end).reverse()
      var part2 = selected_producers.slice(part2_from, part2_end).reverse()
      var part3 = selected_producers.slice(part3_from, part3_end).reverse()
      
      $.each([part1, part2, part3], function(list_i, list){        
        var column = columns[list_i];
        
        $.each(list, function(i, item){
          var block = $('<li>');
          
          var link = $('<a>').text(item[1]).attr('href', '/library/producers/'+item[2]).appendTo(block)
          
          if(list.length - i > 30){
            block.prependTo(column);
          }else{
            block.hide().prependTo(column).fadeIn(1500)
          }
        })
      });
      // 
      // selected_producers = []
      // 
      // $.each(part1, function(i, item){
      //   if(part1[i]) selected_producers.push( part1[i] )
      //   if(part2[i]) selected_producers.push( part2[i] )
      //   if(part3[i]) selected_producers.push( part3[i] )
      // })
      // 
      // selected_producers = selected_producers.reverse()
      // 
      // $.each(selected_producers, function(i, item){        
      //   var block = $('<div class="content-block-wrapper"><div class="content-wrapper producer"></div></div>');
      //   
      //   var link = $('<a>').text(item[1]).attr('href', '/library/producers/'+item[2])
      //   
      //   $('.producer', block).append( link )
      //   
      //   if(selected_producers.length - i > 30){
      //     block.show();
      //   }else{
      //     block.hide().prependTo(container).fadeIn(1500)
      //   }
      // })
      
      return false;
    })
        
    if(SHOW_BETA_POPUP && $('#main_menu-home').length > 0 && $.cookie('betaPopup') != "1"){
      $.cookie('betaPopup', "1", {expires: 365})
      $.facebox('<img src="/images/3C-announcement-page_1.png">');
      $('#facebox').hide()
      // $('#facebox').addClass('facebox_custom');
      
      $(window).bind('resize', positionBetaOnWindowResize)
      
      setTimeout(function(){
        $(window).trigger('resize')
        setTimeout(function(){
          $('#facebox').css('opacity',0).show().animate({opacity:1.0}, 500)
        }, 100)
      }, 500)
      
    }
    
  $('#credits_footer_link').click(function(){
      //Credits popup text
      $.facebox("Website design by <a href=\"http://faustltd.com\">faustltd.com</a>.<br>\
      Content by <a href=\"http://thirdcoastfestival.org\">Third Coast International Audio Festival</a>.<br>\
      Development by <a href=\"http://www.linkedin.com/pub/mohammad-abed/6/269/968\">Mohammad Abed</a>")

    $('#facebox').addClass('credits_footer');

    })
});

$.fn.enable_popup = function()
{
	return this.each(function(){
		var ele = this;
		var height = parseInt($(document).height()) > parseInt($(window).height()) ? $(document).height() : $(window).height();
		$('#page-cover').height(height);
		$(ele).parent().show().animate({opacity:0}, 0);
    $(ele).parent().animate({opacity:1}, 1000);
		// $(ele).find('h1, h2, p').show().css('text-indent', 0);

		
		$('.close a', ele).click(function(){
			// $.cookie('alreadybegged', true, {expires:365});
			$(ele).parent().animate({opacity:0}, 250, function(){
				$(this).hide();
			});
			return false;
		});
		setTimeout(function() {
			$(ele).parent().animate({opacity:0}, 250, function(){
				$(this).hide();
			});
		}, 10000);	
		
	});
}

var positionBetaOnWindowResizeTimer = null;

function positionBetaOnWindowResize(){
  if (positionBetaOnWindowResizeTimer) clearTimeout(positionBetaOnWindowResizeTimer);
  
  positionBetaOnWindowResizeTimer = setTimeout(function(){
    var box = $('#facebox');
    var xCenterize = ( $(window).width() - box.width() ) / 2
    var yCenterize = ( $(window).height() - box.height() ) / 2
    
    var yMin = $('#homNavHeader').offset().top + $('#homNavHeader').height() - 15;
    
    if(yCenterize < yMin) yCenterize = yMin;
    
    box.animate({'left': xCenterize, 'top': yCenterize}, 1000)
  }, 100);
}

var last_clicked_link = null;

function showMovie(){
  var container = $('<div id="movieContainer">').addClass('movieContainer');
  
  container.appendTo('body')
  
  flowplayer("movieContainer", {src:"/flowplayer/flowplayer-3.1.5.swf", wmode: 'transparent'}, { 
        autoPlay:true,
        buffering : true,
        play: {opacity: 0},
        playlist: [
          {
            url:"/flash/movie.flv",
            onBeforeFinish: function(){  
                return false; 
            },
            onStart: function(){
              setTimeout(function(){
                $('#movieContainerLoading').remove();
              }, 1000)
            }
          }
        ],
        plugins:  { 
          controls: {             
            all:false,
            height: 1,
            width: 1,
            autoHide: 'always'             
          }
        }
      } 
  );
  
  var loading = $('<div id="movieContainerLoading">').addClass('movieContainer');
  
  var size = ($(window).height() / 2) - 10;
  
  loading.html('<img src="/images/preparing-for-takeoff.png" />').css('padding-top', size+'px').addClass('piegonsMovie');
  
  loading.appendTo('body')
  
  var overlay = $('<div id="movieContainerOverlay">').addClass('movieContainer');
  
  overlay.appendTo('body')
  overlay.click(hideMovie)

}

function hideMovie(){
  $('.movieContainer').remove()
  
  $('body').css('overflow', 'auto')
}

function secsToNice(mili, separator){
  if(!separator){
    separator = ":"
  }
  
  seconds = parseInt(mili / 1000);
  
  minutes = Math.floor(seconds / 60)
  
  seconds = seconds - minutes*60;
  
  if(seconds < 10){
    seconds = '0'+seconds
  }
  
  if(minutes < 10){
    minutes = '0'+minutes
  }
	
	return minutes + separator + seconds;
}

function isMobile(){
  var uagent = navigator.userAgent.toLowerCase();
  
  if (uagent.search("android") > -1 || uagent.search("iphone") > -1 ||uagent.search("ipod") > -1){
    return true
  }else{
    return false
  }
}
