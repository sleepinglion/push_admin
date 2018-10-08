class RecommendsGroup < ActiveRecord::Base
    belongs_to :recommend, autosave: true
    belongs_to :group, autosave: true
    accepts_nested_attributes_for :group, allow_destroy: true
end
