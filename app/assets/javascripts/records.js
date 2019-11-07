document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems, {
        edge: 'left',
    });

    // スクロール検出
    let start_pos = 0;
    window.onscroll = function() {
        let container = document.querySelector(".container").getBoundingClientRect();
        let containerX = container.right;
        let current_pos = document.documentElement.scrollTop || // IE、Firefox、Opera
                          document.body.scrollTop; // Chrome、Safari
        
        let btn = document.getElementById("floating-add-btn");
        if (btn) {
            if (btn.getBoundingClientRect().left < containerX) {
                if (current_pos > start_pos) {
                    if (!btn.classList.contains("active")) {
                        btn.classList.add("active");
                    }
                } else {
                    if (btn.classList.contains("active")) {
                        btn.classList.remove("active");
                    }
                }
            }
        }
        start_pos = current_pos;
    }
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