class TouristSightFacade

  def self.get_tourist_sights(country)
    all_sight_data = PlaceService.get_tourist_sights('france')[:features]
    all_sight_data.map do |sight|
      TouristSight.new(sight)
    end
  end
end