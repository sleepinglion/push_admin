class PushMessage < ActiveRecord::Base
  self.table_name='rpush_notifications'
  validates_presence_of :title, :content

  def content_data=(content_data)
    picture_objs=[]

    if content_data[:picture_files].present?
      content_data[:picture_files].each do |picture_file|
        picture_objs << PushPreparePicture.create!(:photo => picture_file)
      end
    end

    if content_data[:picture_ids].present?
      content_data[:picture_ids].each do |picture_id|
        picture_objs << PushPreparePicture.find(picture_id)
      end
    end

    if picture_objs.empty?
      return false
    end

    picture_objs.reject{|_, v| v.blank?}
    #u_pictures=picture_objs.uniq { |item| item[:id]}
    b=picture_objs.map {|mx| mx[:photo].to_s+'^1^0'}
  end
end
