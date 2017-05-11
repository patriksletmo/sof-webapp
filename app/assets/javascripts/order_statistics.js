var selectedStatsParam = null; // Will be overwritten if not null.

$(document).on('turbolinks:load', function () {
    var sum = window.location.search.indexOf('sum') != -1;

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
