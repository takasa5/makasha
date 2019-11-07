document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select');
    var instances = M.FormSelect.init(elems, {});

    var listHeight = Math.max(
        document.getElementById('list').clientHeight,
        document.getElementById('stat').clientHeight
    );
    var elems = document.querySelectorAll('.tabs');
    var instances = M.Tabs.init(elems, {
        swipeable: false
    });
    var btnHeight;
    if (document.getElementById('floating-add-btn'))
        btnHeight = document.getElementById('floating-add-btn').clientHeight;
    if (listHeight && btnHeight) {
        document.querySelector('.tabs-content').style.height = listHeight + btnHeight * 2 + "px";
    } else if (listHeight) {
        document.querySelector('.tabs-content').style.height = listHeight * 1.2 + "px";
    }
    
    // グラフ描画
    var ctx = document.getElementById('recordChrono');
    if (ctx) {
        ctx = ctx.getContext('2d');
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
    }
    var ctx = document.getElementById('artistsCount');
    if (ctx) {
        ctx = ctx.getContext('2d');
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
    }

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