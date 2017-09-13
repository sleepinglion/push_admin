module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def asset_data_uri path
    asset = (Rails.application.assets || ::Sprockets::Railtie.build_environment(Rails.application)).find_asset path

    throw "Could not find asset '#{path}'" if asset.nil?

    base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
    "data:#{asset.content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def color_display(color)
    raw '<span style="display:inline-block;width:20px;height:20px;background:'+color+'">&nbsp;</span> '+color
  end

  def report_process_status(user)
    if user.orders_count.zero?
      return t(:report_status1)
    end

    if user.kit_id.nil?
      return t(:report_status2)
    else
      return t(:report_status3)
    end
  end

  def content_data_to_string(content_data)
    content_data.split('|').map {|aa| aa.gsub('^1^0','')}.join(' , ')
  end

  def current_status(counts)
    unless counts[:reports_count].zero?
      return t(:admin_report_process4)
    end

    if counts[:orders_count].zero?
      return t(:admin_report_process1)
    end

    if counts[:kit_id].nil?
      return t(:admin_report_process2)
    end

    if counts[:reports_count].zero?
      return t(:admin_report_process3)
    end

    return t(:admin_report_process4)
  end

  def virtual_number(total,index)
    if params[:page].present?
      page=params[:page].to_i-1
    else
      page=0
    end

    if params[:per_page].present?
      per_page=params[:per_page].to_i
    else
      per_page=10
    end

    return total-(page*per_page)-index
  end

  def match_factor_display(genotype,factor)
    if genotype.nil?
        return
    end

    if factor.nil?
      return
    end

    raw genotype.gsub('/','').gsub(factor,'<b class="red">'+factor+'</b>')
  end

  def hex_to_rgb input
    a = ( input.match /#(..?)(..?)(..?)/ )[1..3]
    a.map!{ |x| x + x } if input.size == 4
    "#{a[0].hex},#{a[1].hex},#{a[2].hex}"
  end

  def sexToString(sex,trans=true)
    if sex.nil?
      if trans
        return t(:not_insert)
      else
        return 'not_insert'
      end
    else
    if sex
      if trans
        return t(:male)
      else
        return 'male'
      end
    else
      if trans
        return t(:female)
      else
        return 'female'
      end
    end
  end
  end

  def flagToString(flag,no_html=false)
    if no_html
      if flag
        return t(:flag_true)
      else
        return t(:flag_false)
      end
    else
      if flag
        return '<span class="flag_true">'+t(:flag_true)+'</span>'
      else
        return '<span class="flag_false">'+t(:flag_false)+'</span>'
      end
    end
  end

  def mmsResultToString(result)
    if result==2
      return t(:success)
    else
      return '<span class="red">'+t(:fail)+'</span>'
    end
  end

  def confirmToString(confirm,no_html=false)
    if no_html
      if confirm
        return t(:confirm)
      else
        return t(:unconfirmed)
      end
    else
      if confirm
        return '<span class="confirm_true">'+t(:confirm)+'<span>'
      else
        return '<span class="confirm_false">'+t(:unconfirmed)+'</span>'
      end
    end
  end

  def actionNameChange(action_name)
    case action_name
    when 'index'
      return t(:action_index)
    when 'new'
      return t(:action_new)
    when 'edit'
      return t(:action_edit)
    when 'show'
      return t(:action_show)
    else
    end
  end

  def manage_width(model)
    if can?(:delete, model) && can?(:update, model)
      return 'style="width:180px;"'
    else
      return 'style="width:90px"'
    end
  end
end
