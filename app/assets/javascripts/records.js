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

function changeCollection() {
    let collection = document.getElementById('records-collection');
    collection.classList.add('with-header');
    console.log(collection);
}