class Person < ApplicationRecord
  validates_presence_of :name, :birthday_year, :height, :mass
end
