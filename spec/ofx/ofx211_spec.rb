require "spec_helper"

describe OFX::Parser::OFX211 do
  before do
    @ofx = OFX::Parser::Base.new("spec/fixtures/v211.ofx")
    @parser = @ofx.parser
  end

  it "has a version" do
    expect(OFX::Parser::OFX211::VERSION).to eq("2.1.1")
  end

  it "sets headers" do
    expect(@parser.headers).to eq(@ofx.headers)
  end

  it "sets body" do
    expect(@parser.body).to eq(@ofx.body)
  end

  it "sets account" do
    expect(@parser.account).to be_a_kind_of(OFX::Account)
  end

  it "sets sign_on" do
    expect(@parser.sign_on).to be_a_kind_of(OFX::SignOn)
  end

  it "sets accounts" do
    expect(@parser.accounts.size).to eq(2)
  end

  describe "transactions" do
    # Test file contains only three transactions. Let's just check
    # them all.
    describe "first" do
      before do
        @t = @parser.accounts[0].transactions[0]
      end

      it "contains the correct values" do
        expect(@t.amount).to eq(BigDecimal('-80'))
        expect(@t.fit_id).to eq("219378")
        expect(@t.memo).to be_empty
        expect(@t.posted_at).to eq(Time.parse("2005-08-24 08:00:00 +0000"))
        expect(@t.name).to eq("FrogKick Scuba Gear")
      end
    end

    describe "second" do
      before do
        @t = @parser.accounts[1].transactions[0]
      end

      it "contains the correct values" do
        expect(@t.amount).to eq(BigDecimal('-23'))
        expect(@t.fit_id).to eq("219867")
        expect(@t.memo).to be_empty
        expect(@t.posted_at).to eq(Time.parse("2005-08-11 08:00:00 +0000"))
        expect(@t.name).to eq("Interest Charge")
      end
    end

    describe "third" do
      before do
        @t = @parser.accounts[1].transactions[1]
      end

      it "contains the correct values" do
        expect(@t.amount).to eq(BigDecimal('350'))
        expect(@t.fit_id).to eq("219868")
        expect(@t.memo).to be_empty
        expect(@t.posted_at).to eq(Time.parse("2005-08-11 08:00:00 +0000"))
        expect(@t.name).to eq("Payment - Thank You")
      end
    end
  end
end

