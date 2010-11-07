class Nibblet < Nibbler

  def self.add_selector(selector_key, opts)
    if !opts["multiple"] & opts["block"].nil?
      self.element opts["selector"] => selector_key.to_sym
    elsif opts["multiple"]
      self.elements opts["selector"] => selector_key.to_sym
    else
      self.elements opts["selector"] => selector_key.to_sym do
        opts["block"].each do |block_key, selector|
          self.element selector => block_key.to_sym
        end
      end
    end
  end

  def results_hash(selectors)
    results = selectors.inject({}) do |hash, selector|
      selector_key, opts = selector
      if opts["block"].nil?
        hash.merge self.element_hash(selector_key)
      else
        hash.merge self.block_hash(selector_key, opts)
      end
    end
  end

  def element_hash(element_key)
    {element_key => self.send(element_key.to_sym)}
  end

  def block_hash(block_key, opts)
    block_elements = self.send(block_key.to_sym)
    block_element_keys = opts["block"].keys
    block_array = block_elements.collect do |block|
      block_element_keys.inject({}) do |hash, element_key|
        hash.merge(element_key => block.send(element_key.to_sym))
      end
    end
    {block_key => block_array}
  end

end