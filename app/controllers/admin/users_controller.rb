class Admin::UsersController < Admin::AdminController
  include SearchDate
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def before_init
      super
    @category=t(:menu_user)
    @controller_name=t('activerecord.models.user')
  end

  def user_id_select
  end

  def user_id_select_search_result

    like=true
    case params[:find_method]
      when 'email'
        condition_sql='login_id like ?'
      when 'barcode'
        condition_sql='barcode like ?'
      when 'name'
        condition_sql='name like ?'
      else
        like=false
    end

    unless params[:per_page].present?
      params[:per_page]=20
    end

    if like
      @user_count = User.where(:enable=>true).where.not(:phone=>nil).where(condition_sql,'%'+params[:search].strip+'%').count
      @users = User.order('id desc').where(:enable=>true).where.not(:phone=>nil).where(condition_sql,'%'+params[:search].strip+'%').page(params[:page]).per(params[:per_page])
    else
      @user_count = User.where(:enable=>true).where.not(:phone=>nil).count
      @users = User.order('id desc').where(:enable=>true).where.not(:phone=>nil).page(params[:page]).per(params[:per_page])
    end

    if(@user_count.zero?)
      a={:count=>@user_count}
    else
      a={:count=>@user_count,:list=>@users}
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => a }
    end
  end

  def create_pdf_agreement(user_id)
      @user = User.where(id: user_id).first
      @stylesheet='pdf_agreement';

      respond_to do |format|
          format.html
          format.pdf do
              @pdf = render_to_string(
                  pdf: 'file_name',
                  viewport_size: '1280x1024',
                  formats: [:html],
                  template: 'admin/users/export',
                  layout: 'pdf',
                  page_size: 'A4',
                  # :print_media_type => true,        # Passes `--print-media-type`
                  grayscale: false,
                  background: true,
                  no_background: false,
                  margin: { top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0 }
              )

              File.open(Rails.root.join('file', 'pdfs', pdf_filename(@user.id)), 'wb') do |f|
                  f.write(@pdf)
              end

              Rails.root.join('file', 'pdfs', pdf_filename(@user.id))
          end
      end
  end

  # POST /download_agreement
  # POST /download_agreement.json
  def download_agreement
      @user = User.where(id: params[:user_id]).first
      pdf_file = Rails.root.join('file', 'pdfs', pdf_filename(@user.barcode))

      pdf_file = create_pdf_agreement(@user) unless File.exist? pdf_file

      if @user
          respond_to do |format|
              format.html
              format.pdf do
                  send_file(pdf_file, filename: 'agreement_'+ @user.id.to_s + '(' + Time.now.to_s + ').pdf', type: 'application/pdf')
              end
          end
      else
          format.html { redirect_to admin_report_character_path(@report_export), notice: @controller_name + t(:message_success_update) }
          format.pdf { render json: @user.errors, status: :unprocessable_entity }
      end
  end

  # GET /users
  # GET /users.json
  def index
    params[:per_page] = 20 unless params[:per_page].present?

    condition_sql="1=1 "
    sql_params=[]

    if params[:name].present?
      condition_sql+="AND name like ? "
      sql_params << '%'+params[:name].strip+'%'
    end

    if params[:barcode].present?
      condition_sql+="AND barcode like ? "
      sql_params << '%'+params[:barcode].strip+'%'
    end

    if params[:enable].present?
      condition_sql+="AND enable=? "
      sql_params << params[:enable]
    end

    if params[:group_id].present?
      condition_sql+="AND group_id=? "
      sql_params << params[:group_id]
    end

    if params[:start_date].present? and params[:date_p] != 'false'
      condition_sql+="AND created_at between ? AND ?"
      sql_params << change_date(params[:start_date],false)
      sql_params << change_date(params[:end_date])
    end

    @users_all_count=User.where(condition_sql,*sql_params).count
    @users = User.where(condition_sql,*sql_params).order('id desc').page(params[:page]).per(params[:per_page])
    @script='admin/users/index'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show;end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    if current_admin.role[0].title=='exporter'
      @category=t(:menu_report)
      @sub_menu=t(:submenu_report)
      @controller_name=t('activerecord.models.report')
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_user_path(@user), :notice => @controller_name +t(:message_success_insert)}
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :new }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to admin_user_path(@user), :notice => @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => @controller_name +t(:message_success_delete)  }
      format.json { head :no_content }
    end
  end

  def export_csv
    unless params[:user_ids].present?
      respond_to do |format|
        format.csv { redirect_to admin_users_path, :alert => t(:not_submit_user_id)}
        format.json { head :no_content }
      end
      return false
    end

    require 'csv'
    @users=User.where(:id=>params[:user_ids],:enable=>true).order(:id=>'asc').all
    @genes_related_action=GenesRelatedAction.where(:enable=>true).all

    gene_titles=@genes_related_action.map {|genes_related_action| genes_related_action.position }

    respond_to do |format|
      format.csv do
        # Add BOM to make excel using utf8 to open csv file
        head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join()

        csv_str = CSV.generate(csv = head) do |csv|

          csv << ['바코드','이름','생년월일','성별','키','몸무게']+gene_titles
          @users.each do |user|
            if user.sex
              sex=t(:male)
            else
              sex=t(:female)
            end

            user_a=[user.barcode,user.name,user.birthday,sex,user.height,user.weight]
            genotypes=[]


            report_ids= user.reports.map{ |report| report.id}
            reports_genes_related_actions=ReportsGenesRelatedAction.where(:report_id=>report_ids,:enable=>true).order(:genes_related_action_id=>'asc').all
            genotypes=reports_genes_related_actions.map {|reports_genes_related_action| reports_genes_related_action.genotype}

            csv << user_a +genotypes
          end
        end

        send_data(csv_str, :type=>"text/csv",:filename => "export.csv")
      end
    end
  end

  def destroy_multiple
    unless params[:user_ids].present?
      respond_to do |format|
        format.html { redirect_to admin_users_path, :alert => t(:not_submit_user_id)}
        format.json { head :no_content }
      end
      return false
    end

    User.destroy(params[:user_ids])

    respond_to do |format|
      format.html { redirect_to admin_users_path, :notice => @controller_name +t(:message_success_delete)  }
      format.json { head :no_content }
    end
  end

  private

  def pdf_filename(barcode)
      filename = "agreement_#{barcode}_#{I18n.locale}.pdf"
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:login_id,:group_id,:report_process_id,:barcode,:name,:password,:password_confirmation,:phone,:birthday,:sex,:height,:weight,:sign,:enable)
  end
end
