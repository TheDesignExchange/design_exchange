class Citation < ActiveRecord::Base

  belongs_to :design_method
  belongs_to :method_citation
end
