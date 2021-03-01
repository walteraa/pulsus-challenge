class FetchPeopleJob < ApplicationJob
  def perform(url)
    result = Swapi::Client.new(url).fetch
    people = result['results']
    next_url = result['next']

    people&.each do |person|
      CreatePersonJob.perform_later(person)
    end
    FetchPeopleJob.perform_later(next_url) unless next_url.blank?
    true
  end
end
