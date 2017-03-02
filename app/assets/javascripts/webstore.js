document.addEventListener('turbolinks:load', function () {
    $('.shop-item').each(function() {
        var shopItem = $(this);
        shopItem.find('.card-action-text').click(function() {
            var anyEmpty = shopItem.find('select').is(function() {
                return $(this).val() == null || $(this).val() == '';
            });

            if (!anyEmpty) {
                shopItem.find('form').submit();
            } else {
                Materialize.toast('Du måste välja en typ först', 2000);
            }
        });
    });
});