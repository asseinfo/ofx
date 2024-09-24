require "spec_helper"

describe OFX do
  describe "#OFX" do
    it "does yield an OFX instance" do
      OFX("spec/fixtures/sample.ofx") do |ofx|
        expect(ofx.class).to eq(OFX::Parser::OFX102)
      end
    end

    it "returns an OFX instance" do
      ofx_instace = OFX("spec/fixtures/sample.ofx")
      expect(ofx_instace.class).to eq(OFX::Parser::OFX102)
    end

    it "returns parser" do
      expect(OFX("spec/fixtures/sample.ofx").class).to eq(OFX::Parser::OFX102)
    end
  end
end
