require_relative '../lib/check_errors.rb'

describe CheckErrors do
  instance = CheckErrors.new('lib/student_codes/student_code1.rb')
  describe '#initialize' do
    it 'takes 1 argument as a path of the file' do
      expect { CheckErrors.new('lib/student_codes/student_code1.rb') }.not_to raise_error
    end
    it 'creates an instance variable as an integer' do
      expect(instance.error_counter).to be_an_instance_of(Integer)
    end
  end

  describe '#error_counter' do
    it 'returns a number greater than or equals to zero' do
      expect(instance.error_counter).to be >= 0
    end
  end

  describe '#errors' do
    it 'returns a hash' do
      expect(instance.errors).to be_an_instance_of(Hash)
    end
  end
end
