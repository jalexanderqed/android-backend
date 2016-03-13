module LonelyPacker
  class API < Grape::API
    version 'v1', using: :header, vendor: 'lonely_packer'
    format :json
    prefix :api

    helpers do

    end

    resource :users do
      params do

      end
      get '/' do
        Hash['test', 'other_response']
      end

      desc 'Create a new user.'
      params do
        requires :username, type: String
        requires :password, type: String
        requires :real_name, type: String
        requires :birth_year, type: Integer
        requires :birth_month, type: Integer
        requires :birth_day, type: Integer
        requires :countries_visited, type: Array(String)
        requires :bio, type: String

      end
      post 'create' do
        Hash['test', 'other_response']
      end
    end
  end
end