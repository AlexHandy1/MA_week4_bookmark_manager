require 'data_mapper'

class Link
  include DataMapper::Resource
  has n, :tags, through: Resource
  has n, :favourites, :through => :user
  belongs_to :user, :required => true

  property :id, Serial
  property :title, String
  property :url, String
  property :description, String
  property :source, String
end