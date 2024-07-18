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

  def render(toggle=false)
    if toggle
      if @fired == false && !empty?
        return "S"
      end
    end
    
    if @fired == false
      return "."
    elsif empty? 
      return "M"
    elsif @ship.sunk?
      return "X"
    else
      return "H"
    end
  end
end