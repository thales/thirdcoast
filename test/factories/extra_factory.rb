Factory.define :extra do |extra|
  extra.behind_the_scene_text "MyString"
  extra.links_block 'MyString'
  extra.association :feature
end