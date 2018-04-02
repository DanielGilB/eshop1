class CreateProducers < ActiveRecord::Migration
  def change
    create_table :producers do |t|

      t.timestamps null: false
    end
  end
end
