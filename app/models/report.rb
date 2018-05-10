class Report < ApplicationRecord
  belongs_to :reporter
  belongs_to :responder, optional: true
end
