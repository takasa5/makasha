document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('textarea');
    var instances = M.CharacterCounter.init(elems);

    document.getElementById('reload-btn').onclick = function() {
        M.Toast.dismissAll();
        M.toast({
            html: "更新しました",
            classes: "base-low-color"
        })
    }
});