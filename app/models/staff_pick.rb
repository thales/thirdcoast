class StaffPick < ActiveRecord::Base

  named_scope :three_staffs, {:limit => 3}

  validates_presence_of :name
  validates_presence_of :blip

  define_index do
    indexes name, :sortable => true
    indexes blip

    set_property :delta => true
  end
  

end
