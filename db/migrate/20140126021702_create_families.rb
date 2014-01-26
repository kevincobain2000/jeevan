class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
