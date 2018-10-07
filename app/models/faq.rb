class Faq < ActiveRecord::Base
  validates_presence_of :title
  translates :title
  belongs_to :faq_category, counter_cache: true
  has_one :faq_content, :foreign_key => :id, :dependent=>:destroy
  accepts_nested_attributes_for :faq_content, :allow_destroy => true
end
