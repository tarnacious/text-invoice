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
        if mode == "update"
            @tasks.totals(@stdin.read)
        elsif mode == "summary"
            @tasks.summary(@argv)
        elsif mode == "list"
            @tasks.list(@argv)
        elsif mode == "new"
            @tasks.new_invoice()
        elsif mode == "html"
            @tasks.html(@stdin.read)
        elsif mode == "template"
            template = @argv.shift
            if template
                @tasks.template(@stdin.read, template)
            else
                @tasks.usage()
            end
        else
            @tasks.usage()
        end
      end
  end
end
