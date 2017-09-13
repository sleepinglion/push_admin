class Admin < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :trackable, :validatable, :timeoutable
    validates_length_of :login_id, within: 4..40
    mount_uploader :photo, AdminUploader

    has_many :roles_admin
    has_many :role, through: :roles_admin

    def timeout_in
        1.day
    end

    def role?(role)
        !!self.role.find_by_title(role)
    end

    def email_required?
        false
    end
end
