require 'sequel'
require 'sqlite3'

enviorments = ["test", "enviroment"]
enviorments.each do |env|
  Sequel.sqlite("db/robots_#{env}.sqlite3").create_table(:robots) do
    primary_key :id
    String      :name
    String      :city
    String      :state
    String      :avatar
    String      :birthdate
    String      :date_hired
    String      :department
  end
  puts "Migrated #{env} enviroment"
end
