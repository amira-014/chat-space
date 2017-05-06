require 'rails_helper'

describe Groups::MessagesController, type: :controller do

  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { attributes_for(:message) }
  let(:group_params){ {group_id: group, message: message} }

  describe 'GET #index' do
    before do
      login_user user
      get :index, params: {group_id: group}
    end

    it "正しいビューに遷移する" do
      expect(response).to render_template :index
    end

    it "@groupが期待された値を持つ" do
      expect(assigns(:group)).to eq group
    end

    it "@groupsが期待された値を持つ" do
      expect(assigns(:groups)).to eq user.groups
    end

    it "@messagesが期待された値を持つ" do
      messages = create_list(:message, 5)
      expect(assigns(:messages)).to eq group.messages
    end

  end

  describe 'POST #create' do
    before do
      login_user user
      get :index, params: {group_id: group}
    end

    context "@messageが保存された時" do
      it "データベースに値が保存される" do
        expect{post :create, params: group_params}.to change(Message, :count).by(1)
      end

      it "正しいビューに遷移する" do
        post :create, params: group_params
        expect(response).to  redirect_to group_messages_path(group)
      end

    end

    context "@messageが保存されなかった時" do
      before do
        @invalid_message = attributes_for(:message, body:"")
      end

      it "データベースに値が保存されない" do
        expect{post :create, params: {group_id: group, message: @invalid_message}}.not_to change(Message, :count)
      end

      it "アラートが表示される" do
        post :create, params: {group_id: group, message: @invalid_message}
        expect(flash[:alert]).to match "メッセージの入力が必要です"
      end


      it "正しいビューに遷移する" do
        post :create, params: {group_id: group, message: @invalid_message}
        expect(response).to render_template :index
      end

    end

  end

end
