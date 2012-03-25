require 'text-invoice'

describe TextInvoice::Invoice do
    it "should return invoice yaml" do
        TextInvoice::Invoice.blank().should include("invoice")
    end
end

