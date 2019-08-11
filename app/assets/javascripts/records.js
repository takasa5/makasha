document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems, {
        edge: 'left',
    });
})

function onClickSearch() {
    let modal = document.getElementById('search-modal');
    let instance = M.Modal.getInstance(modal);
    instance.open();
}