$(document).on('turbolinks:load', function () {
    var phoneField = $("#cortege_contact_phone");
    phoneField.on("input change", updateContactPhone);

    updateContactPhone.bind(phoneField)();
});

function updateContactPhone() {
    var number = $(this).val();
    if (number.length == 0) {
        $('#contact_phone_missing').show();
        $('#contact_phone').hide();
    } else {
        $('#contact_phone_missing').hide();
        $('#contact_phone').text(number).show();
    }
}
