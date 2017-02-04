/**
 * Created by Jacob on 2017-01-28.
 */

function togglePossibleTshirt(){
    console.log("toggla vilka tröjor som kan köpas");

    var tshirt = document.getElementById('select-selected-tshirt');
    var gender = document.getElementById('switch-gender');

    console.log();
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
        console.log("too many Tshirts");
        return;
    }

    var Tshirt_gender
    if(gender.checked){
        Tshirt_gender = "Female ";
    } else {
        Tshirt_gender = "Male "
    }

    var entry =  document.createElement('li');

    entry.onclick = function () {
        this.parentElement.removeChild(this);
    }

    if(Tshirt_gender == "Female " && size == "XXL") {
        return;
    } else {
        size = Tshirt_gender + size;
        entry.appendChild(document.createTextNode(size));
        target.appendChild(entry);
    }
}

function togglePerformWithOther(e) {
    var target = document.getElementById('field-otherOrchestra');
    if (e.checked) {
        target.disabled = false;
        target.focus();
    } else {
        target.disabled = true;
    }
}