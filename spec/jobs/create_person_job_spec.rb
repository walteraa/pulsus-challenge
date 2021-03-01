require 'rails_helper'

RSpec.describe CreatePersonJob, type: :job do
  ActiveJob::Base.queue_adapter = :test
  let(:swapi_people) { build(:swapi_people)[:results].first }
  let(:person) do
    create(:person, name: swapi_people['name'],
                    height: swapi_people['height'],
                    mass: swapi_people['mass'] )
  end

  context 'when person_param is blank' do
    it { expect(described_class.perform_now({})).to be_falsy }
  end

  context 'when person_param is passed' do
    it 'calls the planet and transports creation job' do
      allow(Person).to receive(:find_or_create_by).with({name: swapi_people['name'] }).and_return(person)
      expect { described_class.perform_now(swapi_people) }.to have_enqueued_job(CreatePlanetAndAssignToPersonJob)
                                                                .with(swapi_people['homeworld'], person.id)
                                                                .exactly(:once)
                                                              .and have_enqueued_job(
                                                                     CreateTransportAndAssignToPersonJob
                                                                   ).exactly(
                                                                       swapi_people['vehicles'].count +
                                                                       swapi_people['starships'].count
                                                                     ).times
    end
  end
end