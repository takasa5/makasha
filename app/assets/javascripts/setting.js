document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('input');
    var instances = M.CharacterCounter.init(elems);
    var elems = document.querySelectorAll('textarea');
    var instances = M.CharacterCounter.init(elems);
    var elems = document.querySelectorAll('.tooltipped');
    var instances = M.Tooltip.init(elems, {
        position: 'top'
    });
});

window.onload = function() {
    // 画像の読み込みが行われた後に評価
    let icon = document.getElementById("icon");
    if (icon.classList.contains("default-icon")) {
        let col = document.getElementById("refresh-col");
        col.style.display = "block";
    }
}

function modalCancel() {
    let elem = document.getElementById('delete-modal');
    let instance = M.Modal.getInstance(elem);
    instance.close();
}