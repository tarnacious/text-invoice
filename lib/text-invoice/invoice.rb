require 'text-invoice'

module TextInvoice
  class Invoice
      def self.blank()
          open(root + "invoice.yaml").read
      end
        
      def self.root 
          File.dirname(__FILE__) + "/"
      end
  end
end 
