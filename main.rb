require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'pp'
require 'slim'
#require 'logger'

# Helpers
require './helpers/authorization.rb'

# Models
require './config/database.rb'
require './models.rb'

# Main controller
require './controller.rb'