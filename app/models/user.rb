class User < ActiveRecord::Base
  has_many :visited_countries, dependent: :destroy
  has_many :check_ins, dependent: :destroy
end
