/*
    Functions used to fill the interface with and some control elements categories.
*/

// Link to the category list of photos
function category_link(category) {
    return '<a href="/images_category/' + category + '">' + category + '</a>'
}

// Link to delete a category
function category_delete(category) {
    var id = $('#image-show').attr('value');
    return '<a href="/delete_category/' + category + '/' + id + '" data-method="delete" rel="nofollow">[x]</a>';
}

// GET request to retrieve the list of all categories
function get_all_categories() {
    $.ajax(
        { url : '/categories.json',
         dataType : 'json',
            success : function(data) {

                var list = '<ul>'
                for (var i=0; i < data.length; i++)
                {
                    list += '<li>' + category_link(data[i]) + '</li>';
                }
                list += '</ul>';

                $('#all-categories').html(list)
            },
            error : function (e) { }
        });
}

function get_image_categories()
{
    var id = $('#image-show');

    if (id.html() == null) return;

    $.ajax({ url : '/image_categories/' + id.attr('value') + '.json',
         dataType : 'json',
            success : function(data) {

                var list = '<ul>'
                for (var i=0; i < data.length; i++)
                {
                    list += '<li>' + category_link(data[i]) + category_delete(data[i]) + '</li>';
                }
                list += '</ul>';

                $('#image-categories').html(list)
            },
            error : function (e) { alert(JSON.stringify(e)); }
    });
}

function add_category()
{
    var cat = $('#new-category').attr('value');
    var id = $('#image-show').attr('value');

    if (cat != "") {
        var post_url = '/create_category/' + cat + '/' + id;
        $.ajax(
                { url : post_url,
                  type : 'POST',
                  data : {}
                }
        );

        get_all_categories();
        get_image_categories();

        $('#new-category').attr('value','');
    }
}

// Retrieve all categories and add some hooks for keyboard control
$(document).ready( function(){

    get_all_categories();
    get_image_categories();

    // Keyboard based controls for entering tags
    $('body').keydown(function(event) {
      if (event.keyCode == 13) { // Enter
         add_category();
         event.preventDefault();
      }

      if (event.keyCode == 37) { // Left arrow
        var linkto = $('#image-previous').attr('href');
        if (linkto != null) document.location.href = linkto;
      }

      if (event.keyCode == 39) { // Right Arrow
        var linkto = $('#image-next').attr('href');
        if (linkto != null) document.location.href = linkto;
      }
    });

    $('#add-category a').click( function(e) {
        add_category();
    });

});