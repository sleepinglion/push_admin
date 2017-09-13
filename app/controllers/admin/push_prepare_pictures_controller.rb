class Admin::PushPreparePicturesController < Admin::AdminController
    before_action :set_push_prepare_picture, only: [:show, :edit, :update, :destroy]

    def before_init
        super
        @category = t(:menu_push)
        @controller_name = t('activerecord.models.push_prepare_picture')
    end

    def index
      @push_prepare_pictures = PushPreparePicture.order('id desc').page(params[:page]).per(params[:per_page])

      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @push_prepare_pictures }
      end
    end

    def edit; end

    def show; end

    def create
      @push_prepare_picture = PushPreparePicture.new(push_prepare_picture_params)

      respond_to do |format|
          if @push_prepare_picture.save
              format.html { redirect_to admin_push_prepare_picture_path(@push_prepare_picture), notice: @controller_name + t(:message_success_insert) }
              format.json { render json: @push_prepare_picture, status: :created, location: @push_prepare_picture }
          else
              format.html { render 'new' }
              format.json { render json: @push_prepare_picture.errors, status: :unprocessable_entity }
          end
      end
    end

    def update
      respond_to do |format|
        if @push_prepare_picture.update_attributes(push_prepare_picture_params)
          format.html { redirect_to admin_push_prepare_picture_path(@push_prepare_picture), :notice => @controller_name +t(:message_success_update)}
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render :json => @push_prepare_picture.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy
        @push_prepare_picture.destroy

        respond_to do |format|
            format.html { redirect_to admin_push_prepare_pictures_path }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_push_prepare_picture
        @push_prepare_picture = PushPreparePicture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def push_prepare_picture_params
        params.require(:push_prepare_picture).permit(:photo, :enable)
    end
end
