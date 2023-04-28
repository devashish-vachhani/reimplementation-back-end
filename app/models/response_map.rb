class ResponseMap < ApplicationRecord
    # extend Scoring
    has_many :response, foreign_key: 'map_id', dependent: :destroy, inverse_of: false
    belongs_to :reviewer, class_name: 'Participant', foreign_key: 'reviewer_id', inverse_of: false
    belongs_to :assignment, class_name: 'Assignment', foreign_key: 'reviewed_object_id', inverse_of: false
end