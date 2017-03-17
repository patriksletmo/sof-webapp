/**
 * Created by Jacob on 2017-01-28.
 */



var orchestraHasDormitory = false;

$(document).on('turbolinks:load', function () {
    if ($('#festival_ticket').length > 0) {
        $("#orchestra_code").on("input change", validateOrchestraCode);

        $('#festival_ticket').change(updateArticleList);
        $('#food_ticket').change(updateArticleList);
        $('#sleep_over').change(updateArticleList);
        $('#select-medals').change(updateArticleList);
        $('#select-tag').change(updateArticleList);

        updateArticleList();
        updateSignupSummary();
    }
});

$(window).on('resize', updateSignupSummary);

function updateSignupSummary() {
    var signupSummary = $("#signup-summary");

    signupSummary.pushpin('remove');
    if ($(window).width() > 600) {
        signupSummary.pushpin({
            top: $('#top-nav').height(),
            bottom: $('body').height() - $('footer').height() - $(signupSummary).height() - 45
        });
    }

    signupSummary.width($("#signup-summary-parent").width());
}

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

    var ediv = document.createElement('div');
    var ei = document.createElement('i');

    ei.style = "float: right";
    ei.className = "icon-bin2";

    var Tshirt_gender;
    if(gender.checked){
        Tshirt_gender = t()['orchestra']['register']['tshirts_model_female'] + ' ';
    } else {
        Tshirt_gender = t()['orchestra']['register']['tshirts_model_male'] + ' ';
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

    if(Tshirt_gender == "Dam " && size == "XXXL" || Tshirt_gender == "Female " && size == "XXXL") {
        return;
    } else {

        size = Tshirt_gender + size;

        ediv.append(size);
        ediv.append(ei);
        ediv.append(inpt);

        entry.append(ediv);
        target.appendChild(entry);
    }

    updateArticleList();
}

function orchestaCodeValid(data){
    var target = document.getElementById('valid_orchestra_code');
    target.disabled = false;
    target.checked = true;
    $('#orchestra-name').text(data['name']);
    $('#code-invalid').hide();
    $('#code-valid').show();
    target.disabled = true;

    orchestraHasDormitory = data['dormitory'];
    updateArticleList();
}

function orchestraCodeInvalid() {

    var target = document.getElementById('valid_orchestra_code');
    target.disabled = false;
    target.checked = false;
    $('#code-invalid').show();
    $('#code-valid').hide();
    target.disabled = true;

    orchestraHasDormitory = false;
    updateArticleList();
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
var foodTicketPrices = [215, 140, 75, 0, 140];
var dormitoryPrices = [50, 50, 0];
var tshirtPrice = 100;
var medalPrice = 40;
var tagPrice = 20;
var lateRegistrationPrice = 100;



function updateArticleList() {
    clearArticleList();

    var costTotal = 0;
    var festivalTicketType = $('#festival_ticket').val();
    costTotal += appendArticle(t()['orchestra']['register']['festival_ticket'], festivalTicketPrices[festivalTicketType]);
    costTotal += appendLinTekDiscount(festivalTicketType);
    costTotal += appendArticle(t()['orchestra']['register']['late_registration'], lateRegistrationFee());
    costTotal += appendArticle(t()['orchestra']['register']['food_ticket'], foodTicketPrices[$('#food_ticket').val()]);
    costTotal += appendArticle(t()['orchestra']['register']['dormitory'], dormitoryPrice($('#sleep_over').val()));
    costTotal += appendArticles(t()['orchestra']['register']['tshirt'], tshirtPrice, $('#collection-of-tshirts').find('li').length);
    costTotal += appendArticles(t()['orchestra']['register']['medal'], medalPrice, $('#select-medals').val());
    costTotal += appendArticles(t()['orchestra']['register']['tag'], tagPrice, $('#select-tag').val());

    appendTotal(costTotal);

    updateSignupSummary();
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
    row.append($('<th/>').text(t()['orchestra']['register']['summary_total']));
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

    return appendArticle(t()['orchestra']['register']['lintek_discount'], discount);
}

function isLinTekMember() {
    return $('#is-lintek-member').val() == 'true';
}

function dormitoryPrice(chosenIndex) {
    if (chosenIndex == 0 && !orchestraHasDormitory) {
        return 0;
    }

    return dormitoryPrices[chosenIndex];
}

function lateRegistrationFee(){

    var currentDate = new Date();
    var lastRegistrationDate = new Date("Mars 5, 2017 00:00:00");


    currentDate = convertDateToUTC1(currentDate);
    lastRegistrationDate = convertDateToUTC1(lastRegistrationDate);

    if(lastRegistrationDate <= currentDate){
        return lateRegistrationPrice
    }
    return 0
}


function convertDateToUTC1(date) {
 return new Date(date.getUTCFullYear(),
    date.getUTCMonth(),
    date.getUTCDate(), 
    date.getUTCHours() + 1, 
    date.getUTCMinutes(), 
    date.getUTCSeconds());
}
