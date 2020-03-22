class AddContentToRetweets < ActiveRecord::Migration[5.2]
  def change
    add_column :retweets, :retweet_comment, :text
  end
end
