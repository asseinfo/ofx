require "spec_helper"

describe OFX::Parser::OFX103 do
  before do
    @ofx = OFX::Parser::Base.new("spec/fixtures/v103.ofx")
    @parser = @ofx.parser
  end

  it "has a version" do
    expect(OFX::Parser::OFX103::VERSION).to eq("1.0.3")
  end

  it "sets headers" do
    expect(@parser.headers).to eq(@ofx.headers)
  end

  it "trims trailing whitespace from headers" do
    headers = OFX::Parser::OFX103.parse_headers("VERSION:103   ")

    expect(headers["VERSION"]).to eq("103")
  end

  it "sets body" do
    expect(@parser.body).to eq(@ofx.body)
  end

  it "sets account" do
    expect(@parser.account).to be_a_kind_of(OFX::Account)
  end

  it "sets account" do
    expect(@parser.sign_on).to be_a_kind_of(OFX::SignOn)
  end

  it "sets statements" do
    expect(@parser.statements.size).to eq(1)
    expect(@parser.statements.first).to be_a_kind_of(OFX::Statement)
  end

  it "knows about all transaction types" do
    valid_types = [
      'CREDIT', 'DEBIT', 'INT', 'DIV', 'FEE', 'SRVCHG', 'DEP', 'ATM', 'POS', 'XFER',
      'CHECK', 'PAYMENT', 'CASH', 'DIRECTDEP', 'DIRECTDEBIT', 'REPEATPMT', 'OTHER'
    ]
    expect(valid_types.sort).to eq(OFX::Parser::OFX103::TRANSACTION_TYPES.keys.sort)

    valid_types.each do |transaction_type|
      expect(transaction_type.downcase.to_sym).to eq(OFX::Parser::OFX103::TRANSACTION_TYPES[transaction_type])
    end
  end
end
