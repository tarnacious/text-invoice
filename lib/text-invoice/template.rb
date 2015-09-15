require 'text-invoice'
require 'mustache'

module TextInvoice
    class Template
        def html(invoice)
            totals = TextInvoice::Totals.new
            parsed = YAML.load(totals.process(invoice))
            Mustache.render(open(root + "templates/invoice.html").read(), parsed)
        end

        def custom(invoice, template)
            totals = TextInvoice::Totals.new
            parsed = YAML.load(totals.process(invoice))
            Mustache.render(open(template).read(), parsed)
        end

        def root
          File.dirname(__FILE__) + "/../../"
        end
    end
end
