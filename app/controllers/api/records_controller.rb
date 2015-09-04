class Api::RecordsController < WebsocketRails::BaseController

  def chat
    new_message = {:message => 'this is a message'}
    send_message :event_name, new_message
  end

end
