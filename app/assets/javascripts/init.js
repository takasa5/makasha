document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.sidenav');
    var instances = M.Sidenav.init(elems, {
        edge: 'left',
    });
    var listHeight = Math.max(
        document.getElementById('list').clientHeight,
        document.getElementById('stat').clientHeight
    );
    var elems = document.querySelectorAll('.tabs');
    var instances = M.Tabs.init(elems, {
        swipeable: true
    });
    if (listHeight) {
        document.querySelector('.tabs-content.carousel').style.height = listHeight * 1.1 + "px";
    }
    var elems = document.querySelectorAll('.modal');
    var instances = M.Modal.init(elems, {});

    // グラフ描画
    var ctx = document.getElementById('recordChrono').getContext('2d');
    var rcChart = new Chart(ctx, {
        type: 'line',
        data: gon.chrono,
        options: {
            scales: {
                xAxes: [{
                    type: 'time',
                    time: {
                        // displayFormats: {
                        //     unit: 'week',
                        //     week: 'll'
                        // }
                    }
                }]
            },
            legend: {
                display: false
            }
        }
    });
    var ctx = document.getElementById('artistsCount').getContext('2d');
    var acChart = new Chart(ctx, {
        type: 'pie',
        data: gon.artists_count,
        options: {
            title: {
                display: false,
                text: '最近のアーティスト'
            },
            legend: {
                position: 'right',
            }
        }
    });
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
        console.log(document.getElementsByClassName(className)[0]);
    }
}