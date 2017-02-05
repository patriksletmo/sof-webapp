document.addEventListener('turbolinks:load', function () {
    // Initialize collapse button
    $('.button-collapse').sideNav({
        closeOnClick: true,
        draggable: false
    });

    // Initialize collapsible
    $('.collapsible').collapsible();
});



