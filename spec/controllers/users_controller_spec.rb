require 'rails_helper'

describe UsersController, type: :controller do
    before do
        @user1 = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:user)
    end

    describe "Get #show" do
        context "when a user is logged in" do

            before do
                sign_in @user1
            end

            it 'loads correct user details' do
                get :show, params: {id: @user1.id}
                expect(response).to be_ok
                expect(assigns(:user)).to eq @user1
            end
        end

            it "tries accessing first users show page" do
                get :show, params: {id: @user2.id}
                expect(response).to have_http_status(302)
                expect(response).to redirect_to(root_path)
            end

            context 'when a user is not logged in' do
                it 'redirects to login' do
                    get :show, params: {id: @user1.id}
                    expect(response).to redirect_to(root_path)
                end
            end
    end

end
