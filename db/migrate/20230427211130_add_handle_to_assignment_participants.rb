class AddHandleToAssignmentParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :assignment_participants, :handle, :string
  end
end
