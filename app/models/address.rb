class Address < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_street, :against => :street, :using => { :tsearch => { :any_word => true } }

  def self.search(search_string)
    zip = search_string.match(/\d{5}/)[0]
    nr = search_string.match(/(\d+\w?)/)[0].to_i
    if nr % 2 == 0
      Address.where(zip: zip).search_by_street(search_string).where("number_even_from <= ? AND number_even_to >= ?", nr, nr)
    else
      Address.where(zip: zip).search_by_street(search_string).where("number_odd_from <= ? AND number_odd_to >= ?", nr, nr)
    end
  end

end
