document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems, {
        edge: 'left',
    });
    
    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems, {});
});

function onClickAdd() {
    var modal = document.getElementById('modal1');
    var instance = M.Modal.getInstance(modal);
    instance.open();
}

function onClickTab(elm) {
    var tabs = document.getElementById('tabs1');
    var instance = M.Tabs.getInstance(tabs);
    instance.select(elm.id);
    return false;
}

function checkInputs(className) {
    if (document.getElementById(className + '-song').value == ""
        || document.getElementById(className + '-artist').value == "") {
        document.getElementsByClassName(className)[0].classList.add('disabled');
    } else {
        document.getElementsByClassName(className)[0].classList.remove('disabled');
    }
}

function openSideNav(elm) {
    var target = elm.getAttribute("data-target");
    var elem = document.getElementById(target);
    var instance = M.Sidenav.getInstance(elem);
    instance.open();
}