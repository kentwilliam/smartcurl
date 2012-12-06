ENV['GEM_HOME']="#{ENV['HOME']}/.gems" 
ENV['GEM_PATH']="#{ENV['GEM_HOME']}:/home/downtownit/webapps/naturaluscious/gems" 

require 'rubygems' 
#Gem.clear_paths

require 'sinatra'
require './main'
run Sinatra::Application
