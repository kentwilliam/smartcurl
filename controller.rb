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
  return unless @article

  path = 'public/uploads/'
  filename = params['file-0'][:filename]
  basename = File.basename(filename)

  # Extension is everything after last period (.)
  split_at  = basename.rindex('.')
  name      = basename[0..split_at-1]
  extension = basename[split_at+1..basename.length]

  # Only allow image uploads for now
  return unless ['png','gif','jpg','jpeg'].any?{ |e| e.casecmp(extension) == 0 }

  # If file exists already, create duplicate filename by adding _0 _1 etc.
  i = 1
  while File.exists?(path + filename)
    filename = name + '_' + i.to_s + '.' + extension
    i += 1
  end

  # Write file
  File.open(path + filename, "w") do |f|
    f.write(params['file-0'][:tempfile].read)
  end

  # Create link to article
  upload = Upload.create(
    :filename => filename
    )
  @article.uploads << upload
  @article.save

  # Return partial for display
  @image = upload
  slim :image, :layout => false
end