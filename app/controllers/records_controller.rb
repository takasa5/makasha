class RecordsController < ApplicationController
  def index
    @all_count = Post.all.count
    @posts = Post.limit(10).order("created_at desc")
  end

  def next
    @start = params[:start].to_i
    @posts = Post.order("created_at desc").offset(@start).limit(10)
    @all_count = Post.all.count
  end
end
