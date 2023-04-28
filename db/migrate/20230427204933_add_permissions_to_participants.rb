class AddPermissionsToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :can_submit, :boolean
    add_column :participants, :can_take_quiz, :boolean
    add_column :participants, :can_review, :boolean
  end
end
