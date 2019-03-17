class RawTitle < ApplicationRecord
  has_many :title_requests, class_name: 'TitleRequest', foreign_key: 'mal_id'
end
