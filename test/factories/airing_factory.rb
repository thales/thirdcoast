Factory.define :airing do |airing|
  airing.date {1.day.from_now}
  airing.feature { Feature.first || Factory.create(:feature) }
end