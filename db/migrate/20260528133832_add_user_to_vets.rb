class AddUserToVets < ActiveRecord::Migration[8.1]
  def change
    add_reference :vets, :user, foreign_key: true, null: true
  end
end
