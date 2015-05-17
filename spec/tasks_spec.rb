require 'spec_helper'

describe TextInvoice::Tasks do
    it "should return usage details" do
        tasks = TextInvoice::Tasks.new
        expect(tasks.usage()).to include("Usage")
    end
    
    it "should return summary" do
        summary_calculator = double("summary")
        expect(summary_calculator).to receive(:summary).with([]).and_return("summary results")

        tasks = TextInvoice::Tasks.new
        tasks.summary_calculator = summary_calculator

        expect(tasks.summary([])).to include("summary results")
    end
    
    it "should return list" do
        summary_calculator = double("summary")
        expect(summary_calculator).to receive(:list).with([]).and_return("list results")

        tasks = TextInvoice::Tasks.new
        tasks.summary_calculator = summary_calculator

        expect(tasks.list([])).to include("list results")
    end
    
    it "should return totals" do
        totals_calculator = double("summary")
        expect(totals_calculator).to receive(:process).with([]).and_return("totals results")

        tasks = TextInvoice::Tasks.new
        tasks.totals_calculator = totals_calculator

        expect(tasks.totals([])).to include("totals results")
    end
   
    it "should return blank invoice yaml" do
        invoice = double("invoice")
        expect(invoice).to receive(:blank).and_return("new invoice yaml")

        tasks = TextInvoice::Tasks.new
        tasks.invoice = invoice

        expect(tasks.new_invoice()).to eql("new invoice yaml")
    end
    
    it "should return custom blank invoice yaml" do
        invoice = double("invoice")
        expect(invoice).to receive(:blank).with('/template/dir').and_return("new custom invoice yaml")

        tasks = TextInvoice::Tasks.new
        tasks.invoice = invoice

        expect(tasks.new_invoice('/template/dir')).to eql("new custom invoice yaml")
    end

    it "should return html" do
        template = double("template")
        expect(template).to receive(:html).with({}).and_return("invoice html")

        tasks = TextInvoice::Tasks.new
        tasks.template = template

        expect(tasks.html({})).to eql("invoice html")
    end
    
    it "should return template" do
        template = double("template")
        expect(template).to receive(:custom).with({},"").and_return("invoice html")

        tasks = TextInvoice::Tasks.new
        tasks.template = template

        expect(tasks.template({},"")).to eql("invoice html")
    end

end
