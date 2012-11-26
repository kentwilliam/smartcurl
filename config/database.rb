configure :development do
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/database.sqlite")
  DataMapper::Logger.new(STDOUT, :debug)
end

configure :production do
  DataMapper.setup(:default, 'postgres://user:password@hostname/database')
end