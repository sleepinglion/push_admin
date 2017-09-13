class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :trackable, :recoverable, :validatable, :timeoutable
    validates_presence_of :login_id
    validates_length_of :name, within: 1..60, allow_blank: true
    validates_uniqueness_of :login_id, allow_blank: true
    belongs_to :group, counter_cache: true
    has_many :device
    mount_uploader :sign, UserUploader
    validate :password_complexity, :on=>:create

    def password_complexity
      password_comp=0

      if password.present? and password.match(/\A(?=.*[a-z])/x)
        password_comp=password_comp+1
      #  puts('string exists')
      end

      if password.present? and password.match(/\A(?=.*\d)/x)
        password_comp=password_comp+1
      #  puts('number exists')
      end

      if password.present? and password.match(/\A(?=.*[?<>',?\[\]}{=)(*&^%$#`~{}@-])/x)
        password_comp=password_comp+1
      #  puts('special char exists')
      end

      if password_comp < 2
        errors.add :password,"는 문자와 숫자가 최소 하나씩은 포함되어야합니다."
      end
    end

    def title
        "#{id} : #{name} / #{barcode}"
    end

    def email
      return self.login_id
    end

    def created_date
      self.created_at.to_date
    end

    def email_required?
        false
    end

    def email_changed?
        false
    end
end
