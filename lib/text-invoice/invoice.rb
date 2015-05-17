module TextInvoice
  class Invoice
      def self.blank(dir = nil)
          blank_dir = dir ? Pathname.new(dir).cleanpath.to_s + '/' : root
          open(blank_dir + 'invoice.yaml').read
      end
        
      def self.root 
          File.dirname(__FILE__) + "/"
      end
  end
end 
