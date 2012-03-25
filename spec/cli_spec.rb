require 'text-invoice'

describe TextInvoice::CLI do
    it "should return usage details with no parameters" do
        tasks = double("tasks")
        tasks.should_receive(:usage).and_return("usage details")

        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.run().should eql("usage details")
    end
    
    it "should return usage details with unknow parameters" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("something we don't do")

        tasks = double("tasks")
        tasks.should_receive(:usage).and_return("usage details")

        cli = TextInvoice::CLI.new
        cli.argv = argv
        cli.tasks = tasks
        cli.run().should eql("usage details")
    end
    
    it "should return summary task with argv parameter" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("summary")
        
        tasks = double("tasks")
        tasks.should_receive(:summary).with(argv).and_return("summary results")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv

        cli.run().should eql("summary results")
    end
    
    it "should return summary task with argv parameters" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("summary")
        
        tasks = double("tasks")
        tasks.should_receive(:summary).with(argv).and_return("summary results")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv

        cli.run().should eql("summary results")
    end
    
    it "should return list task with argv parameter" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("list")
        
        tasks = double("tasks")
        tasks.should_receive(:list).with(argv).and_return("list results")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv

        cli.run().should eql("list results")
    end
    
    it "should return totals task with stdin parameter" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("update")
        
        stdin = double("stdin")
        stdin.should_receive(:read).and_return("stdin")
        
        tasks = double("tasks")
        tasks.should_receive(:totals).with("stdin").and_return("totals results")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.stdin = stdin
        cli.argv = argv

        cli.run().should eql("totals results")
    end
    
    it "should return new invoice" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("new")
        
        tasks = double("tasks")
        tasks.should_receive(:new_invoice).with(no_args()).and_return("new invoice yaml")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv

        cli.run().should eql("new invoice yaml")
    end

    it "should html template invoices" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("html")
        
        stdin = double("stdin")
        stdin.should_receive(:read).and_return("stdin")
        
        tasks = double("tasks")
        tasks.should_receive(:html).with("stdin").and_return("invoice html")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv
        cli.stdin = stdin

        cli.run().should eql("invoice html")
    end
    
    it "should custom template invoices" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("template", "template_path")
        
        stdin = double("stdin")
        stdin.should_receive(:read).and_return("stdin")
        
        tasks = double("tasks")
        tasks.should_receive(:template).with("stdin","template_path").and_return("invoice html")
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv
        cli.stdin = stdin

        cli.run().should eql("invoice html")
    end
    
    it "should return usage if custom template path not provided" do
        argv = double("argv")
        argv.should_receive(:shift).and_return("template", nil)
        
        tasks = double("tasks")
        tasks.should_receive(:usage)
        
        cli = TextInvoice::CLI.new
        cli.tasks = tasks
        cli.argv = argv

        cli.run()
    end

 end
