require 'httparty'
class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(e, p)
    response = self.class.post('/sessions', body: {email: e, password: p  } )
    if response.code == 404 
      raise 'Invalid email or password.'
    else 
      @auth = response['auth_token']
    end 
  end 
end  