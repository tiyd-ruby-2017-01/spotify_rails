require 'byebug'

class SearchController < ApplicationController
  def index
    @search_term = params[:search_term]

    @jid = HardWorker.perform_async(@search_term)
  end

  def show
    @jid = params[:id]

    redis = Redis.new

    completed = redis.exists("jobs:#{@jid}:completed")
    if completed
      @search_term = redis.get("jobs:#{@jid}:search_term")
      @artist = JSON.parse(redis.get("jobs:#{@jid}:artist"))
      @albums = JSON.parse(redis.get("jobs:#{@jid}:albums"))

      unless @artist.nil?
        @artist_id = @artist['id']
        @artist_name = @artist['name']
      end
    end
  end
end
