module TextInvoice
  class Invoice
      def self.blank(dir = nil)
          blank_dir = dir ? Pathname.new(dir + '/') : Pathname.new(root)
          open(blank_dir.cleanpath + 'invoice.yaml').read
      end
        
      def self.root 
          File.dirname(__FILE__) + "/"
      end
  end
end 
