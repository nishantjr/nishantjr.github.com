on_gallery_nav = function(gallery_id, target_page) {
    var old_item = $("#" + gallery_id + " .gallery-item-current")
    var new_item =
        $("#" + gallery_id + " .gallery-item:nth-child("+ target_page + ")")

    var image = $(new_item).find("img");
    var source = image.data('source');
    if (source) image.attr("src", source);

    old_item.removeClass('gallery-item-current')
    new_item.addClass('gallery-item-current')

    $("#" + gallery_id + " .gallery-nav-current")
        .removeClass("gallery-nav-current")
    $("#" + gallery_id + " .gallery-nav li:nth-child("+ target_page + ")")
        .addClass("gallery-nav-current")
}
