document.addEventListener('DOMContentLoaded', init, false);

function init() {
    const buttons = document.querySelectorAll(".r-button");

    document.addEventListener("click", function (evt) {
        if (evt.target.classList.contains("r-button")) {
            buttons.forEach(function (button) {
                button.classList.remove("active");
            });
            evt.target.classList.add("active");
        }
    })
}
