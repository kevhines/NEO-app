require "pry"
require "require_all"
require "httparty"
require "date"
require 'io/console'
require 'terminal-table'
require 'commatose'
require 'cli-colorize'
require 'sqlite3'

require_all 'lib'

DB = {:conn => SQLite3::Database.new("db/NEO.db")}