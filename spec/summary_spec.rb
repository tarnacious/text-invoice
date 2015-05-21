require 'spec_helper'

describe TextInvoice::Summary do
    it "should open a yaml file and update totals" do
        summary = TextInvoice::Summary.new
        calculate = TextInvoice::Totals.new

        invoice = summary.load("lib/text-invoice/invoice.yaml").to_yaml

        blank = calculate.process(TextInvoice::Invoice.blank)
        expect(invoice).to eql(blank) 
    end

    it "should return invoice summary" do
        summary = TextInvoice::Summary.new
        invoice1 = { 'due' => 5, 'total' => 10, 'paid' => 5 } 
        invoice2 = { 'due' => 1, 'total' => 10, 'paid' => 9 } 
        allow(summary).to receive(:load).and_return(invoice1, invoice2)
        
        response = summary.summary(['file1','file2'])
    
        expect(response.split("\n")[0]).to eql('Count | Total | Paid | Due')
        expect(response.split("\n")[1]).to eql('------|-------|------|----')
        expect(response.split("\n")[2]).to eql('2     | 20    | 14   | 6  ')
    end
    
    it "should return invoice list" do
        summary = TextInvoice::Summary.new
        invoice1 = { 'date' => '1/3/2012', 'invoice' => "1", 'due' => 5, 'total' => 10, 'paid' => 5 } 
        invoice2 = { 'date' => '2/3/2012', 'invoice' => "2", 'due' => 1, 'total' => 10, 'paid' => 9 } 
        allow(summary).to receive(:load).and_return(invoice1, invoice2)

        response = summary.list(['file1','file2'])
    
        expect(response.split("\n")[0]).to eql('Invoice | Date     | Total | Paid | Due')
        expect(response.split("\n")[1]).to eql('--------|----------|-------|------|----')
        expect(response.split("\n")[2]).to eql('1       | 1/3/2012 | 10    | 5    | 5  ')
        expect(response.split("\n")[3]).to eql('2       | 2/3/2012 | 10    | 9    | 1  ')
    end
end

