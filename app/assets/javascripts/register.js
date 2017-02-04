/**
 * Created by Jacob on 2017-01-28.
 */

/*
document.addEventListener('turbolinks:load', function () {
    var isLintek = false;
    var festivalTickets = document.getElementById("festival_ticket");

    console.log(festivalTickets);

    // TS == Thursday - Sunday
    var text = ["Ingen biljett", "Torsdag (11/5) - Söndag (14/5)", "Fredag (12/5) - Söndag (14/5)", "Lördag (13/5) - Söndag (15/5)"];
    var cost;
    if(isLintek){
        cost = [" (0kr)", " (435kr)", " (410kr)", " (190kr)"];
    } else {
        cost = [" (0kr)", " (535kr)", " (510kr)", " (220kr)"];
    }


    for(i = 1; i <= 4; i++){
        var opt = document.createElement('option');
        opt.value = i;
        opt.lintek = isLintek;
        opt.innerHTML = text[i-1] + cost[i-1];
        festivalTickets.appendChild(opt);
    }

});
*/



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