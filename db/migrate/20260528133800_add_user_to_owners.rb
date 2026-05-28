class AddUserToOwners < ActiveRecord::Migration[8.1]
  def change
    add_reference :owners, :user, foreign_key: true, null: true
  end
end