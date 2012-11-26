require 'sinatra'

require 'pp'
require 'slim'
require 'dm-core'
require 'dm-migrations'
#require 'logger'

# Model
require './config/database.rb'
require './models.rb'

# Controller
require './controller.rb'