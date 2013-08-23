require_relative 'lib/setup'
require_relative 'lib/analytics'

class Population
  attr_accessor :analytics

  def initialize 
    areas = Setup.new().areas
    @analytics = Analytics.new(areas)
  end

  def menu
    system 'clear'
    p "Population Menu"
    p "________________"
    @analytics.options.each do |opt|
      p "#{opt[:menu_id]}. #{opt[:menu_title]}"
    end
  end

  def run
    stop = false
    while stop!= :exit do
      #runs menu
      self.menu
      #grab choice
      print "Choice: "
      choice = gets.strip.to_i
      #run choice
      stop = @analytics.run(choice)
      if stop == :exit
        p "Existing"
      else
        print "\nHit enter to continue "
        gets
      end
    end
  end

  print "Enter your name: "
  name = gets.strip

end

p = Population.new
p.run 