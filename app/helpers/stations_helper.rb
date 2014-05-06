module StationsHelper

  def stations?
    @without_wheelchair_stations.length > 0 || @with_wheelchair_stations.length > 0
  end

end
