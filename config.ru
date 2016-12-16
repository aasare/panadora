#\ -p 7788

require 'bundler'
Bundler.require :default, ENV['RACK_ENV']

$LOAD_PATH.push File.expand_path("../lib", __FILE__)
$LOAD_PATH.push File.expand_path("../app", __FILE__)

require 'cherry_pandora'
require 'application'

run CherryPandora::Application
