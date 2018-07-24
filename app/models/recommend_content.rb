class RecommendContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :recommend, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :recommend, :allow_destroy => true
end
