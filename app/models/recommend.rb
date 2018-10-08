class Recommend < ActiveRecord::Base
  is_impressionable
  validates_presence_of :title
  validates_length_of :title, :minimum => 2, :maximum => 60, :allow_blank => true  
  belongs_to :investment_type, :autosave=>true
  belongs_to :admin, :autosave=>true
  has_many :recommends_group, dependent: :destroy
  has_many :group, through: :recommends_group, dependent: :destroy  
  has_one :recommend_content, :foreign_key => :id, :dependent => :destroy  
  accepts_nested_attributes_for :recommend_content, :allow_destroy => true
end
