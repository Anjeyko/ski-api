require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Items' do
  let!(:city) { create(:city) }
  let!(:user) { create(:user, city_id: city.id) }
  let!(:item) { create(:item, user_id: user.id) }
  let!(:items) { create_list(:item, 5, user_id: user.id) }

  context 'valid params' do
    get '/items/:items_id' do
      let(:items_id) { item.id }
      example_request 'Getting item request by id' do
        expect(status).to eq(200)
        expect(response_body).to eq(item.to_json)
      end        
    end

    get '/items' do
      let(:per_page) { 5 }
      parameter :page, 'items page number'
      parameter :per_page, 'Number of items shown on single page (default 5)'
      example_request 'Getting all items request' do
        expect(status).to eq(200)
        json = JSON.parse(response_body)
        expect(json.count).to eq(5)
      end
    end

    get '/items' do
      let(:page) { 1 }
      let(:per_page) { 10 }
      example_request 'Getting 1st page with 5 items per page request' do
        json = JSON.parse(response_body)
        expect(json.count).to eq(5)
      end
    end
  
    post "/items?name=item_name" do
      let(:item_name) { item.name }
      example_request 'Getting item create action request' do
        expect(status).to eq(201)
        expect { Item.create(name: :item_name, user_id: user) }.to change(Item, :count).by(0)
      end
    end

    delete '/items/:item_id' do
      let(:item_id) { item.id }
      example 'Getting item destroy action request' do
        expect { do_request }.to change { Item.count }.by(-1)
      end
    end

  end
  
  context 'invalid params' do
    get '/items/:wrong_id' do
      let(:wrong_id) { 0 }
      example 'Getting item request with wrong id' do
        expect { do_request }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    get '/items?page=50' do
      example_request 'Getting items request with wrong page' do
        expect(response_body).to eq("[]")
      end
    end  
  end
end