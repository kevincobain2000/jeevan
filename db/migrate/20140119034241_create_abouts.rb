class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
