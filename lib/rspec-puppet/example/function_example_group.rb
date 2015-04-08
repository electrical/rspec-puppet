module RSpec::Puppet
  module FunctionExampleGroup
    include RSpec::Puppet::FunctionMatchers
    include RSpec::Puppet::ManifestMatchers
    include RSpec::Puppet::Support

    def subject
      function_name = self.class.top_level_description.downcase

      vardir = setup_puppet

      # Return the method instance for the function.  This can be used with
      # method.call
      FileUtils.rm_rf(vardir) if File.directory?(vardir)
      env = Puppet::Node::Environment.create(:testing, [])
      loaders = Puppet::Pops::Loaders.new(env)
      loaders.public_environment_loader.load(:function, function_name)
    end

    def catalogue
      @catalogue ||= compiler.catalog
    end

    private

    def compiler
      @compiler ||= build_compiler
    end

    # get a compiler with an attached compiled catalog
    def build_compiler
      node_name   = nodename(:function)
      fact_values = facts_hash(node_name)

      # if we specify a pre_condition, we should ensure that we compile that
      # code into a catalog that is accessible from the scope where the
      # function is called
      Puppet[:code] = pre_cond

      node_options = {
        :parameters => fact_values,
      }

      stub_facts! fact_values

      node = build_node(node_name, node_options)

      compiler = Puppet::Parser::Compiler.new(node)
      compiler.compile
      compiler
    end
  end
end
