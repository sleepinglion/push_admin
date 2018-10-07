class InvestmentType < ActiveRecord::Base
  validates_presence_of :title
  validates_length_of :title, :minimum => 2, :maximum => 60, :allow_blank => true 
  has_many :recommend, :foreign_key => :investment_type_id, :dependent => :destroy
end
