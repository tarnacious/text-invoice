require 'text-invoice'

describe TextInvoice::Totals do
    it "should add totals for empty invoice" do
        # empty invoice
        invoice = {}.to_yaml
        calculator = TextInvoice::Totals.new

        # process
        result = YAML.load(calculator.process(invoice))
        
        # validate
        result["total"].should eql(0)
        result["due"].should eql(0)
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
        result["items"][0]["subtotal"].should eql(4)
        result["items"][1]["subtotal"].should eql(6)
        result["total"].should eql(10)
        result["due"].should eql(10)
    end
    
    it "should update 'due' amount to be 'total' minus 'paid'" do

        # setup invoice
        invoice = { 'items' => [ { 'quantity' => 1, 'unit' => 10 } ], 'paid' => 5 }.to_yaml
        calculator = TextInvoice::Totals.new
        
        # process
        result = YAML.load(calculator.process(invoice))

        # validate
        result["total"].should eql(10)
        result["paid"].should eql(5)
        result["due"].should eql(5)
    end
end
