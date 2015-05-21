require 'data_mapper'

class Tag
  include DataMapper::Resource

  has n, :links, through: Resource
  belongs_to :user, :required => true

  property :id, Serial
  property :text, String
end