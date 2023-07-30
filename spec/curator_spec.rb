require './lib/photograph'
require './lib/artist'
require './lib/curator'

RSpec.describe Curator do
  before(:each) do
    @curator = Curator.new   
    @photo_1 = Photograph.new({
      id: "1",      
      name: "Rue Mouffetard, Paris (Boy with Bottles)",      
      artist_id: "1",      
      year: "1954"      
      })       

    @photo_2 = Photograph.new({
      id: "2",      
      name: "Moonrise, Hernandez",      
      artist_id: "2",      
      year: "1941"      
      })

    @artist_1 = Artist.new({
        id: "1",      
        name: "Henri Cartier-Bresson",      
        born: "1908",      
        died: "2004",      
        country: "France"      
      })

    @artist_2 = Artist.new({
      id: "2",      
      name: "Ansel Adams",      
      born: "1902",      
      died: "1984",      
      country: "United States"      
      })      
  end

  it "exists with 0 photogrpahs" do
    expect(@curator).to be_instance_of(Curator)
    expect(@curator.photographs).to eq([])
  end

  it "adds photographs" do
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    expect(@curator.photographs).to eq([@photo_1, @photo_2])
  end

  it "exists with 0 artists" do
    expect(@curator.artists).to eq([])
  end

  it "adds artists" do
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)

    expect(@curator.artists).to eq([@artist_1, @artist_2])
    expect(@curator.find_artist_by_id("1")).to eq(@artist_1)
  end

  it 'return a list of all artists and their photographs' do
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    expected_result = {
      @artist_1 => [@photo_1],
      @artist_2 => [@photo_2]
    }

    expect(@curator.return_list).to be_a Hash
    expect(@curator.return_list).to eq(expected_result)
  end

  it 'return list of artists who have more than 1 photo' do
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    # require 'pry' ; binding.pry

    expect(@curator.more_than_one_photo).to be_a Array
    expect(@curator.more_than_one_photo).to eq([])
  end


  it 'return a list of `Photograph`s that were taken by a photographer from that country.' do
    @curator.add_artist(@artist_1)
    @curator.add_artist(@artist_2)
    @curator.add_photograph(@photo_1)
    @curator.add_photograph(@photo_2)

    # require 'pry' ; binding.pry
    expected_result = [@photo_1]
    # require 'pry' ; binding.pry

    expect(@curator.from_country("France")).to be_a Array
    expect(@curator.from_country("France")).to eq(expected_result)
  end

  it "adds photos from CSV paath" do
    expect(@curator.csv("photographs.csv"))

    expect(@curator.display_photos).to all(be_a(Photograph))
  end
end