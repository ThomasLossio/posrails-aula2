class Picture < ApplicationRecord
	validates :name, presence: true, uniqueness: true
end
