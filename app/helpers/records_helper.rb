module RecordsHelper
  def user_from_post(post)
    tid = post.posted_by
    @user = User.find_by(twitterid: tid)
  end
end
