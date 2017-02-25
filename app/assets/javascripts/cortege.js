$(document).on('turbolinks:load', function () {
    var phoneField = $("#cortege_contact_phone");
    phoneField.on("input change", updateContactPhone);

    if (phoneField.length > 0) {
        // Only update the initial value if we actually found any element
        updateContactPhone.bind(phoneField)();
    }
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
