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

  def search
    @artist_query = params[:post][:artist]
    @song_query = params[:post][:song]
    if @artist_query.blank? and @song_query.blank?
      index()
      render :index
      return
    end
    result = Post.where(
      '(artist LIKE ?) AND (song LIKE ?)', "%#{@artist_query}%", "%#{@song_query}%"
    )
    @all_count = result.count
    @posts = result.order("created_at desc")

    render 'index.html.erb'
  end
end
