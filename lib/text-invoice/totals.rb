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
            parsed["total"] = total2.round(2)

            if parsed["paid"]
                parsed["due"] = (total2 - parsed["paid"]).round(2)
            else
                parsed["due"] = total2
            end

            # convert to strings
            parsed["subtotal_str"] = format("%.2f", parsed["subtotal"])
            parsed["tax_str"] = format("%.2f", parsed["tax"])
            parsed["total_str"] = format("%.2f", parsed["total"])
            if parsed["paid"]
                parsed["paid_str"] = format("%.2f", parsed["paid"])
                parsed["due_str"] = format("%.2f", parsed["due"])
            end

            parsed.to_yaml
        end
    end
end
