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