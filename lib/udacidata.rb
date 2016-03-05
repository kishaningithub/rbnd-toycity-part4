require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata < Module
  # Your code goes here!
  def self.create(attributes = nil)
    data = new(attributes)
    if data then
      CSV.open(filename, 'ab') do |csv|
        csv << [data.id] + attributes.values
      end
      create_finder_methods(attributes.keys)
    end
    data
  end
  
  def self.filename
    File.dirname(__FILE__) + "/../data/data.csv"
  end
  
  def self.all
    full_data = []
    CSV.foreach(filename, headers: true, :header_converters => :symbol) do |row|
      full_data << new(row)
    end
    full_data
  end
  
  def self.first(n = nil)
    if n
      all.first(n)
    else
      all.first
    end
  end
  
  def self.last(n = nil)
    if n
      all.last(n)
    else
      all.last
    end
  end
  
  def self.find(id)
    check_valid_id(id)
    all.select{ |row| row.id == id }.first
  end
  
  def self.destroy(id)
    check_valid_id(id)
    table = CSV.table(filename)
    value = NIL
    table.delete_if do |row|
      matches_delete_criteria = (row[:id] == id)
      value = new(row) if matches_delete_criteria
      matches_delete_criteria
    end
    File.open(filename, 'w') do |f|
      f.write(table.to_csv)
    end
    value
  end
  
  def self.where(options = {})
    output = []
    options.each do |key, value|
      search_result = all.select { |udacidata| udacidata.send(key) == value}
      if output.empty? then
        output = search_result
      else
        output = output & search_result
      end
    end
    output
  end
  
  def update(options={})
    hash = object_hash
    options.each do |key, value|
      hash[key] = value
    end
    updated_product = self.class.new(hash)
    self.class.destroy(updated_product.id)
    CSV.open(self.class.filename, 'ab') do |csv|
      csv << updated_product.object_hash.values
    end
    updated_product  
  end
  
  def self.check_valid_id(id)
    raise ProductNotFoundError if all.select{ |row| row.id == id }.empty?
  end
  
  def object_hash
    hash = {}
    instance_variables.each {|var| hash[var.to_s.delete("@").to_sym] = instance_variable_get(var) }
    hash
  end
  
end
