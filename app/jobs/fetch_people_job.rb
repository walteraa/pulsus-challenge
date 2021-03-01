class FetchPeopleJob < ApplicationJob
  def perform(url)

    Rails.logger.info("[FetchPeopleJob] - fetching data from #{url} ...")
    result = Swapi::Client.new(url).fetch
    Rails.logger.info("[FetchPeopleJob] - data fetched!")
    people = result['results']
    next_url = result['next']

    Rails.logger.info("[FetchPeopleJob] - Processing #{people&.count || 0} people ... ")
    people&.each do |person|
      CreatePersonJob.perform_later(person)
    end
    FetchPeopleJob.perform_later(next_url) unless next_url.blank?
    true
  end
end
