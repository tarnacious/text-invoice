module TextInvoice
    class Totals
        def process(invoice)
            # parse
            parsed = YAML.load(invoice)
                    
            # total accumulator
            total = 0
               
            # process line items
            if not parsed["items"] == nil
                for item in parsed["items"]
                    quantity = item["quantity"]
                    unit = item["unit"]
                    subtotal = quantity * unit
                    item["subtotal"] = subtotal
                    total += subtotal
                end
            end

            # update totals
            parsed["total"] = total

            if parsed["paid"]
                parsed["due"] = total - parsed["paid"]
            else
                parsed["due"] = total
            end

            parsed.to_yaml
        end
    end
end
