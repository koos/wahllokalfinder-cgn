# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
cologne = {
  name: "Köln",
  slug: "koeln",
  zip: [50667, 50668, 50670, 50672, 50674, 50676, 50677, 50678, 50679, 50733, 50735, 50737, 50739, 50765, 50767, 50769, 50823, 50825, 50827, 50829, 50858, 50859, 50931, 50933, 50935, 50937, 50939, 50968, 50969, 50996, 50997, 50999, 51061, 51063, 51065, 51067, 51069, 51103, 51105, 51107, 51109, 51143, 51145, 51147, 51149, 51467],
  state: "Nordrhein-Westfalen",
  coordinates: "6.95, 50.93333",
  city_housing_type: "odd_even" }

potsdam = {
  name: "Potsdam",
  slug: "potsdam",
  zip: [ 14197, 14199, 14467, 14469, 14471, 14473, 14476, 14478, 14480 ],
  state: "Brandenburg",
  coordinates: "13.0645, 52.3906",
  city_housing_type: "mixed_odd_even" }

frechen = {
  name: "Frechen",
  slug: "frechen",
  zip: [50226],
  state: "Nordrhein-Westfalen",
  coordinates: "6.8160, 50.9122",
  city_housing_type: "odd_even" }
aldenhoven = {
  name: "Aldenhoven",
  slug: "aldenhoven",
  zip: [52457],
  state: "Nordrhein-Westfalen",
  coordinates: "6.283056, 50.895833",
  city_housing_type: "odd_even"
}
bad_muenstereifel = {
  id: 5,
  name: "Bad Münstereifel",
  slug: "bad_muenstereifel",
  zip: [53902],
  state: "Nordrhein-Westfalen",
  coordinates: "6.766111,
  50.553056",
  created_at: "2017-09-06 15:10:15",
  updated_at: "2017-09-06 15:10:15",
  city_housing_type: "odd_even"
}

City.create([ cologne, potsdam, frechen, aldenhoven, bad_muenstereifel ])
