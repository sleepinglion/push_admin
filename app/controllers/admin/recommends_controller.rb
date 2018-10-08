class Admin::RecommendsController < Admin::AdminController
    before_action :set_recommend, only: [:show, :edit, :update, :destroy]

    def before_init
        super
        @category = t(:menu_user)
        @controller_name = t('activerecord.models.recommend')
    end

    # GET /recommends
    # GET /recommends.json
    def index
        params[:per_page] = 10 unless params[:per_page].present?

        @admin_recommends = Recommend.order('id desc').page(params[:page]).per(params[:per_page])

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @admin_recommends }
        end
    end

    def show; end

    # GET /recommends/new
    # GET /recommends/new.json
    def new
        @admin_recommend = Recommend.new
        @admin_recommend.build_recommend_content

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @admin_recommend }
        end
    end

    # GET /recommends/1/edit
    def edit; end

    # POST /recommends
    # POST /recommends.json
    def create
        @admin_recommend = Recommend.new(recommend_params)

        respond_to do |format|
            if @admin_recommend.save
                format.html { redirect_to admin_recommend_path(@admin_recommend), notice: @controller_name + t(:message_success_insert) }
                format.json { render json: @admin_recommend, status: :created, location: @admin_recommend }
            else
                format.html { render :new }
                format.json { render json: @admin_recommend.errors, status: :unprocessable_entity }
            end
        end
    end

    # PUT /recommends/1
    # PUT /recommends/1.json
    def update
        respond_to do |format|
            if @admin_recommend.update(recommend_params)
                format.html { redirect_to admin_recommend_path(@admin_recommend), notice: @controller_name + t(:message_success_update) }
                format.json { head :no_content }
            else
                format.html { render :edit }
                format.json { render json: @admin_recommend.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /recommends/1
    # DELETE /recommends/1.json
    def destroy
        @admin_recommend.destroy

        respond_to do |format|
            format.html { redirect_to admin_recommends_path }
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_recommend
        @admin_recommend = Recommend.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recommend_params
        params.require(:recommend).permit(:id,:title,:title,:buy_date,:buy_price,:sell_date,:sell_price,recommend_content_attributes: [:id,:content]).merge(admin_id: current_admin.id)
    end
end
