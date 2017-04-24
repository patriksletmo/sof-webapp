document.addEventListener('turbolinks:load', function () {
    // Initialize collapse button
    $('.button-collapse').sideNav({
        draggable: false,
        menuWidth: 275
    });

    // Initialize collapsible
    $('.collapsible').collapsible();

    var countdownDate = new Date('April 25, 2017 00:00:00').getTime();

    function updateCountdown() {
        var now = new Date().getTime();
        var distance = countdownDate - now;

        var days = Math.floor(distance / (1000 * 60* 60 * 24));
        var hours = Math.floor((distance % (1000 * 60* 60 * 24)) / (1000 * 60 * 60));
        var minutes = Math.floor((distance % (1000 * 60* 60)) / (1000 * 60));
        var seconds = Math.floor((distance % (1000 * 60)) / 1000);

        document.getElementById('countdown').innerHTML = days + 'd ' + hours + 'h ' + minutes + 'm ' + seconds + 's';

        if (distance < 0) {
            clearInterval(x);
            $('#countdown-description').hide();
            document.getElementById('countdown').innerHTML = '<a class="white-text" style="font-size: 20px; background: #772761;" href="/store">Köp din biljett här!</a>';
        }
    }

    updateCountdown();
    var x = setInterval(updateCountdown, 1000);
});


