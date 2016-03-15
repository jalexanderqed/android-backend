module LonelyPacker
  class API < Grape::API
    use Grape::Middleware::Logger

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
        optional :visited_countries, type: Array do
          requires :name, type: String
        end
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

          if params[:visited_countries].present?
            params[:visited_countries].each do |c|
              u.visited_countries.create(name: c[:name])
            end
          end

          status 201
          present u, with: User::Entity
        rescue
          error! 'Unexpected error', 500
        end
      end

      route_param :username, type: String do

        before do
          unless params[:username].present?
            error! 'Invalid login attempt.', 401
          end

          @user = User.find_by(username: params[:username]);

          unless @user.present? && headers['Authorization'].present? && headers['Authorization'] == @user.password
            error! 'Invalid login attempt.', 401
          end
        end

        desc 'Returns a specific user.'
        params do
        end
        get '/' do
          begin
            status 200
            present @user, with: User::Entity
          rescue
            error! 'Unexpected error', 500
          end
        end

        desc 'Update a user.'
        params do
          optional :real_name, type: String
          optional :birth_year, type: Integer
          optional :birth_month, type: Integer
          optional :birth_day, type: Integer
          optional :visited_countries, type: Array do
            requires :name, type: String
          end
          optional :bio, type: String
        end
        put '/' do
          begin
            @user.password = params[:password] if params[:password].present?
            @user.real_name = params[:real_name] if params[:real_name].present?
            @user.birth_year = params[:birth_year] if params[:birth_year].present?
            @user.birth_month = params[:birth_month] if params[:birth_month].present?
            @user.birth_day = params[:birth_day] if params[:birth_day].present?
            @user.bio = params[:bio] if params[:bio].present?

            params[:visited_countries].each do |c|
              if !@user.visited_countries.find_by(name: c[:name]).present?
                @user.visited_countries.create(name: c[:name])
              end
            end

            @user.save!

            status 200
            present @user, with: User::Entity
          rescue
            error! 'Unexpected error', 500
          end
        end

        desc 'Adds a check in for a user.'
        params do
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
            present c, with: CheckIn::Entity
          rescue
            error! 'Unexpected error', 500
          end
        end

      end

    end
  end
end