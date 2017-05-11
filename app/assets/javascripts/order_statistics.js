$(document).on('turbolinks:load', function () {
    function loadNewPage() {
        window.location.search = '?parameter=' + $('#stat-params-select').val() + '&sum=' + $('#sum-switch').prop('checked') + '&date=' + $('#set-date-field').val();
    }

    $('#stat-params-select').change(loadNewPage);
    $('#sum-switch').change(loadNewPage);
    $('#set-date-field').change(loadNewPage);

    $('#reset-date-field').click(function() {
        $('#set-date-field').val(null);
        loadNewPage();
    });
});
