class CreateCourseParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :course_participants do |t|

      t.timestamps
    end
  end
end
