function getButtonsByColor(color, buttons) {
    let values = [];
    buttons.forEach(function (button) {
        if (getComputedStyle(button).backgroundColor === color) {
            values.push(button.value);
        }
    })
    return values;
}


function isYValid(){
    let yValue = document.getElementById("y-value").value;
    let validationInfo = '';
    let valid = false;

    if (!(yValue.trim() === "")) {
        if (/\d+/.test(yValue)) {
            if ((parseFloat(yValue) > -3.1) && (parseFloat(yValue) < 3.1)) {
                valid = true;
            } else validationInfo += "Y должен быть в интервале (-3...3)!";
        } else validationInfo += "Y должен быть числом!";
    } else validationInfo += "Введите Y";

    addMessageToValidationPanel(validationInfo);

    return valid;
}

function isRValid(){

    let validationInfo = '';
    let rButtons = document.querySelectorAll(".r-button");
    let purpleColor = "rgb(211, 29, 155)";
    let valid = false;
    let rValues = getButtonsByColor(purpleColor, rButtons);

    if (rValues.length !== 1) {
        if (rValues.length === 0) {
            validationInfo += "Выберите R"
        } else if (rValues.length > 1) {
            validationInfo += "Должно быть выбрано одно значение R"
        }
    } else {
        if (!(-2 <= parseFloat(rValues[0]) <= 2)) {
            validationInfo += "R не в выбранном диапазоне"
        }
    }
    if (validationInfo === "") {
        valid = true;
    } else{
        addMessageToValidationPanel(validationInfo);
    }

    return valid

}

function addMessageToValidationPanel(message){
    let validationInfoPanel = document.querySelector('.validationInfo');
    validationInfoPanel.innerHTML += message + "<br>";
    validationInfoPanel.classList.add("show");
}


function validateTextField() {
    $('.y-text').on('input', function () {
        $(this).val($(this).val().replace(/[^\d.-][a-zA-Zа-яА-Я0-9\s]+/,  ''));
    });
}