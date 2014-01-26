class CreateKundalis < ActiveRecord::Migration
  def change
    create_table :kundalis do |t|

      t.timestamps
    end
  end
end
