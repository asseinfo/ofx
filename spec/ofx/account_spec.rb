require "spec_helper"

describe OFX::Account do
  before do
    @ofx = OFX::Parser::Base.new("spec/fixtures/sample.ofx")
    @parser = @ofx.parser
    @account = @parser.account
  end

  describe "account" do
    it "returns currency" do
      expect(@account.currency).to eq("BRL")
    end

    it "returns bank id" do
      expect(@account.bank_id).to eq("0356")
    end

    it "returns id" do
      expect(@account.id).to eq("03227113109")
    end

    it "returns type" do
      expect(@account.type).to eq(:checking)
    end

    it "returns transactions" do
      expect(@account.transactions).to be_a_kind_of(Array)
      expect(@account.transactions.size).to eq(36)
    end

    it "returns balance" do
      expect(@account.balance.amount).to eq(BigDecimal('598.44'))
    end

    it "returns balance in pennies" do
      expect(@account.balance.amount_in_pennies).to eq(59844)
    end

    it "returns balance date" do
      expect(@account.balance.posted_at).to eq(Time.gm(2009,11,1))
    end

    context "available_balance" do
      it "returns available balance" do
        expect(@account.available_balance.amount).to eq(BigDecimal('1555.99'))
      end

      it "returns available balance in pennies" do
        expect(@account.available_balance.amount_in_pennies).to eq(155599)
      end

      it "returns available balance date" do
        expect(@account.available_balance.posted_at).to eq(Time.gm(2009,11,1))
      end

      it "returns nil if AVAILBAL not found" do
        @ofx = OFX::Parser::Base.new("spec/fixtures/utf8.ofx")
        @parser = @ofx.parser
        @account = @parser.account
        expect(@account.available_balance).to be_nil
      end
    end

    context "Credit Card" do
      before do
        @ofx = OFX::Parser::Base.new("spec/fixtures/creditcard.ofx")
        @parser = @ofx.parser
        @account = @parser.account
      end

      it "returns id" do
        expect(@account.id).to eq("XXXXXXXXXXXX1111")
      end

      it "returns currency" do
        expect(@account.currency).to eq("USD")
      end
    end
    context "With Issue" do # Bradesco do not provide a valid date in balance
      before do
        @ofx = OFX::Parser::Base.new("spec/fixtures/dtsof_balance_issue.ofx")
        @parser = @ofx.parser
        @account = @parser.account
      end

      it "returns nil for date balance" do
        expect(@account.balance.posted_at).to be_nil
      end
    end

    context "Invalid Dates" do
      before do
        @ofx = OFX::Parser::Base.new("spec/fixtures/bradesco.ofx")
        @parser = @ofx.parser
      end
      it "is not raise error when balance has date zero" do
        expect { @parser.account.balance }.to_not raise_error
      end
      it "returns NIL in balance.posted_at when balance date is zero" do
        expect(@parser.account.balance.posted_at).to be_nil
     end
    end

    context "decimal values using a comma" do
      before do
        @ofx = OFX::Parser::Base.new("spec/fixtures/santander.ofx")
        @parser = @ofx.parser
        @account = @parser.account
      end

      it "returns balance" do
        expect(@account.balance.amount).to eq(BigDecimal('348.29'))
      end

      it "returns balance in pennies" do
        expect(@account.balance.amount_in_pennies).to eq(34829)
      end

      context "available_balance" do
        it "returns available balance" do
          expect(@account.available_balance.amount).to eq(BigDecimal('2415.87'))
        end

        it "returns available balance in pennies" do
          expect(@account.available_balance.amount_in_pennies).to eq(241587)
        end
      end
    end
  end
end
