require 'httparty'
require 'json'
require_relative 'roadmap.rb'
require_relative 'messages.rb'
class Kele
  include HTTParty, JSON, Roadmap, Messages  
  base_uri 'https://www.bloc.io/api/v1'

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

  def get_mentor_availability(mentor_id)
    url = '/mentors/'+ mentor_id.to_s + '/student_availability'
    response = self.class.get(url, body: {'id' => mentor_id}, headers: { 'authorization' => @auth_token}  )
    if response.code == 404 
      raise 'Sorry something went wrong..'
    else
      @mentor_availibility = parse(response.body)
    end
  end
end  