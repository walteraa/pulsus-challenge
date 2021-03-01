require 'rails_helper'
require 'net/http'

RSpec.describe FetchPeopleJob, type: :job do
  ActiveJob::Base.queue_adapter = :test
  let(:swapi_response) { build(:swapi_people).stringify_keys }

  before do
    swapi_response[:next] = 'https://localhost/'
  end

  context 'when param does have next' do

    context 'and we do have results' do
      it do
        allow(Net::HTTP).to receive(:get).and_return(swapi_response.to_json)
        expect { described_class.perform_now('https://localhost') }
          .to have_enqueued_job(CreatePersonJob).exactly(swapi_response['results'].count)
                                                .times.and have_enqueued_job(FetchPeopleJob).exactly(:once)
      end
    end

    context 'and we do not have results' do
      before { swapi_response.delete('results') }
      it do
        allow(Net::HTTP).to receive(:get).and_return(swapi_response.to_json)
        expect { described_class.perform_now('https://localhost') }
          .to_not have_enqueued_job(CreatePersonJob)
      end

      it do
        allow(Net::HTTP).to receive(:get).and_return(swapi_response.to_json)
        expect { described_class.perform_now('https://localhost') }
          .to have_enqueued_job(FetchPeopleJob).exactly(:once)
      end
    end
  end

  context 'when param does not have next' do
    context 'and we do have results' do
      before(:each) do
        swapi_response.delete(:next)
      end
      it do
        allow(Net::HTTP).to receive(:get).and_return(swapi_response.to_json)
        expect { described_class.perform_now('https://localhost') }
          .to have_enqueued_job(CreatePersonJob).exactly(swapi_response['results'].count)
      end

      it do
        allow(Net::HTTP).to receive(:get).and_return(swapi_response.to_json)
        expect { described_class.perform_now('https://localhost') }
          .to_not have_enqueued_job(FetchPeopleJob)
      end
    end
  end

end
