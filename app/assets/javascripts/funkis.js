$(document).on('turbolinks:load', function () {
    if (isShiftSignupPage()) {
        window.selectedShifts = {};

        $('.shift-btn').click(toggleShift);
        $('.shift-btn.red').click();
        updateShiftList();
    }
});

function isShiftSignupPage() {
    return $('.shift-signup-container').length > 0;
}

function toggleShift() {
    var button = $(this);
    var shift = getShiftIdFromButton(button);
    var previouslyChosen = isShiftChosen(shift);

    setButtonState(button, !previouslyChosen);

    if (previouslyChosen) {
        delete window.selectedShifts[shift];
    } else {
        window.selectedShifts[shift] = createShiftFromButton(button);
    }

    updateShiftList();
}

function setButtonState(button, chosen) {
    if (chosen) {
        button.addClass('red');
        button.text('Valt');
    } else {
        button.removeClass('red');
        button.text('Välj');
    }
}

function isShiftChosen(shift) {
    return shift in window.selectedShifts;
}

function getShiftIdFromButton(button) {
    return button.parent().find('.shift-id').val();
}

function getShiftNameFromButton(button) {
    return button.parent().parent().parent().parent().parent().parent().find('.funkis-name').text();
}

function getDayFromButton(button) {
    return button.parent().parent().find('.shift-day').text();
}

function getTimeFromButton(button) {
    return button.parent().find('.shift-time').text();
}

function getPointsFromButton(button) {
    return button.parent().find('.shift-points').val();
}

function createShiftFromButton(button) {
    return {
        'id': getShiftIdFromButton(button),
        'name': getShiftNameFromButton(button),
        'day': getDayFromButton(button),
        'time': getTimeFromButton(button),
        'points': getPointsFromButton(button),
        'button': button
    }
}

function updateShiftList() {
    clearArticleList();

    var points = 0;
    var hasShifts = false;
    for (var key in window.selectedShifts) {
        var shift = window.selectedShifts[key];
        points += appendShift(shift, shift['name'] + '<br/>' + shift['day'] + '<br/>' + shift['time'], parseInt(shift['points']));
        hasShifts = true;
    }

    if (hasShifts) {
        appendTotalPoints(points);
    } else {
        appendShift(null, 'Inga pass valda', 0);
    }

    updateSignupSummary();
}

function appendShift(shift, name, points) {
    var row = $('<tr/>');
    row.append($('<td/>').html(name));

    if (points > 0) {
        var removeButton = $('<button class="btn red">Ta bort</button>');
        removeButton.click(toggleShift.bind(shift['button']));

        row.append($('<td/>').text(points.toString() + ' poäng'));
        row.append($('<td/>').append(removeButton));
    }

    if (shift != null) {
        row.append($('<input type="hidden" name="funkis_shift_applications_attributes[][iter]" value="1">'));
        row.append($('<input type="hidden" name="funkis_shift_applications_attributes[][funkis_shift_id]" value="' + shift['id'] + '" />'));
    }

    $('#article-list').append(row);

    return points;
}

function appendTotalPoints(points) {
    var row = $('<tr/>');
    row.append($('<th/>').text(t()['orchestra']['register']['summary_total']));
    row.append($('<th/>').text(points.toString() + ' poäng'));

    $('#article-list').append(row);
}
