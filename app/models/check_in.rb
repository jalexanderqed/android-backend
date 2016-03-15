class CheckIn < ActiveRecord::Base
  include Grape::Entity::DSL

  belongs_to :user

  entity do
    expose :latitude
    expose :longitude
    expose :comment
  end
end
