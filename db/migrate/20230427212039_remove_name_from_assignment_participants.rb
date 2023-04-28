class RemoveNameFromAssignmentParticipants < ActiveRecord::Migration[7.0]
  def change
    remove_column :assignment_participants, :name, :string
  end
end
