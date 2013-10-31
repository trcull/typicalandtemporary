
class SplashController < ApplicationController
  def index
    @stories = Story.all.order('created_at desc').limit(9)
    #TODO: select a random selection of nine recent stories
  end
end