/**
 * Created by Jacob on 2017-01-28.
 */


$(document).on('turbolinks:load', function () {
    $("#orchestra_code").on("input change",validateOrchestraCode);

    /*
    Disabled since pushpin functionality requires additional tweaking, and time is limited.

    $("#signup-summary").pushpin({
        top: $('#top-nav').height()
    });
    */

    $('#festival_ticket').change(updateArticleList);
    $('#food_ticket').change(updateArticleList);
    $('#sleep_over').change(updateArticleList);
    $('#select-medals').change(updateArticleList);
    $('#select-tag').change(updateArticleList);

    updateArticleList();
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
    var target2 = document.getElementById('specialfood-group');

    if (e.checked) {
        target.disabled = false;
        target.style = "display:block";
        target2.disabled = false;
        target2.style = "display:block";
        target.focus();
    } else {
        target.disabled = true;
        target.style = "display:none";
        target2.disabled = true;
        target2.style = "display:none";
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
        updateArticleList();
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

    updateArticleList();
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
    var target = document.getElementById('otherPerformance-field');
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

var festivalTicketPrices = [535, 510, 220, 0];
var festivalTicketPricesLinTek = [435, 410, 190, 0];
var foodTicketPrices = [215, 140, 75, 0];
var dormitoryPrices = [50, 50, 0];
var tshirtPrice = 100;
var medalPrice = 40;
var tagPrice = 20;

function updateArticleList() {
    clearArticleList();

    var costTotal = 0;
    var festivalTicketType = $('#festival_ticket').val();
    costTotal += appendArticle('Festivalbiljett', festivalTicketPrices[festivalTicketType]);
    costTotal += appendLinTekDiscount(festivalTicketType);
    costTotal += appendArticle('Matbiljett', foodTicketPrices[$('#food_ticket').val()]);
    costTotal += appendArticle('Sovsal', dormitoryPrices[$('#sleep_over').val()]);
    costTotal += appendArticles('T-shirt', tshirtPrice, $('#collection-of-tshirts').find('li').length);
    costTotal += appendArticles('Medalj', medalPrice, $('#select-medals').val());
    costTotal += appendArticles('Märke', tagPrice, $('#select-tag').val());

    appendTotal(costTotal);
}

function appendArticle(name, price) {
    if (price != 0) {
        var row = $('<tr/>');
        row.append($('<td/>').text(name));
        row.append($('<td/>').text(price.toString() + ' SEK'));

        $('#article-list').append(row);
    }

    return price;
}

function appendArticles(name, price, amount) {
    return appendArticle(name + ' x ' + amount.toString(), price * amount);
}

function appendTotal(cost) {
    var row = $('<tr/>');
    row.append($('<th/>').text('Totalt'));
    row.append($('<th/>').text(cost.toString() + ' SEK'));

    $('#article-list').append(row);
}

function clearArticleList() {
    $('#article-list').empty();
}

function appendLinTekDiscount(ticketType) {
    var discount = 0;
    if (isLinTekMember()) {
        discount = festivalTicketPricesLinTek[ticketType] - festivalTicketPrices[ticketType];
    }

    return appendArticle("LinTek-rabatt", discount);
}

function isLinTekMember() {
    return $('#is-lintek-member').val() == 'true';
}
