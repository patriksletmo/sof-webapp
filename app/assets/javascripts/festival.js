
document.addEventListener('turbolinks:load', function () {
    $('#schedule-tab-bar').tabs({
        swipeable: true
    });

    $('a[href*=\\#]').on('click', function (event) {
        event.preventDefault();
        $('html,body').animate({scrollTop: $(this.hash).offset().top}, 300);
    });
});
