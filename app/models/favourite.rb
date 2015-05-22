require 'data_mapper'

class Favourite
  include DataMapper::Resource

  belongs_to :link, :required => true
  belongs_to :user, :required => true

  property :id, Serial
  property :tick, String
end