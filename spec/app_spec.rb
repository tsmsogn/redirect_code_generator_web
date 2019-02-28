# spec/app_spec.rb
require File.expand_path '../spec_helper.rb', __FILE__

describe 'My Sinatra Application' do

  describe '/' do
    context 'GET' do
      it 'works' do
        get '/'
        expect(last_response).to be_ok
      end
    end

    context 'POST' do
      it 'works' do
        post '/', :input => '/old.html /new.html'
        expect(last_response).to be_ok
      end
    end
  end
end