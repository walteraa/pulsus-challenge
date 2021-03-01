desc 'Fetch data from Swapi'
namespace :swapi do
  task fetch_data: :environment do
    first_url = 'https://swapi.dev/api/people/'
    puts 'Starting job to pull data async...'
    FetchPeopleJob.perform_later(first_url)
    puts 'Job started! Notice: It is important having the sidekiq worker running'
  end
end
