# ./spec/linter_spec.rb
require_relative '../lib/rules.rb'
require_relative '../lib/filesize'
require_relative '../lib/maxlinelength'
require_relative '../lib/indentation'
require_relative '../lib/trailingwhitespace'
require_relative '../lib/emptyeofline'

file_name1 = './test/enumerable.rb'
exit false unless File.exist?(file_name1)
file = File.open(file_name1)
file_data1 = file.readlines.map(&:chomp)
file.close

file_name2 = './test/test_file.rb'
exit false unless File.exist?(file_name2)
file = File.open(file_name2)
file_data2 = file.readlines.map(&:chomp)
file.close

RSpec.describe FileSize do
  rule_obj = FileSize.new('Max. Number of lines per file')
  describe '#parse' do
    it 'Compares the number of lines in file1 with the maximum allowed' do
      expect(rule_obj.parse(file_data1, file_name1)).to be true
    end
    it 'Compares the number of lines in file2 with the maximum allowed' do
      expect(rule_obj.parse(file_data2, file_name2)).to be false
    end
    it 'Adds a report line to the class attribute report' do
      expect(Rule.give_report.count).to eql 1
    end
  end
end

RSpec.describe MaxLineLength do
  rule_obj = MaxLineLength.new('Max. Number of characters per line')
  describe '#parse' do
    it 'Checks if the length of any code line in file 1 is more than 80 char' do
      expect(rule_obj.parse(file_data1, file_name1)).to be true
    end
    it 'Adds six report lines to the class attribute report' do
      expect(Rule.give_report.count).to eql 7
    end
    it 'Checks if the length of any code line in file 2 is more than 80 char' do
      expect(rule_obj.parse(file_data2, file_name2)).to be false
    end
  end
end

RSpec.describe Indentation do
  rule_obj = Indentation.new('Unexpected indentation')
  describe '#parse' do
    it 'Checks every code line in file 1 to have the correct indentation' do
      expect(rule_obj.parse(file_data1, file_name1)).to be false
    end
    it 'Checks every code line in file 2 to have the correct indentation' do
      expect(rule_obj.parse(file_data2, file_name2)).to be true
    end
    it 'Adds a report line to the class attribute report' do
      expect(Rule.give_report.count).to eql 8
    end
  end
  describe '#indentation' do
    line = "    puts \'Hello world!\'"
    it 'Returns the number of spaces at the beginning of a line' do
      expect(rule_obj.indentation(line)).to eql(4)
    end
  end
  describe '#guard_clause?' do
    line = 'return unless File.exists?(file_name)'
    it 'Returns true when detects a guard clause' do
      expect(rule_obj.guard_clause?(line)).to be true
    end
  end
  describe '#unexpected?' do
    it 'Returns false if the indentation of a line corresponds with the previous' do
      expect(rule_obj.unexpected?(2, 4)).to be false
    end
    it 'Returns true if the indentation of a line does not correspond with the previous' do
      expect(rule_obj.unexpected?(0, 3)).to be true
    end
  end
end

RSpec.describe TrailingWhiteSpace do
  rule_obj = TrailingWhiteSpace.new('Trailing white space')
  describe '#parse' do
    it 'Checks every code line in file 1 for trailing white spaces' do
      expect(rule_obj.parse(file_data1, file_name1)).to be false
    end
    it 'Adds a report line to the class attribute report' do
      expect(Rule.give_report.count).to eql 8
    end
    it 'Checks every code line in file 2 for trailing white spaces' do
      expect(rule_obj.parse(file_data2, file_name2)).to be true
    end
    it 'Adds a report line to the class attribute report' do
      expect(Rule.give_report.count).to eql 9
    end
  end
end

RSpec.describe EmptyEOFLine do
  rule_obj = EmptyEOFLine.new('No empty line at EOF')
  describe '#parse' do
    it 'Checks file 2 for lack of EOF empty line' do
      expect(rule_obj.parse(file_data2, file_name2)).to be true
    end
    it 'Adds a report line to the class attribute report' do
      expect(Rule.give_report.count).to eql 10
    end
  end
end
