class RemoveHandleFromAssignmentParticipants < ActiveRecord::Migration[7.0]
  def change
    remove_column :assignment_participants, :handle, :string
  end
end
