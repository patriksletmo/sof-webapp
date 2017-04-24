$(document).on('turbolinks:load', function () {
    function createActiveCheckbox() {
        var parent = $('<div class="col s1 margin-top-40"></div>');
        var actual = $('<input type="hidden" name="item[products_attributes][][enabled]" value="1">');
        var checkbox = $('<input class="filled-in" type="checkbox" checked disabled>');
        var label = $('<label>Aktiv</label>');

        parent.append(actual);
        parent.append(checkbox);
        parent.append(label);

        return parent;
    }

    function createInput(name, variable, type, size) {
        var inputName = 'item[products_attributes][][' + variable + ']';
        var container = $('<div class="col s12 m' + size + ' l' + size + '"></div>');
        var label = $('<label>' + name + '</label>');
        var input = $('<input type="' + type + '" name="' + inputName + '">');

        container.append(label);
        container.append(input);

        return container;
    }

    $('#add-variant-btn').click(function(e) {
        e.preventDefault();

        var parent = $('<div class="row"></div>');

        parent.append(createInput('Namn', 'kind', 'text', '3'));
        parent.append(createInput('Pris (SEK)', 'cost', 'number', '2'));
        parent.append(createInput('Maxantal per person (0 = oändligt)', 'purchase_limit', 'number', '3'));
        parent.append(createInput('Maxantal (0 = oändligt)', 'max_num_available', 'number', '2'));
        parent.append(createActiveCheckbox());

        var deleteButton = $('<div class="col s1 margin-top-32"><button class="btn red"><i class="icon-bin2"></i></button></div>');
        deleteButton.click(function(e) {
            e.preventDefault();

            parent.remove();
        });
        parent.append(deleteButton);

        $('#variant-container').append(parent);
    });

    $('.remove-existing-variant').click(function(e) {
        e.preventDefault();

        var row = $(this).parent().parent();
        row.find('.destroy-field').val(1);
        row.hide();
    });

    $('.checkbox-value').each(function() {
        var actual = $(this);
        var checkbox = actual.parent().find('.filled-in');

        var changeFunction = function() {
            if (this.checked) {
                actual.val(1);
            } else if (!this.checked) {
                actual.val(0);
            }
        };

        checkbox.change(changeFunction);
        changeFunction.bind(checkbox[0])();
    });
});
