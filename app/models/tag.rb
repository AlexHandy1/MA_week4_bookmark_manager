require 'data_mapper'

class Tag
  include DataMapper::Resource
  has n, :links, through: Resource

  validates_presence_of :text

  property :id, Serial
  property :text, String
end