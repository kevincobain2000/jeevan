class CreateReligions < ActiveRecord::Migration
  def change
    create_table :religions do |t|

      t.timestamps
    end
  end
end
