class Cell
  attr_reader :coordinate, :ship
  
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end
  
  def fired_upon?
    @fired
  end

  def fire_upon
    ship_hit
    @fired = true
  end

  def ship_hit
    if !empty?
      @ship.hit
    end
    false
  end

  def render(toggle = false)
    return "S" if toggle && !@fired && !empty?
    return "." unless @fired
    return "M" if empty?
    return "X" if @ship.sunk?
    "H"
  end
end