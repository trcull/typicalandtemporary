require 'oauth'
require 'twitter'

class StoryController < ApplicationController
  #see: http://cbpowell.wordpress.com/2011/03/17/twitter-oauth-and-ruby-on-rails-integrated-cookbook-style-in-the-console-updated-for-twitter-1-0/
  def authorize
    oa = OAuth::Consumer.new(ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"], 
          :site => 'http://api.twitter.com', 
          :request_endpoint => 'http://api.twitter.com',
          :oauth_callback=>ENV["TWITTER_CALLBACK"], 
          :sign_in => true,
          :scheme => :header) 
    
    rt = oa.get_request_token(:oauth_callback=>ENV["TWITTER_CALLBACK"])
    #TODO: handle case when request token is denied by Twitter
    
    session[:request_token] = rt
    #TODO: handle case when either parameter is blank
    session[:my_story] = params[:my_story]
    session[:twitter_handle] = params[:twitter_handle]
    redirect_to "http://api.twitter.com/oauth/authorize?oauth_token=#{rt.token}&oauth_callback=#{CGI::escape(ENV["TWITTER_CALLBACK"])}"          
  end
  
  def oauth_callback
    Rails.logger.info "got twitter callback with params #{params.inspect}"
    
    rt = session[:request_token]
    Rails.logger.info "request token #{rt.inspect}"
    
    #TODO: handle case when request_token is missing from session
    
    #TODO: check for error messages from twitter and the absence of the oauth_verifier parameter then display screen to user
    access_token = rt.get_access_token(:oauth_verifier=>params[:oauth_verifier])
    Rails.logger.info "access token #{access_token.inspect}"
    #TODO: check that access token was actually granted
    
    client = Twitter::Client.new do |config|
      config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
      config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
      config.access_token        = access_token.token
      config.access_token_secret = access_token.secret
    end
    
    #TODO: check that client is actually valid
    #TODO: handle case when twitter_handle is missing from session   
    user = client.user(session[:twitter_handle])
    Rails.logger.info "User #{user.screen_name}:#{user.profile_image_url_https}: #{user.inspect}"
    
    story = Story.new
    story.twitter_handle = user.screen_name
    #TODO: handle case when my_story is missing from session
    story.my_story = session[:my_story]
    story.profile_image_url = user.profile_image_url_https
    #TODO: handle case when Story doesn't save
    story.save!
    
    redirect_to '/thank_you'
  end
  
  
  def thank_you
    
  end
end