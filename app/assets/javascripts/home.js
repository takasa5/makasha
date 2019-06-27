document.addEventListener('DOMContentLoaded', function() {
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
})