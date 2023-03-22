class Assignment < ApplicationRecord
    has_many :participants, class_name: 'AssignmentParticipant', foreign_key: 'parent_id', dependent: :destroy
    def self.participants
    end
end
