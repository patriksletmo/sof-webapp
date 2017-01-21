/**
 * Created by lukas on 2017-01-15.
 */

var isNavActive = false;
var activeNav;
var activeNavActivator;

var activateNav = function (navId, activatorId) {
    $('#' + activatorId).sideNav('show');
    activeNavActivator = activatorId;
    $('#' + navId).removeClass('hide');
    activeNav = navId;
    isNavActive = true;
};

var isActiveNav = function (navId) {
    if (activeNav != null) {
        return navId == activeNav.id;
    } else {
        return false
    }

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


document.addEventListener('turbolinks:load', function () {
    // Initialize collapse button
    $('.button-collapse').sideNav();

    $('#contactNavActivator').sideNav();

    $('#testNavActivator').sideNav();


    $('#contactNavActivator').mouseenter(function () {
        //window.alert('hej');
        if (!isActiveNav('contactNav') && isNavActive) {
            window.alert('deactivate');
            deactivateActiveNav();
        }
        activateNav('contactNav', 'contactNavActivator');
    });

    $('#testNavActivator').mouseenter(function () {
        if (!isActiveNav('testNav') && isNavActive) {
            deactivateActiveNav();
        }
        activateNav('testNav', 'testNavActivator');
    });

    $('.secondary-nav').mouseleave(function () {
        if (isNavActive) {
            isNavActive = false;
            $(activeNavActivator).sideNav('hide');
            setTimeout(function () {
                $(activeNav).addClass('hide');
            }, 75);
        }
    });

    // Initialize collapsible (uncomment the line below if you use the dropdown variation)
    $('.collapsible').collapsible();
});



