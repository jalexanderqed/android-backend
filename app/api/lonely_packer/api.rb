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
        requires :visited_countries, type: Array(String)
        optional :bio, type: String
      end
      post '/' do
        begin
          if User.find_by(username: params[:username])
            error! 'Username must be unique.', 409
          end

          u = User.create(
              username: params[:username],
              password: params[:password],
              real_name: params[:real_name],
              birth_year: params[:birth_year],
              birth_month: params[:birth_month],
              birth_day: params[:birth_day],
              bio: params[:bio])
          params[:visited_countries].each do |c|
            u.visited_countries.create(name: c)
          end

          status 201
          present u, with: User::Entity
        rescue
          error! 'Unexpected error', 500
        end
      end

      desc 'Update a user.'
      params do
        requires :username, type: String
        requires :password, type: String
        optional :real_name, type: String
        optional :birth_year, type: Integer
        optional :birth_month, type: Integer
        optional :birth_day, type: Integer
        optional :visited_countries, type: Array(String)
        optional :bio, type: String
      end
      put '/' do
        begin
          u = User.find_by(username: params[:username]);

          if !u.present? || !(u.password == params[:password])
            error! 'Invalid login attempt.', 401
          end

          u.password = params[:password] if params[:password].present?
          u.real_name = params[:real_name] if params[:real_name].present?
          u.birth_year = params[:birth_year] if params[:birth_year].present?
          u.birth_month = params[:birth_month] if params[:birth_month].present?
          u.birth_day = params[:birth_day] if params[:birth_day].present?
          u.bio = params[:bio] if params[:bio].present?

          params[:visited_countries].each do |c|
            if !u.visited_countries.find_by(name: c).present?
              u.visited_countries.create(name: c)
            end
          end

          u.save!

          status 200
          present u, with: User::Entity
        rescue
          error! 'Unexpected error', 500
        end
      end

      route_param :username, type: String do

        before do
          @user = User.find_by(username: params[:username]);

          if !@user.present? || !(@user.password == params[:password])
            error! 'Invalid login attempt.', 401
          end
        end

        desc 'Returns a specific user.'
        params do
          requires :password, type: String
        end
        get '/' do
          begin
            status 200
            present @user, with: User::Entity
          rescue
            error! 'Unexpected error', 500
          end
        end

        desc 'Adds a check in for a user.'
        params do
          requires :password, type: String
          requires :latitude, type: Float
          requires :longitude, type: Float
          optional :comment, type: String
        end
        post :check_in do
          begin
            c = @user.check_ins.create(
                latitude: params[:latitude],
                longitude: params[:longitude],
                comment: params[:comment]
            )
            status 201
            c
          rescue
            error! 'Unexpected error', 500
          end
        end

      end

    end
  end
end