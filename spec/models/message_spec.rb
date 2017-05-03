require 'rails_helper'
describe Message do
  describe '#create' do
#bodyが正常に保存されるかどうかのテスト
    it "is valid with a body" do
      message = build(:message)
      expect(message).to be_valid
    end
#bodyが空だった場合には保存されないことのテスト
    it "is invalid without a body" do
      message = build(:message, body: "")
      message.valid?
      expect(message.errors[:body]).to include("を入力してください")
    end
  end
end
