/**
 * Created by Jacob on 2017-01-28.
 */

function toggleSpecialkost(e) {
    var target = document.getElementById('field-specialkost');
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
    console.log(target);
    console.log(typeof(tshirt.value));

    var fuckedup = false;;
    var entry =  document.createElement('li');
    entry.onclick = function () {
        this.parentElement.removeChild(this);
    }
    var size = "asd";



    switch (tshirt.value){
        case '1':
            size = "XS";
            break;
        case '2':
            size = "S";
            break;
        case '3':
            size = "M";
            break;
        case '4':
            size = "L";
            break;
        case '5':
            size = "XL";
            break;
        default:
            fuckedup = true;
    }
    if(!fuckedup) {

        entry.appendChild(document.createTextNode(size));
        target.appendChild(entry);
    }
}