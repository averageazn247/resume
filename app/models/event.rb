class Event < ActiveRecord::Base
  attr_accessible :title, :description, :dayof, :creator
end
