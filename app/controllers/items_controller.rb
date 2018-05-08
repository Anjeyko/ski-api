class ItemsController < ApplicationController
  def index
    items = Item.all
    paginate json: items.as_json, status: :ok
  end
end
