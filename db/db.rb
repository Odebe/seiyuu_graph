# frozen_string_literal: true

require_relative './migrations.rb'

Dir[File.dirname(__FILE__) + '/relations/**/*.rb'].each { |file| require_relative file }
Dir[File.dirname(__FILE__) + '/repositories/**/*.rb'].each { |file| require_relative file }


config = ROM::Configuration.new(:sql, 'sqlite:://db-file.db')
config.register_relation Graphs::Relation
$rom = ROM.container(config)


# module DB
#   module_function

#   def setup
#     config = ROM::Configuration.new(:sql, 'sqlite::Memory')
#     config.register_relation Graphs::Relation
#     $rom = ROM.container(config)
#   end
# end

# config = ROM::Configuration.new(:sql, 'sqlite::Memory')

# config.register_relation Graphs::Relation

# $rom = ROM.container(config)
