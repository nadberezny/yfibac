require 'dry-container'
require 'dry-auto_inject'
require 'rom-yaml'
require 'pry'

initializers = File.expand_path('../initializers', __FILE__)
Dir["#{initializers}/**/*.rb"].each { |file| require file }

lib = File.expand_path('../lib', __FILE__)
Dir["#{lib}/**/*.rb"].each { |file| require file }