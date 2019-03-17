class TitleRequest < ApplicationRecord
  belongs_to :graph_request
  has_one :raw_title, class_name: 'RawTitle', foreign_key: 'mal_id'
end
