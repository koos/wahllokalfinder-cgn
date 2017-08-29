class Address < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_street,
                  against: :street,
                  using: {
                    tsearch: {
                      any_word: true
                    }
                  }

  def self.search(search_string)
    search_string = search_string.gsub('straße', 'str')
    zip = search_string.match(/\d{5}/).to_a.try(:first)
    nr = search_string.match(/(\d+\w?)/).to_a.try(:first).to_i
    if nr != 0 && search_string[(search_string.index(nr.to_s).to_i - 1)] != " "
      search_string.insert((search_string.index(nr.to_s)), " ")
    end
    return [] unless zip && nr
    scope = Address.where(zip: zip).search_by_street(search_string)
    if nr % 2 == 0
      scope.where("number_even_from <= ? AND number_even_to >= ?", nr, nr)
    else
      scope.where("number_odd_from <= ? AND number_odd_to >= ?", nr, nr)
    end
  end

  def self.search_city(search_string, city_zip)
    search_string = search_string.gsub('straße', 'str')
    nr = search_string.match(/(\d+\w?)/).to_a.try(:first).to_i
    if nr != 0 && search_string[(search_string.index(nr.to_s).to_i - 1)] != " "
      search_string.insert((search_string.index(nr.to_s)), " ")
    end
    return [] unless city_zip && nr
    scope = Address.where(zip: city_zip).search_by_street(search_string)
    if nr % 2 == 0
      scope.where("number_even_from <= ? AND number_even_to >= ?", nr, nr)
    else
      scope.where("number_odd_from <= ? AND number_odd_to >= ?", nr, nr)
    end
  end

  def as_json(options={})
    super(
      only: :vote_district_id
    )
  end

end
