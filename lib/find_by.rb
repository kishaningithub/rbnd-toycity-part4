class Module
  def create_finder_methods(*attributes)
    # Your code goes here!
    # Hint: Remember attr_reader and class_eval
    attributes[0].each do |attribute|
      define_singleton_method "find_by_#{attribute}" do |value|
        options = {}
        options[attribute] = value
        where(options).first
      end
    end
  end
end
