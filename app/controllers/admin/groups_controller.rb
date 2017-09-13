class Admin::GroupsController < Admin::AdminController
    before_action :set_group, only: [:show, :edit, :update, :destroy]

    def before_init
        super
        @category = t(:menu_user)
        @controller_name = t('activerecord.models.group')
    end

    # GET /groups
    # GET /groups.json
    def index
        params[:per_page] = 10 unless params[:per_page].present?

        @groups = Group.order('id desc').page(params[:page]).per(params[:per_page])

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @groups }
        end
    end

    def show; end

    # GET /groups/new
    # GET /groups/new.json
    def new
        @group = Group.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @group }
        end
    end

    # GET /groups/1/edit
    def edit; end

    # POST /groups
    # POST /groups.json
    def create
        @group = Group.new(group_params)

        respond_to do |format|
            if @group.save
                format.html { redirect_to admin_group_path(@group), notice: @controller_name + t(:message_success_insert) }
                format.json { render json: @group, status: :created, location: @group }
            else
                format.html { render :new }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /groups/1
    # PUT /groups/1.json
    def update
        respond_to do |format|
            if @group.update(group_params)
                format.html { redirect_to admin_group_path(@group), notice: @controller_name + t(:message_success_update) }
                format.json { head :no_content }
            else
                format.html { render :edit }
                format.json { render json: @group.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /groups/1
    # DELETE /groups/1.json
    def destroy
        @group.destroy

        respond_to do |format|
            format.html { redirect_to admin_groups_path }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_group
        @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
        params.require(:group).permit(:title, :enable)
    end
end
