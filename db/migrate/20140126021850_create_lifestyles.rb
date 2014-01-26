class CreateLifestyles < ActiveRecord::Migration
  def change
    create_table :lifestyles do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
