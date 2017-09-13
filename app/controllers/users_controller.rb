class UsersController < ApplicationController
    load_and_authorize_resource except: [:new, :create, :complete, :service_agreement, :policy_privacy, :see_you_again, :check_email, :check_id, :validate_id, :select_service]

    def before_init
      super
      @title= t(:menu_my_page)
    end
    # GET /users
    # GET /users.json
    def index
        @user = User.find(current_user)
        @controller_name = t(:menu_my_page)

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @users }
        end
    end


    # GET /users/new
    # GET /users/new.json
    def new
        @controller_name = t(:menu_new_user)
    end

    def check_email
        user_exists = User.where(login_id: params[:email]).exists?

        respond_to do |format|
            format.html { user_exists }
            format.json { render json: { exists: user_exists }}
        end
    end

    def complete; end
end
