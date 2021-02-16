class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, index: true
      t.references :post, index: true
      t.timestamps
    end
  end
end
