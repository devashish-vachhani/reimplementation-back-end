class AddNameToAssignmentParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :assignment_participants, :name, :string
  end
end
