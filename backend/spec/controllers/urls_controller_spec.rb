require 'rails_helper'

def json
  @json ||= JSON.parse(response.body)
end

RSpec.describe UrlsController do
  describe '#index' do
    context 'empty database' do
      subject! { get :index }

      it 'returns empty response' do
        expect(json).to eq({})
      end
    end

    context 'populated database' do
      let!(:test_urls) do
        [
          Url.create('deliveroo.co.uk'),
          Url.create('google.com'),
          Url.create('facebook.com'),
        ]
      end

      subject! { get :index }

      it 'returns all urls' do
        expect(json.keys).to eq(test_urls)
      end
    end

    it 'should respond with status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    let(:url) { 'https://google.com' }

    context 'with valid params' do
      subject! { post :create, params: { url: url }}

      it 'renders the unique code for a given url' do
        expect(json).to have_key('code')
        expect(json['code'].length).to eq(Url::KEY_LENGTH * 2)
      end

      it 'should respond with status code 200' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      subject! { post :create }

      it 'renders error if url is blank' do
        expect(json).to have_key('error')
        expect(json['error']).to eq('blank_url')
      end

      it 'should respond with status code 400' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
