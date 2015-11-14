function createCookie(name, value, days) {
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    else expires = "";
    document.cookie = name + "=" + value + expires + "; path=/";
}

$(document).on('page:change', function () {
    $('.fav').click(function () {
        $.ajax({
            url: "/recipes/toggle/" + $(this).attr("id"),
            type: "GET",
            success: function (text) {
                $(".fav").attr('src', "/assets/" + text);
            }
        });
        return false;
    });

    $('#search-form').submit(function () {
        if ($('#search-field').val().length < 1) {
            return false;
        }
    });

    $("h4.box a.close").click(function () {
        createCookie('nopost', '1', 60);
        $(this).parent("h4.box").fadeOut();
        return false;
    });

});

