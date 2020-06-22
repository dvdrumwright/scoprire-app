require_relative './config/environment'




use Rack::MethodOverride
use CyclistsController
use RidesController
run ApplicationController
