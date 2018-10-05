class CertificationContent < ActiveRecord::Base
  validates_presence_of :content
  belongs_to :certification, :foreign_key => :id, :autosave=>true
  accepts_nested_attributes_for :certification, :allow_destroy => true
end
