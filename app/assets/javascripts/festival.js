
document.addEventListener('turbolinks:load', function () {
    $('a[href*=\\#]').on('click', function (event) {
        event.preventDefault();
        $('html,body').animate({scrollTop: $(this.hash).offset().top}, 300);
    });

    function setSchedule() {
        var img_id = $(this).val();
        $('.schedule-img').each(function () {
            if (this.id === ('schedule-' + img_id)) {
                $(this).css('display', 'inline-block');
            } else {
                $(this).hide();
            }
        });
    }

    document.getElementById("schedule-select").onchange = setSchedule;
});
