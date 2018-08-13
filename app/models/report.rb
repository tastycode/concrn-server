class Report < ApplicationRecord
  belongs_to :reporter
  belongs_to :responder, optional: true
  has_many :report_events, autosave: true
  has_many :dispatches

  STATUS_NEW = "NEW"
  STATUS_ASSIGNED = "ASSIGNED"
  STATUS_ARRIVED = "ARRIVED"
  STATUS_DISMISSED = "DISMISSED"
  STATUS_CLOSED = "CLOSED"

  ZipMissingError = Class.new(StandardError)

  # high-level actions
  def dispatch!
    Report::DispatchJob.perform_later(report_id: id)
  end

  def attempt_dispatch!(responder:, distance: nil)
    Report::DispatchAttemptJob.perform_later(
      report_id: id,
      responder_id: responder.id,
      distance: distance
    )
  end

  # requests from the native apps should have the zip, but requests from twilio may not
  # because though twilio is capable of making a request to the places API, it is not capable
  # of diving deeply into the response to get the postal code among the array of address components
  def resolve_zip!
    Report::ResolveZipJob.perform_later(
      report_id: id
    )
  end

  # utility functions

  def lat=(lat)
    coordinates.x = lat
  end

  def long=(long)
    coordinates.y = long
  end

  def coordinates
    super || ActiveRecord::Point.new.tap do |point|
      write_attribute(:coordinates, point)
    end
  end
end
