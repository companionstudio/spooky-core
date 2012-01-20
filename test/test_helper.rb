require 'yaml'
require 'rubygems'

dir = File.expand_path(File.dirname(__FILE__))
require File.join(dir, '../lib/spooky_core')

config = YAML.load_file(File.join(dir, 'config.yml'))
SpookyCore.configure(config['login'], config['secret'], config['gateway_token'])
