class Address < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_street, against: :street

  def self.search_city(search_string, city)
    search_string = search_string
      .gsub(/straße/i, 'str')
      .gsub(/strasse/i, 'str')
      .gsub(/[[:digit:]]{5}/, '') # removing PLZ
    nr = search_string.match(/(\d+\w?)/).to_a.try(:first).to_i
    if nr != 0 && search_string[(search_string.index(nr.to_s).to_i - 1)] != " "
      search_string.insert((search_string.index(nr.to_s)), " ")
    end
    p city
    p nr
    return [] unless city && nr
    street_string = search_string
      .gsub(/[[:digit:]]/,'')
      .gsub(/[!@#$%^&*(=)<_>+-,.;]/, '')
      .gsub(city.name,'').gsub(city.slug,'')
      .gsub(/[[:digit:]]{1,6}[[:alpha:]]/,'')
      .gsub(/[[:space:]][[:alpha:]]$/,'') # remove the last letter when typed somthing like `Körnerstraße 2a` it becoms `Körnerstraße a`
    scope =  Address.where(zip: city.zip).search_by_street(street_string)
    return [] if scope.count == 0

    case city.city_housing_type
      when 'normal'
        normal_house_type_query(scope, nr)
      when 'odd_even'
        odd_even_house_type_query(scope, nr)
      when 'mixed_odd_even'
        mixed_odd_even_house_type_query(scope, nr)
      when 'horseshoe'
        horseshoe_house_type_query(scope, nr)
      else
        return []
    end
  end

  def as_json(options={})
    super(
      only: :vote_district_id
    )
  end

  private

  def self.normal_house_type_query(scope, nr)
    scope.where("number_from <= ? AND number_to >= ?", nr, nr)
  end

  def self.odd_even_house_type_query(scope, nr)
    if nr % 2 == 0
      scope.where("number_even_from <= ? AND number_even_to >= ?", nr, nr)
    else
      scope.where("number_odd_from <= ? AND number_odd_to >= ?", nr, nr)
    end
  end

  def self.mixed_odd_even_house_type_query(scope, nr)
    number_variety = (nr % 2 == 0) ? 'even' : 'odd'
    scope.where(" (number_variety='all') OR (number_variety= ? AND number_from <= ? AND number_to >= ?)", number_variety, nr, nr)
  end

  def self.horseshoe_house_type_query(scope, nr)
    # no cities yet
    return []
  end

end
