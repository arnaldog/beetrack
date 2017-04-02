require 'rails_helper'
require 'sidekiq/testing'

describe Api::V1::GpsController, type: :controller do


  context 'with known vehicle' do

    before(:each) do
      @vehicle = create(:vehicle, identifier: 'HA-3452')
    end

    subject {
      post :create, params: {
          vehicle_identifier: 'HA-3452',
          sent_at: '2016-06-02 20:45:00',
          latitude: '20.23',
          longitude: '20.23'
      }
    }
    it 'creates a new waypoint' do
      Sidekiq::Testing.inline! do
        expect { subject() }.to change(Waypoint, :count).by(1)
      end
    end

    it 'does not create a new Vehicle' do
      Sidekiq::Testing.inline! do
        expect { subject() }.not_to change(Vehicle, :count)
      end
    end

    it 'responds whit json' do
      subject()
      expect(response.content_type).to eq 'application/json'
    end
  end

  context 'without a known vehicle' do

    before(:each) do
      Sidekiq::Worker.clear_all
    end

    subject {
      post :create, params: {
          vehicle_identifier: 'HA-3452',
          sent_at: '2016-06-02 20:45:00',
          latitude: '20.23',
          longitude: '20.23'
      }
    }

    it 'enqueue a new job' do
      ActiveJob::Base.queue_adapter = :test
      
      expect {
        subject()
      }.to have_enqueued_job(TrackerJob)

      ActiveJob::Base.queue_adapter = :sidekiq
    end

    it 'create a new vehicle' do
      Sidekiq::Testing.inline! do
        expect { subject() }.to change(Vehicle, :count).by(1)
      end
    end

    it 'create a new waypoint' do
      Sidekiq::Testing.inline! do
        expect { subject() }.to change(Waypoint, :count).by(1)
      end
    end
  end

  context 'without vehicle identifier' do
    subject {
      post :create, params: {
          sent_at: '2016-06-02 20:45:00',
          latitude: '20.23',
          longitude: '20.23'
      }
    }

    it 'create a new vehicle' do

      post :create, params: {
          sent_at: '2016-06-02 20:45:00',
          latitude: '20.23',
          longitude: '20.23'
      }

      expect(response).to be_success
    end


    it 'create a new vehicle' do

      post :create, params: {
          vehicle_identifier: 'HA-34526345634',
          sent_at: '2016-06-02 20:45:00',
          latitude: '20.23',
          longitude: '20.23'
      }

      expect(response).to_not be_success
      body = JSON.parse(response.body)
      expect(body['error']).to eql('Vehicle identifier too long')

    end

  end
end
