class User < ActiveRecord::Base
  include Grape::Entity::DSL

  has_many :visited_countries, dependent: :destroy
  has_many :check_ins, dependent: :destroy

  entity do
    expose :username
    expose :real_name
    expose :birth_year
    expose :birth_month
    expose :birth_day
    expose :bio
    expose :visited_countries, with: VisitedCountry::Entity
    expose :check_ins, with: CheckIn::Entity
  end
end
