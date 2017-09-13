class Admin::PushMessagesController < Admin::AdminController
  def before_init
    super

    @sub_menu=t(:menu_push_message)
    @controller_name=t('activerecord.models.push_message')
  end


  # GET /notices
  # GET /notices.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @push_messages }
    end
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
    @push_message = PushMessage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @push_message }
    end
  end

  # GET /notices/new
  # GET /notices/new.json
  def new
    @push_message = PushMessage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @push_message }
    end
  end


  # POST /notices
  # POST /notices.json
  def create
    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("android_app")

    if(params[:send_type]=='all')
      aa=Device.select('registration_id').all
    else
      aa=Device.select('registration_id').where(:id=>params[:user_id])
    end

    n.registration_ids = aa.map { |x| x[:registration_id] }

    n.data = {:message => params[:title] }
    n.notification = { body: params[:content],title: params[:title]}

    respond_to do |format|
      if n.save!
        format.html { redirect_to admin_push_messages_path, :notice => @controller_name +t(:message_success_insert)}
        format.json { render :json => @push_message, :status => :created, :location => @push_message }
      else
        format.html { render :action => "new" }
        format.json { render :json => @push_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notices/1
  # PUT /notices/1.json
  def update
    @push_message = PushMessage.find(params[:id])

    respond_to do |format|
      if @push_message.update_attributes(params[:push_message])
        format.html { redirect_to @push_message, :notice => @controller_name +t(:message_success_update) }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @push_message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @push_message = PushMessage.find(params[:id])
    @push_message.destroy

    respond_to do |format|
      format.html { redirect_to notices_url }
      format.json { head :no_content }
    end
  end
end
