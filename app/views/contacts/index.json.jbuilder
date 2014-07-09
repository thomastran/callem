json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :phone, :email
  json.url contact_url(contact, format: :json)
end
