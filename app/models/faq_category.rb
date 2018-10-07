class FaqCategory < ActiveRecord::Base
    validates_presence_of :title
    translates :title
    has_many :faq, dependent: :destroy
end
