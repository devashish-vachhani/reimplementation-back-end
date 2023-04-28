class Response < ApplicationRecord
    belongs_to :response_map, class_name: 'ResponseMap', foreign_key: 'map_id', inverse_of: false
    has_many :metareview_response_maps, class_name: 'MetareviewResponseMap', foreign_key: 'reviewed_object_id', dependent: :destroy, inverse_of: false
    alias map response_map
    has_many :scores, class_name: 'Answer', foreign_key: 'response_id', dependent: :destroy, inverse_of: false
end