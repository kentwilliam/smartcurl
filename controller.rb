# SITE

get "/" do
  slim :index
end


# ADMIN

before '/admin*' do
  protected!
  @defaults = {
    :article_title => '(new article)'
  }
  
  published = Article.all(:published.lt => DateTime.now, :order => [ :published.desc ])
  scheduled = Article.all(:published.gt => DateTime.now, :order => [ :published.desc ])
  unfinished = Article.all(:published => nil, :order => [ :modified.desc ])
  @articles = {
    :scheduled => scheduled,
    :published => published,
    :unfinished => unfinished
  }
end

before "/admin/articles/:id*" do
  puts "Getting article with id #{params[:id]}"
  @article = Article.get(params[:id])
end

# GETs
get "/admin*" do
  slim :admin
end

# POSTs
post "/admin/articles/new" do
  now = DateTime.now
  article = Article.create(
    :title => '',
    :content => '',
    :created => now,
    :modified => now
    )
  redirect "/admin/articles/#{article.id}"
end

post "/admin/articles/:id/update" do
  return unless @article

  published = DateTime.parse(params[:published]) rescue published = nil
  @article.update(
    :title => params[:title],
    :content => params[:content],
    :published => published,
    :modified => DateTime.now
    )

  redirect "/admin/articles/#{@article.id}"
end

post "/admin/articles/:id/images/upload" do
  puts Dir.pwd
  filename = 'public/uploads/' + params['file-0'][:filename]
  puts "Exists? " + (File.exists? filename).to_s
  File.open('public/uploads/' + params['file-0'][:filename], "w") do |f|
    f.write(params['file-0'][:tempfile].read)
  end
  "Success!"
  #{}"Uploading!"
  # Handle POST-request (Receive and save the uploaded file)
  #pp params
  # File.open('uploads/' + params['myfile'][:filename], "w") do |f|
  #   f.write(params['myfile'][:tempfile].read)
  # end
end