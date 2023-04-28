class CreateReviewResponseMaps < ActiveRecord::Migration[7.0]
  def change
    create_table :review_response_maps do |t|

      t.timestamps
    end
  end
end
