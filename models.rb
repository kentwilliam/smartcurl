class Article
  include DataMapper::Resource
  
  property :id,         Serial
  property :title,      String
  property :content,    Text
  property :created,    DateTime
  property :published,  DateTime
  property :modified,   DateTime

  has n, :uploads, :through => Resource
end

class Upload
  include DataMapper::Resource

  property :id,         Serial
  property :filename,   String

  has n, :articles, :through => Resource
end




# Tags
# Authors
# Comments
DataMapper::Model.raise_on_save_failure = true

DataMapper.finalize
DataMapper.auto_upgrade!