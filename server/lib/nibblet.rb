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
    results = {}
    selectors.each do |selector_key, opts|
      if opts["block"].nil?
        results.merge! self.collect_elements(selector_key)
      else
        results.merge! self.collect_iterators(selector_key, opts)
      end
    end
    results
  end

  def collect_elements(selector_key)
    {selector_key => self.send(selector_key.to_sym)}
  end

  def collect_iterators(selector_key, opts)
    block_keys = opts["block"].keys
    block_array = self.send(selector_key.to_sym).inject([]) do |array, iterator|
      element_hash = block_keys.inject({}) do |hash, e_key|
        element = iterator.send(e_key.to_sym)
        hash.merge(e_key => element)
      end
      array << element_hash
    end
    {selector_key => block_array}
  end

end