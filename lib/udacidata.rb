require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  # Your code goes here!
  def self.create(attributes = nil)
    if attributes then
        CSV.open(self.filename, 'ab') do |csv|
          csv << attributes.values
        end
    end
    self.new(attributes)
  end 
  
  def self.filename
    File.dirname(__FILE__) + "/../data/data.csv"
  end
  
end
