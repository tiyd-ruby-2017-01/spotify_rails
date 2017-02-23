require 'httparty'
require 'byebug'

class SearchController < ApplicationController
  def index
    @search_term = params[:search_term]

    artist = get_artist

    unless artist.nil?
      @artist_id = artist[:id]
      @artist_name = artist[:name]
    end

    if @artist_id.nil?
      @albums = []
    else
      @albums = get_artist_albums
    end
  end

  private
  def get_artist
    response = HTTParty.get("https://api.spotify.com/v1/search?q=#{@search_term}&type=artist")

    return nil if response.code != 200

    return nil if no_match_found?(response)

    artist = response['artists']['items'].first
    id = artist['id']
    name = artist['name']

    { id: id, name: name }
  end

  def get_artist_albums
    response = HTTParty.get("https://api.spotify.com/v1/artists/#{@artist_id}/albums?limit=50")
    response['items'].map do |album|
      name = album['name']
      image = album['images'][1]['url']

      { name: name, image: image }
    end
  end

  def no_match_found?(response)
    response['artists']['total'] == 0
  end
end
