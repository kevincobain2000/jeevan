class CreateShortlists < ActiveRecord::Migration
  def change
    create_table :shortlists do |t|

      t.timestamps
    end
  end
end
