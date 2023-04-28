class AddUserAndTeamToTeamsParticipants < ActiveRecord::Migration[7.0]
  def change
    add_column :teams_participants, :user, :string
    add_column :teams_participants, :team, :string
  end
end
