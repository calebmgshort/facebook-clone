class CreateUserFriend < ActiveRecord::Migration[6.1]
  def change
    create_table :user_friend do |t|
      t.boolean :accepted
      t.references :requester, index: true, foreign_key: { to_table: :users }
      t.references :requestee, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end

  end
end
