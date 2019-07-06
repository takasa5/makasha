document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select');
    var instances = M.FormSelect.init(elems, {});

    var listHeight = Math.max(
        document.getElementById('list').clientHeight,
        document.getElementById('stat').clientHeight
    );
    var elems = document.querySelectorAll('.tabs');
    var instances = M.Tabs.init(elems, {
        swipeable: true
    });
    var btnHeight;
    if (document.getElementById('floating-add-btn'))
        btnHeight = document.getElementById('floating-add-btn').clientHeight;
    if (listHeight && btnHeight) {
        document.querySelector('.tabs-content.carousel').style.height = listHeight + btnHeight * 2 + "px";
    } else if (listHeight) {
        document.querySelector('.tabs-content.carousel').style.height = listHeight * 1.2 + "px";
    }
    
    // グラフ描画
    var ctx = document.getElementById('recordChrono').getContext('2d');
    window.rcChart = new Chart(ctx, {
        type: 'line',
        data: gon.chrono,
        options: {
            scales: {
                xAxes: [{
                    type: 'time',
                    time: {
                        displayFormats: {
                            unit: 'week',
                            day: 'M/D'
                        }
                    }
                }]
            },
            legend: {
                display: false
            }
        }
    });
    var ctx = document.getElementById('artistsCount').getContext('2d');
    window.acChart = new Chart(ctx, {
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
})

function selectRange(obj) {
    var index = obj.selectedIndex;
    var value = obj.options[index].value;
    var url = location.href + value;
    // var request = new XMLHttpRequest();
    // console.log(url);
    // request.open('GET', url, true);
    // request.onreadystatechange = function () {
    //     if (request.readyState != 4) {
    //         // リクエスト中
    //     } else if (request.status != 200) {
    //         console.log("bad");
    //     } else {
    //         // 取得成功
    //         // var result = request.responseText;
    //         console.log("success");
    //     }
    // };
    // request.send();
    fetch(url, {
        method: "GET",
    }).then(response => response.text())
    .then(text => {
    });
}