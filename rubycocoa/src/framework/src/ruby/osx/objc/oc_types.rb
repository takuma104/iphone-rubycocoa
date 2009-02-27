#
#  $Id: oc_types.rb 979 2006-05-29 01:18:25Z hisa $
#
#  Copyright (c) 2001 FUJIMOTO Hisakuni
#

module OSX

  module ToFloat
    def force_to_f(val)
      begin
	val.to_f
      rescue NameError
	0.0
      end
    end
  end
  
  class NSPoint
    include ToFloat
    attr_accessor :x, :y
    ZERO = [0.0,0.0].freeze
    def initialize(*args)
      @x = force_to_f(args[0])
      @y = force_to_f(args[1])
    end
    def to_a
      [ @x, @y ]
    end
  end

  class NSSize
    include ToFloat
    attr_accessor :width, :height
    ZERO = [0.0,0.0].freeze
    def initialize(*args)
      @width = force_to_f(args[0])
      @height = force_to_f(args[1])
    end
    def to_a
      [ @width, @height ]
    end
  end

  class NSRect
    attr_accessor :origin, :size
    ZERO = [0.0,0.0,0.0,0.0].freeze
    def initialize(*args)
      if args.size == 2 then
	@origin = NSPoint.new(*(args[0].to_a))
	@size = NSSize.new(*(args[1].to_a))
      elsif args.size == 4 then
	@origin = NSPoint.new(*(args[0,2]))
	@size = NSSize.new(*(args[2,2]))
      else
	@origin = NSPoint.new
	@size = NSSize.new
      end
    end
    def to_a
      [ @origin.to_a, @size.to_a ]
    end
    def x() @origin.x end
    def y() @origin.y end
    def width() @size.width end
    def height() @size.height end
  end

  class NSRange
    attr_accessor :location, :length
    ZERO = [0,0].freeze
    def initialize(*args)
      @location = @length = 0
      args.flatten!
      if args.size == 1 then
	if args[0].is_a? Range then
	  rng = args[0]
	  @location = rng.first
	  @length = rng.last - rng.first + (rng.exclude_end? ? 0 : 1)
	end
      elsif args.size == 2 then
	@location = args[0].to_i
	@length = args[1].to_i
      end
    end
    def to_a
      [ @location, @length ]
    end
    def to_range
      Range.new(@location, @location + @length - 1)
    end
  end

end				# module OSX
