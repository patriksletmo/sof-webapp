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

    var veg = document.getElementById('veg-box');
    var vega = document.getElementById('vegan-box');
    var lakt = document.getElementById('laktos-box');
    var gluten = document.getElementById('gluten-box');
    var sea = document.getElementById('seafood-box');
    var fish = document.getElementById('fish-box');
    var pea = document.getElementById('peanuts-box');
    if (e.checked) {
        target.disabled = false;
        veg.disabled = false;
        vega.disabled = false;
        lakt.disabled = false;
        gluten.disabled = false;
        sea.disabled = false;
        fish.disabled = false;
        pea.disabled = false;
        target.focus();
    } else {
        target.disabled = true;
        target.disabled = true;
        veg.disabled = true;
        vega.disabled = true;
        lakt.disabled = true;
        gluten.disabled = true;
        sea.disabled = true;
        fish.disabled = true;
        pea.disabled = true;
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
        Tshirt_gender = "Dam ";
    } else {
        Tshirt_gender = "Herr "
    }

    var entry =  document.createElement('li');
    var inpt = document.createElement('input');
    inpt.name = "tshirt[]";
    inpt.type = "hidden";
    inpt.value = Tshirt_gender + size;

    entry.onclick = function () {
        this.parentElement.removeChild(this);
    }

    if(Tshirt_gender == "Female " && size == "XXXL") {
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
    targetText.innerHTML = "Utdaderad eller ogiltig orkesterkod, kontakta din orkesterledare för den senaste orkesterkoden";
    target.disabled = true;
}

function toggleMultipleOrchestras(e) {
    var target = document.getElementById('field-multipleOrch');
    if (e.checked) {
        target.disabled = false;
        target.focus();
    } else {
        target.disabled = true;
    }

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