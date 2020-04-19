class ReadFile
  attr_accessor :line_orders
  def initialize(path)
    @path = path
    @file_name = path.match(%r{/\w*\.rb}).to_s[1..-1]
    begin
      @read_by_lines = File.readlines(@path)
    rescue StandardError => e
      @read_by_lines = []
      @message_file = "File couldn't read.\n" + e.to_s
    end
  end

  private

  def count_lines
    @read_by_lines.size
  end
end
