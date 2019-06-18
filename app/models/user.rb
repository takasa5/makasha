class User < ApplicationRecord
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image_url = auth[:info][:image]
    twitter_url = auth[:info][:urls][:Twitter]
    twitter_id = auth[:info][:nickname]

    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image_url
      user.twitter_url = twitter_url
      user.twitterid = twitter_id
    end
  end
end
