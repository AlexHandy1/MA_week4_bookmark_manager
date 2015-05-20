require 'data_mapper'

class Link
  include DataMapper::Resource
  has n, :tags, through: Resource

  validates_presence_of :title, :url, :tags

  property :id, Serial
  property :title, String
  property :url, String
  property :description, String
end