Factory.sequence :producer_name do |t|
  "Producer ##{t}"
end

Factory.define :producer do |producer|
  producer.name {Factory.next(:producer_name)}
  producer.bio 'MyText'
end