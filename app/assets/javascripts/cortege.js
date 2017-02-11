$(document).on('turbolinks:load', function () {
    $("#cortege_contact_phone").on("input change", updateContactPhone);
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
