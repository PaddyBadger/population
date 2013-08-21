requier_relative 'csv_reader'
require_relative 'area'

class Setup

  attr_accessor :areas

  def initialize
    csv = CSVReader.new("./zipcode-database.csv")
    
    @areas = []
    csv.read do |item|
      @areas << Area.new(item)
    end

    self

  end
end



