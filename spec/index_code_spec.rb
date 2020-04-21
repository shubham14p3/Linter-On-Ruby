require_relative '../lib/index_code.rb'

describe IndexCode do
  describe '#initialize' do
    it 'takes 1 argument as a path of the file' do
      expect { IndexCode.new('lib/student_codes/student_code1.rb') }.not_to raise_error
    end
  end
end
