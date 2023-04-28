class RenameNameColumnInSignUpTopics < ActiveRecord::Migration[7.0]
  def change
    rename_column :sign_up_topics, :name, :topic_name
  end
end
