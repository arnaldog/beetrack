require 'rails_helper'

describe HomeController, type: :controller do

  describe 'GET #show' do
    it 'returns http success' do
      get :show
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:success)
    end
  end

end
