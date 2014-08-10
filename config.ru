# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

use Rack::CanonicalHost, 'ctfi.cc', if: /.*\.ctfi\.cc/
use Rack::CanonicalHost, 'gtfo.cc', if: /.*\.gtfo\.cc/

run GTFOCTFI::Application
