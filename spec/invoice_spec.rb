require 'text-invoice'

describe TextInvoice::Invoice do
    it "should return invoice yaml" do
        expect(TextInvoice::Invoice.blank()).to include("invoice")
    end
end

