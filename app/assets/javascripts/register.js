/**
 * Created by Jacob on 2017-01-28.
 */


$(document).on('turbolinks:load', function () {
    $("#orchestra_code").on("input change",validateOrchestraCode);

});

function togglePossibleTshirt(){

    var tshirt = document.getElementById('select-selected-tshirt');
    var gender = document.getElementById('switch-gender');

    // checked = Female
    if(gender.checked){
        tshirt[tshirt.length-1].disabled = true;
    } else {
        tshirt[tshirt.length-1].disabled = false;
    }
}

function toggleSpecialkost(e) {
    var target = document.getElementById('field-specialfood');
    if (e.checked) {
        target.disabled = false;
        target.focus();
    } else {
        target.disabled = true;
    }
}

function addTshirt() {
    var target = document.getElementById('collection-of-tshirts');
    var tshirt = document.getElementById('select-selected-tshirt');
    var gender = document.getElementById('switch-gender');
    var size = tshirt.value;

    if(target.childNodes.length > 4){
        return;
    }

    var Tshirt_gender
    if(gender.checked){
        Tshirt_gender = "Female ";
    } else {
        Tshirt_gender = "Male "
    }

    var entry =  document.createElement('li');
    var inpt = document.createElement('input');
    inpt.name = "tshirt[]";
    inpt.type = "hidden";
    inpt.value = Tshirt_gender + size;

    entry.onclick = function () {
        this.parentElement.removeChild(this);
    }

    if(Tshirt_gender == "Female " && size == "XXL") {
        return;
    } else {

        size = Tshirt_gender + size;
        sizeNode = document.createTextNode(size);
        inptNode = document.createTextNode(inpt);
        entry.appendChild(sizeNode);
        entry.appendChild(inpt);
        target.appendChild(entry);
    }
}

function orchestaCodeValid(){
    var target = document.getElementById('valid_orchestra_code');
    var targetText = document.getElementById('valid_orchestra_code_label');
    target.disabled = false;
    target.checked = true;
    targetText.innerHTML = "Din kod är giltig";
    target.disabled = true;
}

function orchestraCodeInvalid() {

    var target = document.getElementById('valid_orchestra_code');
    var targetText = document.getElementById('valid_orchestra_code_label');
    target.disabled = false;
    target.checked = false;
    targetText.innerHTML = "Kunde inte hitta din orkester";
    target.disabled = true;
}

function validateOrchestraCode() {
    $.ajax({
        type: 'GET',
        url: '/orchestra/verify?code=' + this.value,
        dataType: 'json',
        success: orchestaCodeValid,
        error: orchestraCodeInvalid
    });
}