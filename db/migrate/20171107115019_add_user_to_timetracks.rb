class AddUserToTimetracks < ActiveRecord::Migration[5.0]
  def change
    add_reference :timetracks, :user, foreign_key: true

    Timetrack.all.each do |timetrack|
      timetrack.user = User.first
      timetrack.save!
    end

    change_column_null :timetracks, :user_id, false
  end
end
