
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

    $("#schedule-select").change(setSchedule);

    if ($('.area-map').length > 0) {
        var mapImage = $('#area-map-img');
        var mapClone = $('#area-map-img-clone');

        function lockBottom() {
            mapImage.css('position', 'fixed');
            mapImage.css('bottom', 0);
            mapImage.css('width', mapClone.width());
        }


        $(window).on('scroll', function() {
            var imageBottom = mapImage.offset().top + mapImage.height();
            var windowBottom = window.scrollY + window.innerHeight;

            if (imageBottom <= windowBottom) {
                lockBottom();
            }
        });
    }
});
