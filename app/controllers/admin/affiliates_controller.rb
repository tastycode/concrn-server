class Admin::AffiliatesController < Admin::Controller
  MODEL = Affiliate
  PERMITTED_PARAMS = %i(name)
  default_actions
end
