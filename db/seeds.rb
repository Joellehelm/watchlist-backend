

joelle = User.create(username: "joelle", email: "joelle@joelle.com", password_digest: "j")
ashley = User.create(username: "ashley", email: "ashley@ashley.com", password_digest: "a")

office = Show.create(name: "The Office", genre: "Comedy", poster: "im a picture", total_seasons: "12")



season1 = Season.create(season_number: 1, show_id: 1)

episode1 = Episode.create(name: "first", season_id: 1)

episode2 = Episode.create(name: "second", season_id: 1)

episode3 = Episode.create(name: "third", season_id: 1)


progress1 = Progress.create(user_id: 1, show_id: 1, season_id: 1, episode_id: 2)


friend = Friendship.create(user_id: 1, friend_id: 2)



