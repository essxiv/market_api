require 'spec_helper'

describe Api::V1::OrdersController do
    describe "GET #index" do
        before(:each) do
          current_user = FactoryGirl.create :user
          api_authorization_header current_user.auth_token
          4.times { FactoryGirl.create :order, user: current_user }
          get :index, user_id: current_user.id
      end

      it "returns 4 order records from the user" do
          orders_response = json_response[:orders]
          expect(orders_response).to have(4).items
      end

      it { should respond_with 200 }
  end

    describe "GET #show" do
        before(:each) do
            current_user = FactoryGirl.create :user
            api_authorization_header current_user.auth_token
            @order = FactoryGirl.create :order, user: current_user
            get :show, user_id: current_user.id, id: @order.id
        end

        it "returns the user order record matching the id" do
            order_response = json_response[:order]
            expect(order_response[:id]).to eql @order.id
        end

        it { should respond_with 200 }
    end

    describe "POST #create" do
        before(:each) do
            current_user = FactoryGirl.create :user
            api_authorization_header current_user.auth_token

            product_1 = FactoryGirl.create :product
            product_2 = FactoryGirl.create :product
            order_params = { total: 50, user_id: current_user.id, product_ids: [product_1.id, product_2.id] }
            post :create, user_id: current_user.id, order: order_params
        end

        it "returns the just user order record" do
            order_response = json_response[:order]
            expect(order_response[:id]).to be_present
        end

        it "embeds the two product objects related to the order" do
            order_response = json_response[:order]
            expect(order_response[:products].size).to eql 2
        end

        it { should respond_with 201 }
    end
end
