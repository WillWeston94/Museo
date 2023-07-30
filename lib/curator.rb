class Curator
  attr_reader :photographs, :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist.id.to_s == id.to_s
    end
  end

  def return_list
    return_list = {}

    @artists.each do |artist|
      photos = @photographs.select { |photo| photo.artist_id.to_s == artist.id.to_s }
      return_list[artist] = photos
      end
    return_list
  end

  def more_than_one_photo
    return_list = Hash.new(0)

    @photographs.each do |photo|
      return_list[photo.artist_id.to_s] += 1
    end

    more_than_one_photo = []

    @artists.each do |artist|
      more_than_one_photo  << artist.name if return_list[artist.id.to_s] > 1
    end
    more_than_one_photo
  end

  def from_country(country)
    @photographs.select do |photo|
      @artist = find_artist_by_id(photo.artist_id)
      @artist.country == country
    end
  end
end