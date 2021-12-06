class AddTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :auth_token, :string, uniqueness: true
  end
end
