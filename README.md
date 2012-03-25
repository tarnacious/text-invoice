# Text Invoice

Some tools and helpers for creating, summarising and transforming invoices stored as YAML documents.

The tools are designed to be used in a UNIX-like environment.

## Typical uses

Create a new invoice

    text-invoice new > some-job.yaml

Update totals, transform to HTML and write to disk

    cat some-job.yaml | text-invoice update | text-invoice html > some-job.html

Get a summary of all invoices 
    
    find -name "*.yaml" | xargs text-invoice summary

Get a summarised list of all invoices 
    
    find -name "*.yaml" | xargs text-invoice list

Get a summarised list of all invoices which contain a word

    grep -r -l "some pattern" * | xargs text-invoice list

You get the idea.

## Custom templates

It's just YAML so it's easy template. I use Mustache template for the default HTML invoice, and added an option to support custom Mustache templates

    cat some-job.yml | text-invoice template my-template.mustache > some-job.something

Of course if you have the Mustache gem installed (which is a dependency of this gem!) you can just use that!

    cat some-job.yml | mustache - template.mustache > some-job.something

## PDF 

I transform my invoices in PDF using wkhtmltopdf

    cat some-job.yaml | text-invoice update | text-invoice html > /tmp/invoice.html && wkhtmltopdf /tmp/invoice.html some-job.pdf

Use whatever makes you happy.




