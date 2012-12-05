require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'pp'
require 'slim'
#require 'logger'
require 'bluecloth'

# Helpers
require './helpers/authorization.rb'

# Models
require './config/database.rb'
require './models.rb'

require './config/environment.rb'

# Main controller
require './controller.rb'