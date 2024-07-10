function getX() {
    let x = document.getElementById("x-values").querySelector('select').value;
    document.getElementById('label_x').innerText = "X = " + x;
    return x;
}


function getY(){
    return parseFloat(document.getElementById("y-value").value)
}

function getR(){
    let rButtons = document.querySelectorAll(".r-button");
    let purpleColor = "rgb(211, 29, 155)";
    let rValues = getButtonsByColor(purpleColor, rButtons);
    return parseFloat(rValues[0])
}
