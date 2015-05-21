require 'spec_helper'

describe TextInvoice::Invoice do
    it "should return invoice yaml" do
        expect(TextInvoice::Invoice.blank()).to include("invoice")
    end

    context 'with path to a blank invoice' do
      it 'should return the specific blank invoice' do
        expect(TextInvoice::Invoice.blank('spec/fixtures/')).to include("siret")
      end
    end 
end

