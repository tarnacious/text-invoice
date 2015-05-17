require 'spec_helper'

describe TextInvoice::Template do
    it "should return invoice html the using default template" do
        template = TextInvoice::Template.new
        invoice = YAML.load(TextInvoice::Invoice.blank)
        invoice["invoice"] = "123"
        
        html = template.html(invoice.to_yaml)
       
        # check for something from the template
        expect(html).to include("html")
        # check for something from the data
        expect(html).to include("123")
    end
    
    it "should return invoice html the using a custom template" do
        template = TextInvoice::Template.new
        invoice = YAML.load(TextInvoice::Invoice.blank)
        invoice["invoice"] = "123"

        html = template.custom(invoice.to_yaml, "templates/invoice.html")
        
        # check for something from the template
        expect(html).to include("html")
        # check for something from the data
        expect(html).to include("123")
    end
end
