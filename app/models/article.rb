class Article < ApplicationRecord
	scope :recent_first, -> { order(created_at: :desc) }

  def to_partial_path
    "articles/#{view_id}"
  end
end