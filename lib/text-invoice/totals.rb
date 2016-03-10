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
            tax = total * 0.19
            total2 = total + tax

            parsed["subtotal"] = total
            parsed["tax"] = tax
            parsed["total"] = total2

            if parsed["paid"]
                parsed["due"] = (total2 - parsed["paid"]).round(2)
            else
                parsed["due"] = total2
            end

            parsed.to_yaml
        end
    end
end
