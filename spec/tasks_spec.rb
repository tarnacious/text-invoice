require 'text-invoice'

describe TextInvoice::Tasks do
    it "should return usage details" do
        tasks = TextInvoice::Tasks.new
        tasks.usage().should include("Usage")
    end
    
    it "should return summary" do
        summary_calculator = double("summary")
        summary_calculator.should_receive(:summary).with([]).and_return("summary results")

        tasks = TextInvoice::Tasks.new
        tasks.summary_calculator = summary_calculator

        tasks.summary([]).should include("summary results")
    end
    
    it "should return list" do
        summary_calculator = double("summary")
        summary_calculator.should_receive(:list).with([]).and_return("list results")

        tasks = TextInvoice::Tasks.new
        tasks.summary_calculator = summary_calculator

        tasks.list([]).should include("list results")
    end
    
    it "should return totals" do
        totals_calculator = double("summary")
        totals_calculator.should_receive(:process).with([]).and_return("totals results")

        tasks = TextInvoice::Tasks.new
        tasks.totals_calculator = totals_calculator

        tasks.totals([]).should include("totals results")
    end
   
    it "should return blank invoice yaml" do
        invoice = double("invoice")
        invoice.should_receive(:blank).and_return("new invoice yaml")

        tasks = TextInvoice::Tasks.new
        tasks.invoice = invoice

        tasks.new_invoice().should eql("new invoice yaml")
    end
    
    it "should return html" do
        template = double("template")
        template.should_receive(:html).with({}).and_return("invoice html")

        tasks = TextInvoice::Tasks.new
        tasks.template = template

        tasks.html({}).should eql("invoice html")
    end
    
    it "should return template" do
        template = double("template")
        template.should_receive(:custom).with({},"").and_return("invoice html")

        tasks = TextInvoice::Tasks.new
        tasks.template = template

        tasks.template({},"").should eql("invoice html")
    end

end
