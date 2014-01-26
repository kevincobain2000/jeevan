class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
