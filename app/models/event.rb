class Event < ActiveRecord::Base
  attr_accessible :title, :description, :dayof, :creator
  attr_accessible :avatar
  has_attached_file :avatar
end
