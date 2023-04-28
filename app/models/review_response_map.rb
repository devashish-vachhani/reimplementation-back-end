class ReviewResponseMap < ResponseMap
    belongs_to :reviewee, class_name: 'Team', foreign_key: 'reviewee_id', inverse_of: false
    belongs_to :contributor, class_name: 'Team', foreign_key: 'reviewee_id', inverse_of: false
    belongs_to :assignment, class_name: 'Assignment', foreign_key: 'reviewed_object_id', inverse_of: false
end  