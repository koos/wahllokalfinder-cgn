class Address < ActiveRecord::Base
  include PgSearch
  pg_search_scope :search_by_street, :against => :street, :using => { :tsearch => { :any_word => true } }

  def self.search(search_string)
    zip = search_string.match(/\d{5}/).to_a.try(:first)
    nr = search_string.match(/(\d+\w?)/).to_a.try(:first).to_i
    if zip && nr && nr % 2 == 0
      Address.where(zip: zip).search_by_street(search_string).where("number_even_from <= ? AND number_even_to >= ?", nr, nr)
    elsif zip && nr
      Address.where(zip: zip).search_by_street(search_string).where("number_odd_from <= ? AND number_odd_to >= ?", nr, nr)
    else
      []
    end
  end

  def as_json(options={})
    super(
      only: :vote_district_id
    )
  end

end
