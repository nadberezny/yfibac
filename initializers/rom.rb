db_path = File.expand_path('../../db/cabify_db.yml', __FILE__)
lib_path = File.expand_path('../../lib', __FILE__)

$rom_config = ROM::Configuration.new(:yaml, db_path) do |c|
  c.auto_registration(lib_path, namespace: false)
end
