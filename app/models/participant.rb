class Participant < ApplicationRecord
    belongs_to :assignment, foreign_key: 'parent_id', inverse_of: false
end