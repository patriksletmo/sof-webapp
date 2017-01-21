/**
 * Created by lukas on 2017-01-15.
 */

var isNavActive = false;
var activeNav;
var activeNavActivator;

document.addEventListener('turbolinks:load', function () {
    // Initialize collapse button
    $('.button-collapse').sideNav();

    $('#contactNavActivator').sideNav();

    $('#testNavActivator').sideNav();


    $('#contactNavActivator').mouseenter(function () {
        if (!isActiveNav('contactNav') && isNavActive) {
            deactivateActiveNav();
        }

        activateNav('contactNav', 'contactNavActivator');

    });

    $('#contactNav').mouseleave(function () {
        if (isNavActive) {
            $('#contactNavActivator').sideNav('hide');
            setTimeout(function () {
                $('#contactNav').addClass('hide');
            }, 75);
            isNavActive = false;
        }
    });

    // Initialize collapsible (uncomment the line below if you use the dropdown variation)
    $('.collapsible').collapsible();
});

var activateNav = function (navId, activatorId) {
    document.getElementById(activatorId).sideNav('show');
    activeNavActivator = activatorId;
    document.getElementById(navId).removeClass('hide');
    activeNav = navId;
    isNavActive = true;
};

var isActiveNav = function (navId) {
    return document.getElementById(navId).id == activeNav.id;
};

var deactivateActiveNav = function () {
    if (isNavActive) {
        activeNav.addClass('hide');
        setTimeout(function () {
            activeNavActivator.sideNav('hide');
        }, 75);
        isNavActive = false;
        activeNav = null;
        activeNavActivator = null;
    }
};

