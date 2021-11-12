3.times do |n|
  Post.create(title: "#{n}回目の投稿タイトル", body: "#{n}回目の投稿ボディです！", user_id: User.first.id)
end