require 'text-invoice'

module TextInvoice
    class Tasks 
        attr_accessor :totals_calculator, :summary_calculator, :invoice, :template

        def initialize()
            @totals_calculator = TextInvoice::Totals.new
            @summary_calculator = TextInvoice::Summary.new
            @invoice = TextInvoice::Invoice
            @template = TextInvoice::Template.new
        end

        def totals(input)
            @totals_calculator.process(input)
        end

        def summary(input)
            @summary_calculator.summary(input)
        end
        
        def list(input)
            @summary_calculator.list(input)
        end

        def new_invoice()
            @invoice.blank()
        end
        
        def html(invoice)
            @template.html(invoice)
        end
        
        def template(invoice, template)
            @template.custom(invoice, template)
        end
        
        def usage()
            text = """
Usage: text-invoice [new|totals|summary|list|html|template] [additional arguments..]

new        Writes an empty invoice to STDOUT

update     Calculates subtotals, totals and due amounts
           Reads an invoice from STDIN and writes an updated invoice to STDOUT

summary    Returns a summary of invoice files.
           Summarises invoice files from additional arguments

list       Returns a summarised list of invoices
           Lists invoice files from additional arguments

html       Transforms an invoice to HTML using a built-in template
           Reads invoice from STDIN

template   Transforms an invoice to HTML using a custom Mustache template
           Reads invoice from STDIN. File path of a Mustache template must 
           be provided as an additional argument.
            """
        end
    end
end
