class Species < ApplicationRecord
  validates_presence_of :name, :height_avg
end
