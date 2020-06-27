class Primitive
  def initialize(attributes)
    attr_keys.each { |key| send("#{key}=", attributes[key]) }
  end

  def primitive_marker
    self.class.name.downcase
  end

  def attr_keys
    self.class.class_variable_get(:@@attr_keys)
  end

  def serialize
    attr_keys.map { |key| [key, send(key)] }.to_h
  end

  def inspect
    serialize.to_s
  end

  def to_s
    serialize.to_s
  end
end

class Solid < Primitive
  @@attr_keys = %i[x y w h r g b a]
  attr_accessor(*@@attr_keys)
end

class Line < Primitive
  @@attr_keys = %i[x y x2 y2 r g b a]
  attr_accessor(*@@attr_keys)
end

class Label < Primitive
  @@attr_keys = %i[x y text size_enum alignment_enum font r g b a]
  attr_accessor(*@@attr_keys)
end

class Sprite < Primitive
  @@attr_keys = %i[
    x y w h path angle a r g b
    source_x source_y source_w source_h
    flip_horizontally flip_vertically
    angle_anchor_x angle_anchor_y
    tile_x tile_y tile_w tile_h
  ]
  attr_accessor(*@@attr_keys)
end
