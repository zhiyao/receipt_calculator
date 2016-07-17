class Tax
  attr_accessor :type, :imported

  def initialize(options)
    define_type_and_import_from(options[:name])
  end

  def rate
    rate = @type == :others ? 10 : 0
    rate += @imported ? 5 : 0
  end

  private

  def define_type_and_import_from(name)
    imported_from(name)
    type_from(name)
  end

  def imported_from(name)
    case name
    when /book/
      @type = :book
    when /chocolate/
      @type = :food
    when /pills/
      @type = :medical
    else
      @type = :others
    end
  end

  def type_from(name)
    case name
    when /imported/
      @imported = true
    else
      @imported = false
    end
  end
end
