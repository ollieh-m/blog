class Article < ApplicationRecord
	scope :recent_first, -> { order(created_at: :desc) }
end