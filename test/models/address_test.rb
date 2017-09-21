require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  test "Sanitaize Search String" do
    assert_equal Address.sanitaize_search_string('Körner str 2a'), 'Körner str 2a'
    assert_equal Address.sanitaize_search_string('Körner strasse 2a'), 'Körner str 2a'
    assert_equal Address.sanitaize_search_string('Körner straße 2a'), 'Körner str 2a'
    assert_equal Address.sanitaize_search_string('Körnerstr 2a'), 'Körnerstr 2a'
    assert_equal Address.sanitaize_search_string('Körnerstrasse 2a'), 'Körnerstr 2a'
    assert_equal Address.sanitaize_search_string('Körnerstraße 2a'), 'Körnerstr 2a'
    assert_equal Address.sanitaize_search_string('An der Bottmühle 5, 50678 Köln'), 'An der Bottmühle 5, Köln'
    assert_equal Address.sanitaize_search_string('An der Bottmühle 5 50678'), 'An der Bottmühle 5'
    assert_equal Address.sanitaize_search_string('  An der     Bottmühle    5, 50678    Köln    '), 'An der Bottmühle 5, Köln'
    assert_equal Address.sanitaize_search_string('An der Bottmühle 5, 50678 Köln'), 'An der Bottmühle 5, Köln'
  end

  test "Sanitaize Street String" do
    braavos = cities(:braavos)
    assert_equal Address.sanitaize_street_string('Körnerstr 2a, 99909 Braavos 99999 braavos', braavos), 'Körnerstr'

    qarth = cities(:qarth)
    assert_equal Address.sanitaize_street_string('An der Bottmühle 5, 99999 Qarth', qarth), 'An der Bottmühle'
    assert_equal Address.sanitaize_street_string('Körnerstr ,.12.3, ,.1,23.,.13.1, ', qarth), 'Körnerstr'
    assert_equal Address.sanitaize_street_string('An der Bottmühle 5 99999', qarth), 'An der Bottmühle'

  end

  test "Search City" do

    # Braavos City
    braavos = cities(:braavos)

    address1 = Address.search_city('Sellagoro Shield Straße 3', braavos)
    assert_equal address1.count, 1
    assert_equal Station.find_by_vote_district_id(address1.first.vote_district_id).district, 'Many Faced God'

    address2 = Address.search_city('Sellagoro Shield Straße. 20', braavos)
    assert_equal address2.count, 1
    assert_equal Station.find_by_vote_district_id(address2.first.vote_district_id).name, 'House of Black and White'

    address3 = Address.search_city('Sellagoro Shield Straße 21', braavos)
    assert_equal address3.count, 0

    address4 = Address.search_city(' dragons str .2a, 99999 Braavos 22 __ 12 22 ,,, +++ ', braavos)
    assert_equal address4.count, 1
    assert_equal Station.find_by_vote_district_id(address4.first.vote_district_id).name, 'House of Black and White'

    address5 = Address.search_city('Dragons str 5', braavos)
    assert_equal address5.count, 0

    # Qarth City
    qarth = cities(:qarth)

    address6 = Address.search_city('Dragons str 2', qarth)
    assert_equal address6.count, 1
    assert_equal Station.find_by_vote_district_id(address6.first.vote_district_id).name, 'Balerion Hall'

    address7 = Address.search_city('Dragons strasse 2', qarth)
    assert_equal address7.count, 1
    assert_equal Station.find_by_vote_district_id(address7.first.vote_district_id).address, 'Balerion Monument'

    address8 = Address.search_city('   dragons      strasse    #.,.,.,@#!# 2    ,     30627  99999  Qarth ', qarth)
    assert_equal address8.count, 1
    assert_equal Station.find_by_vote_district_id(address8.first.vote_district_id).address, 'Balerion Monument'

    address9 = Address.search_city('   dragons      strasse.2', qarth)
    assert_equal address9.count, 1
    assert_equal Station.find_by_vote_district_id(address9.first.vote_district_id).address, 'Balerion Monument'

  end

end
