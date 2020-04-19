class Rule
  @@report = [] # rubocop:disable Style/ClassVars
  attr_reader :name, :msg, :broken
  def initialize(name)
    @name = name
    @broken = false
    @line = 0
  end

  def parse(arr, name); end

  def self.give_report
    @@report.sort_by { |a, b| a[1] <=> b[1] }
  end

  private

  def broken?
    @broken
  end

  def add_to_report(file_name, line, name, info)
    @@report << [file_name, line, name, info]
  end
end
