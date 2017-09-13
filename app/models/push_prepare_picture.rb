class PushPreparePicture < ActiveRecord::Base
    mount_uploader :photo, PushPreparePictureUploader
end
