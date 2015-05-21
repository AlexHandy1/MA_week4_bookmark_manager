require 'data_mapper'

class Favourite
  include DataMapper::Resource

  has n, :links, through: Resource #is this actually through links?
  belongs_to :user, :required => true

  property :id, Serial
  property :tick, String
end