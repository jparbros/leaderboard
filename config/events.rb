WebsocketRails::EventMap.describe do
  subscribe :event_name, 'api/records#chat'
end
