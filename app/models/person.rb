class Person < ApplicationRecord
  validates_presence_of :name, :birthday_year, :height, :mass

  belongs_to :planet
end
