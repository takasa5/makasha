class RecordsController < ApplicationController
  def index
    @posts = Post.limit(10).order("created_at desc")
  end

  def next
    @start = params[:start].to_i
    @posts = Post.order("created_at desc").offset(@start).limit(10)
    @terminal_flag= not(@posts.count == 10) # ちょうど10で終わる時対応遅れる．．．
  end
end
