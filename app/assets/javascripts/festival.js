
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

    (function() {
        var cards = document.querySelectorAll(".card-special");
        for ( var i  = 0, len = cards.length; i < len; i++ ) {
            var card = cards[i];
            clickListener( card );
        }

        function clickListener(card) {
            card.addEventListener( "click", function() {
                var c = this.classList;
                c.contains("flipped") === true ? c.remove("flipped") : c.add("flipped");
            });
        }
    })();
});
