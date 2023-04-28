class AddTopicNameToSignUpTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :sign_up_topics, :name, :string
  end
end
