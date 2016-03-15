class VisitedCountry < ActiveRecord::Base
  include Grape::Entity::DSL

  belongs_to :user

  entity do
    expose :name
  end
end
