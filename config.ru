
require './config/environment'

use Rack::MethodOverride
run ApplicationController

begin
  fi_check_migration

  use Rack::MethodOverride

  run ApplicationController
rescue ActiveRecord::PendingMigrationError => err
  STDERR.puts err
  exit 1
end
