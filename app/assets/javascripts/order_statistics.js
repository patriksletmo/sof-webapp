var selectedStatsParam = null; // Will be overwritten if not null.

$(document).on('turbolinks:load', function () {
    var sum = window.location.search.indexOf('sum') != -1;

    $('#stat-params-select').change(function() {
        var search = '?parameter=' + $(this).val();
        if (sum) {
            search += '&sum=true';
        }

        window.location.search = search;
    });

    $('#sum-switch').change(function() {
        if ($(this).prop('checked')) {
            if (selectedStatsParam != null) {
                window.location.search = '?parameter=' + selectedStatsParam + '&sum=true';
            } else {
                window.location.search = '?sum=true'
            }
        } else {
            if (selectedStatsParam != null) {
                window.location.search = '?parameter=' + selectedStatsParam;
            } else {
                window.location.search = '';
            }
        }
    });
});
