class EmptyEOFLine < Rule
  def parse(file_data, file_name)
    @broken = false
    code_line = file_data.last.nil? ? '' : file_data.last
    chars = code_line.split(//)
    last = chars.last
    unless last =~ /\n/
      add_to_report(file_name, 0, @name, nil)
      @broken = true
    end
    @broken
  end
end
