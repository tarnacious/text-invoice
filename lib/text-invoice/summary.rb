module TextInvoice
    class Summary
        def summary(invoices)
            paid = 0
            due = 0
            total = 0
            count = 0
            invoices.each do |invoice| 
                data = load(invoice)
                total += data["total"]
                paid += data["paid"]
                due += data["due"]
                count += 1
            end
            headings = ["Count", "Total", "Paid", "Due"].join("\t")
            results = [count, total, paid, due].join("\t")
            [headings, results].join("\n")
        end
        
        def list(invoices)
            response = [["Invoice","Date", "Total", "Paid", "Due"].join("\t")]
            invoices.each do |invoice| 
                data = load(invoice)
                response << ([data["invoice"], data["date"], data["total"], data["paid"], data["due"]].join("\t"))
            end
            response.join("\n")
        end

        def load(invoice)
            calculator = TextInvoice::Totals.new
            YAML.load(calculator.process(open(invoice)))
        end
    end
end
