report_event
  report_id
  event_type
  payload
  created_at
  

// serialize each report event with a serializer for that event_type 
event_type REPORT_CREATED
payload {
  reporter_user_name: "foo",
  reporter_user_phone: "",
  report_notes: "",
  report_source: "sms"

}

event_type:RESPONDER_DISPATCH_ATTEMPTED
payload {
  affiliate_name: "Homeless Outreach Services",
  affiliate_id:
  responder_user_id:
  responder_user_name: "joe",
  responder_user_phone: ""
}
event_type: RESPONDER_DISPATCH_ATTEMPT
{
  dispatch_status: "NO_RESPONSE|PASSED|DISMISSED|REFERRED|ACCEPTED"
}

event_type: RESPONDER_DISPATCH_ANSWERED
payload: {
  responder_user_id,
  responder_user_name,
  responder_affiliate_name

}

event_type: RESPONDER_DISPATCHED
payload {
  user_type: "SYSTEM",
  user_id:
  user_name:
  responder_id:
  responder_name
}

event_type: REPORT_REFERRED
payload {
  user_id:
  user_name:
  referral_affiliate_name: "SF HOT"
  referral_notes: ""
}

event_type: RESPONDER_ARRIVED
event_type: REPORT_CLOSED
{
  report_responder_reporter_notes
  report_responder_internal_notes
}

event_type: REPORT_NOTE_ADDED
{
  user_id:
  user_name:
}

event_type: REPORT_STATUS_CHANGED
{
  user_type: "SYSTEM"
  user_id:

}

class Report
// class ReportNote
 user_id:
 notes:
 status: PENDING | ASSIGNED | ARRIVED | CLOSED

class Affiliate
  survey_url

class Dispatch
  dispatch_type: AUTO | MANUAL
  user_id?:
  responder_id
  report_id
  status: "PENDING|PASSED|STALE|NO_RESPONSE|REFERRED|ACCEPTED|DISMISSED|CLOSED"

// class Referral
  user_id
  affiliate_id
  notes

## Responder flow options

Are you available to handle this crisis? If we don't hear back from you, we'll keep trying to contact other responders.

Text us back one of the following responses.

accept - We'll let the reporter know you are on the way
dismiss - Something is wrong with this report, we'll get your feedback and close the report

