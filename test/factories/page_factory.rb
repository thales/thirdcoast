Factory.sequence :page_n do |n|
  "Page #{n}"
end

Factory.define :page do |item|
  item.title Factory.next(:page_n)
  item.template { Factory.create(:page_template) }
end