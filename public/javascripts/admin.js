var is_dragging = false;
$(document).ready(function() {
    $("input[name='primary']").bind( 'change', function() {
        $.ajax( {
            url: '/set_primary_photo',
            data: $(this).serialize(),
            success: function(msg) {
                $("#flash").text('Your update is done').show();
                notify($("#flash").text());
            }
        });
        return false;
    });

    $(function(){ // <<JQUERY after dom is loaded event
        // hide our container div
        $("#flash").hide();
        // grab flash message from our div
        var flash_content = $("#flash").html();
		
        if(!flash_content){
            flash_content = '';
        }
		
        var flash_message = $.trim(flash_content);
        // call our flash display function
        if(flash_message != "") {
            notify(flash_message);
        }
    });



    function notify(flash_message)
    {
        // jQuery: reference div, load in message, and fade in
        var flash_div = $("#flash");
        flash_div.html(flash_message);
        flash_div.fadeIn(500);
        // use Javascript timeout function to delay calling
        // our jQuery fadeOut, and hide
        setTimeout(function(){
            flash_div.fadeOut(500, function(){
                flash_div.html("");
                flash_div.hide()
            })
        },
        1400);
    }
    
    $('.store_photo_primary').change(function(){
        var id = $(this).val();
        url = $.url.attr('path')+'/'+id+'/primary';
		
        $.get(url)
    })

    $('#features_filters_filter_by').change(function(){
        if($(this).val() == ''){
            $('#filter_by_'+$(this).val()).hide();
            return false;
        }
        $('#filter_by_container > div').hide();
        $('#filter_by_'+$(this).val()).show();
    });

    $('#filter_by_collections a').live("click", function(){
        var url = $(this).attr('href');
        var collection = $.url.setUrl(url).param("collection") || "";
        $('#features_filters_collection').val(collection);
        $('#features_filters').submit();
        return false;
    });

    $('#features_filters_order_by').change(function(){
        $('#features_filters').submit();
    });
    
    $('#features-alphabet a').click(function(){
        var letter = $(this).text();
        $('#features_filters_begin_with').val(letter);
        $('#features_filters').submit();
        return false;
    });

    $('#reset_filters').click(function(){
        $('#features_filters_begin_with').val('');
        $('#features_filters_collection').val('');
        $('#features_filters_order_by').val('')
        $('#features_filters').submit();
    })

    $('#page_preview').click(function(){
      //CKEditor/jQuery content updating hack.
      $.each(CKEDITOR.instances, function(number, el){
        el.updateElement();
      })
      
      var textareas_content = [];
      
      $('textarea').each(function(i, item){
        textareas_content.push( $(item).val() );
      })
      
      var form = $('form').clone();
      
      $('textarea', form).each(function(i, item){
        $(item).val ( textareas_content[i] )
      })
        
      form.attr('target', '_blank').attr('action', '/pages/'+page_id+'/preview')
        .appendTo($('body'))
        .submit()
        .remove();
            
      return false;
    })

    
    $('textarea.ckeditor-panel').each(function(i, item){
        var name = $(item).attr('name');
        var container = $(item).parent()
        var size = container.width();
        
        if(size > 635){
            size = 635;
        }
        
        container.css('width', '800px').css('float','auto')
      
        CKEDITOR.addStylesSet( 'my_styles',
            [
            {
                name : 'Body Text',
                element : 'p',
                attributes : {
                    'class' : 'text'
                }
            },
            {
                name : 'Body Text2',
                element : 'p',
                attributes : {
                    'class' : 'bodyText2'
                }
            },
            {
                name : 'Intro Text',
                element : 'p',
                attributes : {
                    'class' : 'lg-courier-text'
                }
            },
            {
                name : 'Headline',
                element : 'h1',
                attributes : {
                    'class' : 'header'
                }
            },
            {
                name : 'Subhead 1',
                element : 'h2',
                attributes : {
                    'class' : 'subheader'
                }
            },
            {
                name : 'Subhead 2',
                element : 'h3',
                attributes : {
                    'class' : 'subhead2'
                }
            }
            ]);
      
        CKEDITOR.replace(name, {
            stylesCombo_stylesSet: 'my_styles',
            contentsCss: "/stylesheets/home.css",
            height:"300",
            colorButton_colors:"000000,A9A9A9,ee2e24,0075E2,5a9a98,4CAAF1,483C32,00395a",
            width:"650",
            toolbar_Easy:[
                  ['Source','-','Preview','Templates'],
                  ['Cut','Copy','Paste','PasteText','PasteFromWord'],
                  ['Maximize','-','About'],
                  ['Undo','Redo','-','Find','Replace','-','SelectAll','RemoveFormat'],
                  ['Styles'],
                  ['Bold','Italic','Underline','Strike','-','Subscript','Superscript', 'TextColor'],
                  ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
                  ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
                  ['Link','Unlink','Anchor'],
                  ['Image','Embed','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
              ],
            filebrowserUploadUrl: '/ckeditor/create?kind=file',
            filebrowserImageUploadUrl: '/ckeditor/create?kind=image'
        });
        
        $.each([1000, 2000, 3000, 4000, 5000, 7000, 10000], function(i, item){
            setTimeout(function(){
                $('iframe', container).width(size);
            }, item)
        })
    })

    $('#reorder_menu_items').click(function(){
      $('#menu_items_table').addClass('enabled')
      $(this).hide()
      $('#new_menu_item_link').hide();
      $('#reorder_menu_items_cancel, #reorder_menu_items_save').show();
      
      $('#menu_items_table *').removeClass('not_published');
      
      $('#menu_items_table .draggable').draggable({
        revert: true,
        start: function(){
          is_dragging = true
        },
        stop: function(){
          is_dragging = false
        }
      })
      
      $('#menu_items_table .menu_item_item')
        .each(function(i, item){
            var inner_item = $(item).find('a, b, span')
            
            var text = inner_item.text()
            
            $(item).append(text)
            
            $(inner_item).remove()
        })
        .hover(
          function(){
            if(!is_dragging){
              $(this).parent().addClass('draggable_hover')
            }
          },
          function(){
            $(this).parent().removeClass('draggable_hover')
          }
        )
      
      $("#menu_items_table .menu_item_item[locked=1]").each(function(i, item){
        $('<img>').attr('src', '/images/lock.png').appendTo(item);
      })
        
      $('#menu_items_table .draggable')
        .droppable({
          greedy: true,
          hoverClass: 'droppableOverDraggable',
          accept: function(dragged){
            var parent_id = $(this).attr('page_id')
            
            if( $(".menu_item_item", dragged).attr('locked') == "1" && parent_id != $(dragged).attr('parent_id') ){
              return false;
            }else{
              return true;
            }
            
          },
          tolerance: 'pointer',
          drop: function(event, ui){
            page_move_into(ui.helper, this)
          }
        })
        
      redo_spacing();
      
      $('#reorder_menu_items_save').click(function(){
        $(this).attr('disabled', true)
        
        var relations = {};
        
        var i = 0;
        
        $('#menu_items_table .draggable').each(function(i, item){
          ++i;
          
          var self_id = $(item).attr('menu_item_id')
          var parent_id = $(item).parent().attr('menu_item_id')
          
          if(!parent_id){
            parent_id = ""
          }
          
          relations[self_id] = {"parent": parent_id, "weight": i};
        })
        
        var form = $('<form>')
          .attr('method', 'post')
          .attr('action', '/admins_panel/menu/reorder_save')
          .css('display', 'none')
          .appendTo('body')

        $.each(relations, function(i, item){
          $('<input>')
            .attr('name', 'menu_items['+i+'][weight]')
            .val(item["weight"])
            .appendTo(form)
          
          $('<input>')
            .attr('name', 'menu_items['+i+'][parent]')
            .val(item["parent"])
            .appendTo(form)
        })
        
        form.submit()
        
      })
    })
    
    function redo_spacing(){
      $('#menu_items_table .spacing').remove()
      
      $('#menu_items_table .menu_item_item').each(function(i, item){
        var spacing = $('<div>')
          .addClass('spacing')
          .droppable({
            greedy: true,
            accept: function(dragged){
              var parent_id = $(item).parent().attr('parent_id')
              
              if( $(".menu_item_item", dragged).attr('locked') == "1" && parent_id != $(dragged).attr('parent_id') ){
                return false;
              }else{
                return true;
              }
              
            },
            tolerance: 'pointer',
            drop: function(event, ui){
              page_move_before(ui.helper, item)
              
              redo_spacing();
            },
            hoverClass: "droppableOverSpacing"
          })
        
        $(item).before( spacing )
      })
      
    }
    
    function redo_padding(){
      $('#menu_items_table .menu_item_item').each(function(i, item){
        $(item).removeClass('odd').removeClass('even')
        
        if(i % 2 == 0){
          $(item).addClass('even')
        }else{
          $(item).addClass('odd')
        }
        
        var level = 0;
        
        var scope = $(item);
        
        while(scope.attr('id') != 'menu_items_table'){
          scope = scope.parent();
          if(scope.hasClass('draggable')){
            level++;
          }
        }
        
        var padding = '';
        
        for(i = 0; i <= (level - 2); i ++){
          padding = padding + '&nbsp;-'
        }
        
        $('.menu_item_item_padding', item).html(padding);
      })
    }
    
    function page_move_before(dragged, dropped_near){
      var dragged = $(dragged);
      var dropped_near = $(dropped_near);
      
      dropped_near.parent().before( dragged )
      
      redo_spacing();
      
      redo_padding();
      
      setTimeout(function(){
        $('.menu_item_item', dragged).effect('highlight', {}, 3000);
      }, 500)
    }
    
    function page_move_into(dragged, dropped_on){
      var dragged = $(dragged);
      var dropped_on = $(dropped_on);
      
      if(!dropped_on.hasClass('draggable')){
        dropped_on = dropped_on.parent();
      }
      
      dropped_on.append( dragged )
      
      redo_spacing();
      
      redo_padding();
      
      setTimeout(function(){
        $('.menu_item_item', dragged).effect('highlight', {}, 3000);
      }, 500)
    }
    
    $('#competition_award_feature_name').autocomplete("/admins_panel/competitions/award_feature_name")
    $('#spotlight_feature_name').autocomplete("/admins_panel/spotlights/feature_name")
    
    $('#competition_awards_reorder').click(function(){
      $('#competition_awards_reorder').hide();
      $('#competition_awards_reorder_cancel').show();
      
      $('.sortable').addClass('enabled').sortable({
        opacity: 0.8,
        tolerance: 'pointer',
        placeholder: 'placeholder'
      })
      
      $('.sortable .edit_link').remove();
      
      $('#reorder_awards_save').show().click(function(){
        $(this).attr('disabled', true)
        
        var array = $('.sortable').sortable('toArray');

        var form = $('<form>')
          .attr('method', 'post')
          .attr('action', window.location.href + '/awards/reorder_save')
          .css('display', 'none')
          .appendTo('body')

        $.each(array, function(i, item){
          $('<input>')
            .attr('name', 'awards[]')
            .val(item.replace(/sortable_/, "") )
            .appendTo(form)
        })

        form.submit()        
      })
      
      return false;
    })
    
    $('#competition_editions_reorder').click(function(){
      $('#competition_editions_reorder').hide();
      $('#reorder_editions_reorder_cancel').show();
      
      $('.sortable').addClass('enabled').sortable({
        opacity: 0.8,
        tolerance: 'pointer',
        placeholder: 'placeholder'
      })
      
      $('.sortable a').each(function(i, item){
        var parent = $(item).parent();
        var text = $(item).text();
        parent.text( text )
        
        $(item).remove
      })
      
      $('#reorder_editions_save').show().click(function(){
        $(this).attr('disabled', true)
        
        var array = $('.sortable').sortable('toArray');

        var form = $('<form>')
          .attr('method', 'post')
          .attr('action', window.location.href + '/editions/reorder_save')
          .css('display', 'none')
          .appendTo('body')

        $.each(array, function(i, item){
          $('<input>')
            .attr('name', 'editions[]')
            .val(item.replace(/sortable_/, "") )
            .appendTo(form)
        })

        form.submit()        
      })
      
      return false;
    })

    $('#reorder_store_items').click(function(){
      $('#reorder_store_items').hide();
      $('#reorder_store_items_cancel').show();
      
      $('.sortable').addClass('enabled').sortable({
        opacity: 0.8,
        tolerance: 'pointer',
        placeholder: 'placeholder'
      })
      
      $('.sortable a').each(function(i, item){
        var parent = $(item).parent();
        var text = $(item).text();
        parent.text( text )
        
        $(item).remove
      })
      
      $('#reorder_store_items_save').show().click(function(){
        $(this).attr('disabled', true)
        
        var array = $('.sortable').sortable('toArray');

        var form = $('<form>')
          .attr('method', 'post')
          .attr('action', window.location.href + '/reorder_save')
          .css('display', 'none')
          .appendTo('body')

        $.each(array, function(i, item){
          $('<input>')
            .attr('name', 'items[]')
            .val(item.replace(/sortable_/, "") )
            .appendTo(form)
        })

        form.submit()        
      })
      
      return false;
    })
    
    $('#airing_date').datepicker({
      dateFormat: "yy-mm-dd"
    });
    
    $('#airing_feature_name').autocomplete('/admins_panel/airings/feature_name')
    
    $('#search_name').autocomplete('/admins_panel/features/autocomplete_name')
    
    $('#months_container_dropdown').change(function(){
      $('.months_container').toggle( $(this).val() != "" );
    }).trigger('change')
    
    $('.months_container a').click(function(){
      var year = $('#months_container_dropdown').val();
      
      var month = $(this).attr('alt')
      
      window.location.href = "?year="+year+"&month="+month
    })
    
    $('#event_flavor').change(function(){
      $('.event_non_deadline_only').toggle( $(this).val() != "deadline" )
    })
    
    $('#feature_photo_caption').bind('keyup', function(){
      var length = $(this).val().length
      
      $('#caption_characters_left_count').text(27 - length)
      
      if(length > 26){
        $('#caption_characters_left_count').css('color', 'red')
      }else{
        $('#caption_characters_left_count').css('color', 'black')
      }
    }).trigger('keyup')
    
    $('.allselectable').focus(function(){
        field = this
        setTimeout(function(){
            field.select();
        }, 100)
    })
});  
