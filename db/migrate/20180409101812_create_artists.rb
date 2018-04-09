class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :first_name, :limit => 255, :null => false
      t.string :last_name, :limit => 255
      t.timestamps :null => false
    end
  end
end
