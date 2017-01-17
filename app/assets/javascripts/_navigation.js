/**
 * Created by lukas on 2017-01-15.
 */

document.addEventListener('turbolinks:load', function () {
    // Initialize collapse button
    $('.button-collapse').sideNav(
    );

    var navcontrol = $('.nav-control');

    var sidenavActive;
    var sidenavVisibility;
    var mouseoverMainnav = false;

    navcontrol.sideNav({
        closeOnClick: true
    });

    navcontrol.hover(function () {
        mouseoverMainnav = true;
        sidenavActive = setTimeout(function () {
            if ($('#secondary-nav:hidden')) {
                navcontrol.sideNav('show');
            }
        }, 300);
        sidenavVisibility = setTimeout(function () {
            $('#secondary-nav').removeClass('hide');
        }, 200);
    }, function () {
        mouseoverMainnav = false;
        clearTimeout(sidenavActive);
        clearTimeout(sidenavVisibility);

        sidenavActive = setTimeout(function () {
            if ($('#secondary-nav:visible')) {
                navcontrol.sideNav('hide');
            }
        }, 200);
        sidenavVisibility = setTimeout(function () {
            $('#secondary-nav').addClass('hide');
        }, 300);
    });

    $('#secondary-nav').hover(function () {
        clearTimeout(sidenavActive);
        clearTimeout(sidenavVisibility);
    }, function () {
        sidenavActive = setTimeout(function () {
            if (!mouseoverMainnav) {
                if ($('#secondary-nav:visible')) {
                    navcontrol.sideNav('hide');
                }
            }
        }, 75);
        sidenavVisibility = setTimeout(function () {
            if (!mouseoverMainnav) {
                $('#secondary-nav').addClass('hide');
            }
        }, 150);

    });

    // Initialize collapsible (uncomment the line below if you use the dropdown variation)
    $('.collapsible').collapsible();
});