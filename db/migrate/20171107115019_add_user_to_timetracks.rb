class AddUserToTimetracks < ActiveRecord::Migration[5.0]
  def change
    add_reference :timetracks, :user, foreign_key: true, null: false
  end
end
