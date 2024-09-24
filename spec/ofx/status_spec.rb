require "spec_helper"

describe OFX::Status do
  let(:ofx) { OFX::Parser::Base.new(ofx_file) }
  let(:parser) { ofx.parser }
  let(:status) { parser.sign_on.status }

  context "success" do
    let(:ofx_file) { "spec/fixtures/creditcard.ofx" }

    it "returns code" do
      expect(status.code).to eq(0)
    end

    it "returns severity" do
      expect(status.severity).to eq(:info)
    end

    it "returns message" do
      expect(status.message).to eq("")
    end

    it "is successful" do
      expect(status.success?).to be true
    end
  end

  context "error" do
    let(:ofx_file) { "spec/fixtures/error.ofx" }

    it "returns code" do
      expect(status.code).to eq(2000)
    end

    it "returns severity" do
      expect(status.severity).to eq(:error)
    end

    it "returns message" do
      expect(status.message).to eq("We were unable to process your request. Please try again later.")
    end

    it "is not successful" do
      expect(status.success?).to be false
    end
  end
end
