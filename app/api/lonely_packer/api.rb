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
      end
      post 'create' do
        Hash['test', 'other_response']
      end
    end
  end
end