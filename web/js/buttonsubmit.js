function myFunction(key) {
    var bodytext = document.getElementById(key).textContent.trim();
    var content = document.getElementById("edited" + key);
    if (bodytext === "")
        return;
    if (content === null)
        return;
    document.getElementById("edited" + key).value = bodytext;
    console.log(encodeURIComponent(bodytext));
    console.log(document.getElementById("edited".concat(key)).value);
}
function myFunctionKeypress(key, value) {
    var bodytext = document.getElementById(key).textContent.trim();
    var n = String(bodytext).trim().localeCompare(String(value).trim());
    if (n != 0) {
        document.getElementById("button".concat(key)).className = "w3-btn w3-red";
        document.getElementById("button".concat(key)).disabled = false;
    } else {
        document.getElementById("button".concat(key)).disabled = true;
        document.getElementById("button".concat(key)).className = "w3-btn w3-blue-grey";
    }
}