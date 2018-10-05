class CertificationsController < ApplicationController
  before_action :set_certification, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.certification')
  end

  # GET /certificationss
  # GET /certificationss.json
  def index
    @certifications = Certification.order(:id=>'desc').page(params[:page]).per(4)
  end

  # GET /certificationss/1
  # GET /certificationss/1.json
  def show
  end

  # GET /certificationss/new
  def new
    @certification = Certification.new
    @certification.build_certification_content

    @script="board/new"
  end

  # GET /certificationss/1/edit
  def edit
    @script="board/edit"
  end

  # POST /certificationss
  # POST /certificationss.json
  def create
    @certification = Certification.new(certification_params)
    @certification.user_id=current_user.id

    @script="board/new"

    respond_to do |format|
      if @certification.save
        format.html { redirect_to @certification, certification: @controller_name +t(:message_success_create)}
        format.json { render action: 'show', status: :created, location: @certifications }
      else
        format.html { render action: 'new' }
        format.json { render json: @certification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certificationss/1
  # PATCH/PUT /certificationss/1.json
  def update
    @script="board/edit"

    respond_to do |format|
      if @certifications.update(certifications_params)
        format.html { redirect_to @certifications, certifications: @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @certifications.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certificationss/1
  # DELETE /certificationss/1.json
  def destroy
    @certifications.destroy

    respond_to do |format|
      format.html { redirect_to certificationss_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_certification
    @certification = Certification.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def certification_params
    params.require(:certification).permit(:id,:title,certification_content_attributes: [:id,:content])
  end
end
