document.addEventListener('turbolinks:load', function () {
    $("table.highlight tbody > tr").click(function() {
        var href = $(this).data("href");
        if (href != undefined) {
            window.document.location = href;
        }
    });


});

$(document).on('turbolinks:load', function () {
    $('#query-field').focus();
});
