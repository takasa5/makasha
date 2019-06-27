module UsersHelper

  def get_record_stat(user, legend_limit: 4)
    # 対象レコードデータ
    # TODO: 検索対象の指定
    record = Post.where(posted_by: user.twitterid).reverse_order.limit(100)

    # 最近のアーティスト比率
    ## ユーザの最新100件のうち，アーティストと出現回数の組を取得
    data = record.group(:artist).count.sort_by{|a| a[1]}.reverse
    ## ハッシュに出現数を記録
    artists_count = {
      labels: [],
      datasets: [{
        data: [],
        backgroundColor: [
          "#594157",
          "#726DA8",
          "#7D8CC4",
          "#A0D2DB",
          "#BEE7E8"
        ]
      }]
    }
    data.each_with_index do |d, index|
      if index == legend_limit
        break
      end
      artists_count[:labels] << d[0]
      artists_count[:datasets][0][:data] << d[1]
    end
    ## その他処理
    if data.length > legend_limit
      others_sum = 0
      for d in data[legend_limit..data.length] do
        others_sum += d[1]
      end
      artists_count[:labels] << "その他"
      artists_count[:datasets][0][:data] << others_sum
    end
    gon.artists_count = artists_count

    # 曲のランキング
    data = record.group(:artist, :song).count.sort_by{|a| a[1]}.reverse[0..2]
    @rank = data

    # レコード増加
    # TODO: 最初から日時で切り出さないとおかしくなる
    # 記録対象の最古timeをとってきて，それ以前のデータをcount
    most_old_time = record.last.created_at
    range = 100.year.ago..(most_old_time - 1)
    base_count = Post.where(posted_by: current_user.twitterid, created_at: range).count
    ## 検索対象の日付を記録
    timestamps = []
    record.each do |data|
      timestamps << data.created_at.strftime("%Y-%m-%d")
    end
    ## 同じタイムスタンプが何回登場するかを保持したsetを作る
    time_log = []
    count_log = []
    for timestamp in timestamps.reverse
      if not time_log.include?(timestamp)
        time_log << timestamp
        count_log << 1
      else
        count_log[time_log.index(timestamp)] += 1
      end
    end
    time_count_set = time_log.zip(count_log)
    ## データセット整形
    chrono = {
      labels: [],
      datasets: [{
        data:[],
        borderColor: '#726DA8',
        backgroundColor: '#7D8CC4',
        pointRadius: 0,
        steppedLine: true
      }]
    }
    for set in time_count_set
      base_count += set[1]
      chrono[:labels] << set[0]
      chrono[:datasets][0][:data] << base_count
    end
    gon.chrono = chrono

  end
end
