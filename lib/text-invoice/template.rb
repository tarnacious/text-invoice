require 'text-invoice'
require 'mustache'

module TextInvoice
    class Template
        def html(invoice)
            parsed = YAML.load(invoice)
            Mustache.render(open(root + "templates/invoice.html").read(), parsed)
        end
        
        def custom(invoice, template)
            parsed = YAML.load(invoice)
            Mustache.render(open(template).read(), parsed)
        end
        
        def root 
          File.dirname(__FILE__) + "/../../"
        end
    end
end
