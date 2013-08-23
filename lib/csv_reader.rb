class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])(A-Z)/,'\1_\2').
    tr("-", "-").
    downcase
  end
end

class CSVReader

  attr_accessor :fname, :headers

  def initialize(filename)
    @fname = filename
  end

  def headers=(header_str)
    @headers = header_str.split(',')
    @headers.map! do |h|
      #removes quotes
      h.gsub!('"', '')
      #remove new line
      h.strip!
      #convert to symbol
      h.underscore.to_sym
    end
  end

  def create_hash(values)
    h = {}
    @headers.each_with_index do |header, i|
    #removes new ines from the value
    value = values[i].strip.gsub('"', '')
    h[header] = value unless value.empty
    end
    h
  end

  def read
    f = File.new(@fname, 'r')

    #grab headers
    self.headers = f.readline

    #loop over lines
    while (!f.eof? && next_line = f.readline)
      values = next_line.split(', ')
      hash = create_hash(values)
      yield(hash)
    end
  end
end


