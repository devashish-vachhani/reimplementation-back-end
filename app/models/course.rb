class Course < ApplicationRecord
    has_many :participants
    has_many :assignments, dependent: :destroy
end