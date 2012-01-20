module SpookyCore
  module XmlHelpers
    def errors
      @errors ||= begin
        nodes = @doc.css('payment_method/errors/error')
        nodes.inject({}) do |h, error|
          key     = error.attr('attribute').to_sym
          h[key]  = error.text
          h
        end
      end
    end

    private

    def create_doc(root, xml)
      @root = root
      @doc = Nokogiri::XML::DocumentFragment.parse(xml)
    end

    def at(path, coerce_with = nil)
      @values ||= {}
      @values[path] ||= begin
        node = @doc.at("#{@root}/#{path}")

        if node
          text = node.text
          coerce_with ? text.send(coerce_with) : text
        end
      end
    end # #at
  end #XmlHelpers
end #SpookyCore
