class AddFirstSignInAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_sign_in_at, :datetime
  end
end
