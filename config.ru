require_relative 'config/environment'

use Rack::MethodOverride
use UserController
# use OtherController

run ApplicationController