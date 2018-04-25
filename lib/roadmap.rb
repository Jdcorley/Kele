module Roadmap

  def get_roadmap(chain_id)
    url = '/roadmaps/'+ chain_id.to_s
    response = self.class.get(url, body: {'id' => chain_id}, headers: { 'authorization' => @auth_token}  )
    if response.code == 404 
      raise 'Sorry something went wrong..'
    else 
      @roadmap = parse(response.body)
    end 
  end 

  def get_checkpoint(checkpoint_id)
    url = '/checkpoints/'+ checkpoint_id.to_s
    response = self.class.get(url, body: {'id' => checkpoint_id }, headers: { 'authorization' => @auth_token} )
    if response.code == 404 
      raise 'Sorry something went wrong..'
    else 
      @checkpoint = parse(response.body)
    end 
  end 

end 