[![Build Status](https://travis-ci.org/tarnacious/text-invoice.svg)](https://travis-ci.org/tarnacious/text-invoice)

# Text Invoice

Some tools and helpers for creating, summarising and transforming invoices stored as [YAML][yaml] documents.

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

## Installing

    gem install text-invoice

## Samples Invoice

Yo, added examples of the YAML, template and a PDF. They're in the example directory.

## Custom templates

It's just YAML so it's easy template. I use [Mustache templates][mustache] for the default HTML invoice, and added an option to support custom Mustache templates

    cat some-job.yml | text-invoice template my-template.mustache > some-job.something

Of course if you have the Mustache gem installed (which is a dependency of this gem!) you can just use that!

    cat some-job.yml | mustache - template.mustache > some-job.something

## PDF 

I transform my invoices in PDF using [wkhtmltopdf][wkhtmltopdf]. There is a [wkpdf gem][wkpdf] but it's only for Max OS X, so that wasn't getting included.

    cat some-job.yaml | text-invoice update | text-invoice html > /tmp/invoice.html && wkhtmltopdf /tmp/invoice.html some-job.pdf

Use whatever makes you happy.

## This seems stupid

I like having invoices in text so I can update them in another Vim buffer as I'm doing work. If I ever think I'm doing to much typing I can always wrap the commands in shell scripts or Vim mappings.

I prefer this to context switching to another application/website or trying to work out what I did from git logs.

## Acknowledgements

The template I'm using is a modified version of the pretty-neat-but-not-what-I-wanted [Editable, Printable Invoice by Chris Coyer and others][editable-invoice].

This is the first gem I've written, and [this guide][gem-dev] was helpful.

[editable-invoice]: http://css-tricks.com/editable-invoice-v2/
[wkhtmltopdf]: http://code.google.com/p/wkhtmltopdf/
[mustache]: http://mustache.github.com/
[gem-dev]: https://github.com/radar/guides/blob/master/gem-development.md
[yaml]: http://yaml.org/
[wkpdf]: http://rubygems.org/gems/wkpdf
