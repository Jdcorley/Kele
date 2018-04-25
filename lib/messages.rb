module Messages 

  def get_messages(page=nil)
    if page == nil 
      response = self.class.get('/message_threads', headers: { 'authorization' => @auth_token}  )
    else 
      response = self.class.get('/message_threads', body:{ 'page' => page }, headers: { 'authorization' => @auth_token}  )
    end 
    if response.code == 404 
      raise 'Sorry something went wrong..'
    else 
      @messages = parse(response.body)
    end
  end 

  def create_message(email, recipient_id, subject, message )
    response = self.class.post('/messages', body: { 'sender' => email, 
                                                    'recipient_id' => recipient_id,
                                                    'subject' => subject,
                                                    'stripped-text' => message },
                                         headers: { 'authorization' => @auth_token } )
    if response.code == 404 
      raise 'Invalid email or password.'
    else 
      return response 
    end 
  end
end 