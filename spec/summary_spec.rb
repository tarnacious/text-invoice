require 'text-invoice'

describe TextInvoice::Summary do
    it "should open a yaml file and update totals" do
        summary = TextInvoice::Summary.new
        calculate = TextInvoice::Totals.new

        invoice = summary.load("lib/text-invoice/invoice.yaml").to_yaml

        blank = calculate.process(TextInvoice::Invoice.blank)
        invoice.should eql(blank) 
    end

    it "should return invoice summary" do
        summary = TextInvoice::Summary.new
        invoice1 = { 'due' => 5, 'total' => 10, 'paid' => 5 } 
        invoice2 = { 'due' => 1, 'total' => 10, 'paid' => 9 } 
        summary.stub(:load).and_return(invoice1, invoice2)
        
        response = summary.summary(['file1','file2'])
    
        headings = response.split("\n")[0].should eql(['Count','Total','Paid','Due'].join("\t"))
        results = response.split("\n")[1].should eql(['2','20','14','6'].join("\t"))
    end
    
    it "should return invoice list" do
        summary = TextInvoice::Summary.new
        invoice1 = { 'date' => '1/3/2012', 'invoice' => "1", 'due' => 5, 'total' => 10, 'paid' => 5 } 
        invoice2 = { 'date' => '2/3/2012', 'invoice' => "2", 'due' => 1, 'total' => 10, 'paid' => 9 } 
        summary.stub(:load).and_return(invoice1, invoice2)

        response = summary.list(['file1','file2'])
    
        response.split("\n")[0].should eql(['Invoice','Date','Total','Paid','Due'].join("\t"))
        response.split("\n")[1].should eql(['1','1/3/2012','10','5','5'].join("\t"))
        response.split("\n")[2].should eql(['2','2/3/2012','10','9','1'].join("\t"))
    end
end

