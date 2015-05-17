require 'spec_helper'

describe TextInvoice::Totals do
    it "should add totals for empty invoice" do
        # empty invoice
        invoice = {}.to_yaml
        calculator = TextInvoice::Totals.new

        # process
        result = YAML.load(calculator.process(invoice))
        
        # validate
        expect(result["total"]).to eql(0)
        expect(result["due"]).to eql(0)
    end
    
    it "should update invoice totals and subtotals" do

        # setup invoice
        invoice = { 'items' => 
            [ { 'quantity' => 1, 'unit' => 4 }, 
              { 'quantity' => 2, 'unit' => 3 } ] }.to_yaml
        calculator = TextInvoice::Totals.new
        
        # process
        result = YAML.load(calculator.process(invoice))

        # validate
        expect(result["items"][0]["subtotal"]).to eql(4)
        expect(result["items"][1]["subtotal"]).to eql(6)
        expect(result["total"]).to eql(10)
        expect(result["due"]).to eql(10)
    end
    
    it "should update 'due' amount to be 'total' minus 'paid'" do

        # setup invoice
        invoice = { 'items' => [ { 'quantity' => 1, 'unit' => 10 } ], 'paid' => 5 }.to_yaml
        calculator = TextInvoice::Totals.new
        
        # process
        result = YAML.load(calculator.process(invoice))

        # validate
        expect(result["total"]).to eql(10)
        expect(result["paid"]).to eql(5)
        expect(result["due"]).to eql(5)
    end
end
