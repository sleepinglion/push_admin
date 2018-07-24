class Notice < ActiveRecord::Base
  is_impressionable
  validates_presence_of :title
  validates_length_of :title, :minimum => 4, :maximum => 60, :allow_blank => true  
  belongs_to :user, :autosave=>true
  has_one :notice_content, :foreign_key => :id, :dependent => :destroy
  accepts_nested_attributes_for :notice_content, :allow_destroy => true
end
