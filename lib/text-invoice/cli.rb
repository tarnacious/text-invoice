require 'text-invoice'

module TextInvoice
  class CLI
    attr_accessor :tasks, :argv, :stdin

    def initialize()
      @tasks = TextInvoice::Tasks.new
      @argv = ARGV
      @stdin = $stdin
    end

    def run()
      mode = @argv.shift

      case mode
      when "update" then @tasks.totals(@stdin.read)
      when "summary" then @tasks.summary(@argv)
      when "list" then @tasks.list(@argv)
      when "new" then
        # trick to avoid changing spec test and original behavior
        custom = @argv.shift
        custom ? @tasks.new_invoice(custom) : @tasks.new_invoice()
      when "html" then @tasks.html(@stdin.read)
      when "template" then render_template
      else @tasks.usage()
      end
    end

    private

    def render_template
      template = @argv.shift
      if template
        @tasks.template(@stdin.read, template)
      else
        @tasks.usage()
      end
    end
  end
end
