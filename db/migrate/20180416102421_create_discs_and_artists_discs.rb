class CreateDiscsAndArtistsDiscs < ActiveRecord::Migration
  def up
    create_table :discs do |t|
      t.string :title, :limit => 255, :null => false
      t.integer :producer_id, :null => false
      t.datetime :produced_at
      t.string :serial_number, :limit => 5, :unique => true
      t.text :blurb
      t.float :price
      t.timestamps
    end

    create_table :artists_discs do |t|
      t.integer :artist_id, :null => false
      t.integer :disc_id, :null => false
      t.timestamps
    end

    say_with_time 'Adding foreing keys' do
      # Add foreign key reference to artists_discs table
      execute 'ALTER TABLE artists_discs ADD CONSTRAINT fk_artists_discs_artists
              FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE'      
      execute 'ALTER TABLE artists_discs ADD CONSTRAINT fk_artists_discs_discs
              FOREIGN KEY (disc_id) REFERENCES discs(id) ON DELETE CASCADE'
      # Add foreign key reference to producers table
      execute 'ALTER TABLE discs ADD CONSTRAINT fk_discs_producers
              FOREIGN KEY (producer_id) REFERENCES producers(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :discs
    drop_table :artists_discs
  end
end
