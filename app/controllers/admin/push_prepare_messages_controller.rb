class Admin::PushPrepareMessagesController < Admin::AdminController
    before_action :set_push_prepare_message, only: [:show, :edit, :update, :destroy]

    def before_init
        super
        @category = t(:menu_push)
        @controller_name = t('activerecord.models.push_prepare_message')
    end

    # GET /mms_message
    # GET /mms_message.json
    def index
        params[:per_page] = 10 unless params[:per_page].present?

        @push_prepare_messages = PushPrepareMessage.order('id desc').page(params[:page]).per(params[:per_page])

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @push_prepare_messages }
        end
    end

    # GET /mms_message/1
    # GET /mms_message/1.json
    def show; end

    # GET /mms_message/new
    # GET /mms_message/new.json
    def new
        @push_prepare_message = PushPrepareMessage.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @push_prepare_message }
        end
    end

    # GET /mms_message/1/edit
    def edit; end

    # POST /mms_message
    # POST /mms_message.json
    def create
        @push_prepare_message = PushPrepareMessage.new(push_prepare_message_params)

        respond_to do |format|
            if @push_prepare_message.save
                format.html { redirect_to admin_push_prepare_message_path(@push_prepare_message), notice: @controller_name + t(:message_success_insert) }
                format.json { render json: @push_prepare_message, status: :created, location: @push_prepare_message }
            else
                format.html { render :new }
                format.json { render json: @push_prepare_message.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /mms_message/1
    # PUT /mms_message/1.json
    def update
        respond_to do |format|
            if @push_prepare_message.update_attributes(push_prepare_message_params)
                format.html { redirect_to admin_push_prepare_message_path(@push_prepare_message), notice: @controller_name + t(:message_success_update) }
                format.json { head :no_content }
            else
                format.html { render :edit }
                format.json { render json: @push_prepare_message.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /mms_message/1
    # DELETE /mms_message/1.json
    def destroy
        @push_prepare_message.destroy

        respond_to do |format|
            format.html { redirect_to admin_push_prepare_messages_path }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_push_prepare_message
        @push_prepapre_message = PushPrepareMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def push_prepare_message_params
        params.require(:push_prepare_message).permit(:title, :content, :enable)
    end
end
