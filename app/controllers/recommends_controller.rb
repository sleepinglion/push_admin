class RecommendsController < ApplicationController
  before_action :set_recommend, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.recommend')
  end

  # GET /recommends
  # GET /recommends.json
  def index
    @recommends = Recommend.order(:id=>'desc').page(params[:page]).per(15)
  end

  # GET /recommends/1
  # GET /recommends/1.json
  def show
  end

  # GET /recommends/new
  def new
    @recommend = Recommend.new
    @recommend.build_recommend_content

    @script="board/new"
  end

  # GET /recommends/1/edit
  def edit
    @script="board/edit"
  end

  # POST /recommends
  # POST /recommends.json
  def create
    @recommend = Recommend.new(recommend_params)
    @recommend.user_id=current_user.id

    @script="board/new"

    respond_to do |format|
      if @recommend.save
        format.html { redirect_to @recommend, recommend: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @recommend }
      else
        format.html { render action: 'new' }
        format.json { render json: @recommend.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommends/1
  # PATCH/PUT /recommends/1.json
  def update
    @script="board/edit"

    respond_to do |format|
      if @recommend.update(recommend_params)
        format.html { redirect_to @recommend, recommend: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recommend.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommends/1
  # DELETE /recommends/1.json
  def destroy
    @recommend.destroy

    respond_to do |format|
      format.html { redirect_to recommends_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_recommend
    @recommend = Recommend.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recommend_params
    params.require(:recommend).permit(:id,:title,recommend_content_attributes: [:id,:content])
  end
end
