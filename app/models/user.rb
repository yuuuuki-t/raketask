class User < ApplicationRecord

  def self.import(path)
    list = []
    CSV.foreach(path,headers: true) do |row|
      list << {
      name: row["name"],
      age: row["age"],
      address: row["address"]
      }
    end

    begin
        # begin endで囲うと処理は途中で止めずに実行される
      User.create!(list)
      # !を入れないとエラー出ても表示されない
      rescue ActiveModel::UnknownAttributeError => invalid
      #例外処理 テーブルに存在しないデータを入れようとしたらエラーを出す
      puts "インポートに失敗しました:#{invalid}"
    end
  end

end


# 普通は下のように代入してからメソッドの使用をする
# user = User.new
# user.import
