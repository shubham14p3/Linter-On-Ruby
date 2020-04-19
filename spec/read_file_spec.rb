require_relative '../lib/read_file.rb'

describe ReadFile do
  describe '#initialize' do
    it 'takes 1 argument as a path of the file' do
      expect { ReadFile.new('lib/student_codes/student_code1.rb') }.not_to raise_error
    end
  end
end
