require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "Sanitaize Search String" do
    assert_equal Address.sanitaize_search_string('Körnerstr 2a'), 'Körnerstr 2a'
    assert_equal Address.sanitaize_search_string('Körnerstrasse 2a'), 'Körnerstr 2a'
    assert_equal Address.sanitaize_search_string('Körnerstraße 2a'), 'Körnerstr 2a'

    assert_equal Address.sanitaize_search_string('Körner str 2a'), 'Körner str 2a'
    assert_equal Address.sanitaize_search_string('Körner strasse 2a'), 'Körner str 2a'
    assert_equal Address.sanitaize_search_string('Körner straße 2a'), 'Körner str 2a'

    assert_equal Address.sanitaize_search_string('  An der     Bottmühle    5, 50678    Köln    '), 'An der Bottmühle 5, Köln'
    assert_equal Address.sanitaize_search_string('An der Bottmühle 5, 50678 Köln'), 'An der Bottmühle 5, Köln'
  end

  test "Sanitaize Street String" do
    braavos = cities(:braavos)
    assert_equal Address.sanitaize_street_string('Körnerstr 2a, 99909 braavos', braavos), 'Körnerstr'

  end
end
