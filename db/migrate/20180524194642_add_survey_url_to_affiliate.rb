class AddSurveyUrlToAffiliate < ActiveRecord::Migration[5.1]
  def change
    add_column :affiliates, :survey_url, :string
  end
end
