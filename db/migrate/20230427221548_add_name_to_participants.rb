class AddNameToParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :participants, :name, :string
  end
end
