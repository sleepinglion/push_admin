class Group < ActiveRecord::Base
    validates_presence_of :title
    has_many :user, dependent: :restrict_with_error
end
