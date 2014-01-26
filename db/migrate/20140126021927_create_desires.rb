class CreateDesires < ActiveRecord::Migration
  def change
    create_table :desires do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
