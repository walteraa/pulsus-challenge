# frozen_string_literal: true

class CreateTransportAndAssignToPersonJob < ApplicationJob
  def perform(transport_url, transport_type, person_id)
    result = Swapi::Client.new(transport_url).fetch

    transport = transport_type.constantize.find_or_create_by(name: result['name'])
    DrivedTransport.create(person_id: person_id, transport_id: transport.id)
  end
end