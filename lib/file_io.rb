def csv(photographs)
  contents = CSV.open "photographs.csv", headers: true, header_converters: :symbol
  contents.each do |row|
    @id = row[:id].to_i
    @name = row[:name]
    @artist_id = row[:artist_id]
    @year = row[:year]
    @photograph = Photograph.new(id, name, artist_id, year)
    @photographs << photograph
    puts @photographs
  end
end