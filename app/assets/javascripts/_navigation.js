document.addEventListener('turbolinks:load', function () {
    // Initialize collapse button
    $('.button-collapse').sideNav({
        draggable: false,
        menuWidth: 275
    });

    // Initialize collapsible
    $('.collapsible').collapsible();
});



