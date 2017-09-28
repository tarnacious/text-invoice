require 'table_print'

module TextInvoice
    class Summary
        def summary(invoices)
            content = {}
            content['Count'] = 0
            content['Total'] = 0
            content['Paid']  = 0
            content['Due']   = 0
            invoices.each do |invoice|
                data = load(invoice)
                content['Total'] += data['total']
                content['Paid']  += data['paid']
                content['Due']   += data['due']
                content['Count'] += 1
            end
            output_as_table( [content] )
        end

        def list(invoices)
            content_array = []
            header = ["invoice","date", "total", "paid", "due", "tax", "subtotal"]
            invoices.each do |invoice|
                data = load(invoice)
                inv_content = {}
                header.each do |h|
                  inv_content[h.capitalize] = data[h]
                end
                content_array << inv_content
            end
            output_as_table(content_array)
        end

        def load(invoice)
            calculator = TextInvoice::Totals.new
            YAML.load(calculator.process(open(invoice)))
        end

        private
          def output_as_table(data)
            TablePrint::Config.capitalize_headers = false
            TablePrint::Printer.table_print( data )
          end
    end
end
