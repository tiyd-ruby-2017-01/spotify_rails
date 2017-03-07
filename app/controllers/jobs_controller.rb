require 'redis'
# require 'json'

class JobsController < ApplicationController
  def show
    @jid = params[:id]

    redis = Redis.new

    result = redis.exists("jobs:#{@jid}:completed")

    # artist = JSON.parse(redis.get("jobs:#{@jid}:artist"))
    # albums = JSON.parse(redis.get("jobs:#{@jid}:albums"))

    render json: { complete: result } #, artist: artist, albums: albums }
  end
end
