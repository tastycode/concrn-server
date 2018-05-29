class Report::Commands::Dispatch < Command
  DISPATCH_BATCH_SIZE = 5
  required_params :report
  def perform
    raise Report::ZipMissingError unless report.zip.present?
    responders = dispatch_responders
    responders.each do |responder|
      report.attempt_dispatch!(responder: responder, distance: responder.distance)
    end
  end

  def nondispatched_responders
    Responder
      .where.not(id: report.dispatches.pluck(:responder_id))
  end

  def affiliate_responders
    nondispatched_responders
      .joins(user: [affiliate: [:zip_fences]])
      .where(user: {affiliate: { zip_fences: {zip: report.zip} }})
      .where(available: true)
  end

  def point_responders
    # radius is expressed in kilometers within the DB, so we multiply by 1k
    affiliate_responders
      .joins(:point_fences)
      .select("responders.*")
      .select("#{distance_expression}/1000.0 as distance")
      .where("#{distance_expression} < point_fences.radius*1000")
      .order("distance asc")
      .limit(DISPATCH_BATCH_SIZE)
  end

  def distance_expression
    "ST_Distance(GEOMETRY(POINT(#{report.coordinates.x}, #{report.coordinates.y}))::geography, GEOMETRY(point_fences.coordinates)::geography)"
  end

  def zip_responders
    affiliate_responders
      .joins(:zip_fences)
      .select("responders.*")
      .select("1000 as distance")
      .where(zip_fences_responders: { zip: report.zip})
      .limit(DISPATCH_BATCH_SIZE)
  end

  def dispatch_responders
    [*point_responders, *zip_responders]
      .sort_by(&:distance)
  end
end
