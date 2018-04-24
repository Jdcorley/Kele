require 'httparty'
require 'json'
class Kele
  include HTTParty, JSON
  base_uri 'https://www.bloc.io/api/v1'
  attr_reader :auth_token

  def initialize(e, p)
    response = self.class.post('/sessions', body: {email: e, password: p  } )
    if response.code == 404 
      raise 'Invalid email or password.'
    else 
      @auth_token = response['auth_token']
    end
  end 

  def get_me
    response = self.class.get('/users/me', headers: { 'authorization' => @auth_token} )
    if response.code == 404 
      raise 'Sorry something went wrong..'
    else
      @user_data = parse(response.body)
    end
  end 
end  