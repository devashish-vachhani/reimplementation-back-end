class CreateResponseMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :response_maps do |t|

      t.timestamps
    end
  end
end
