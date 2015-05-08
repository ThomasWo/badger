class ExportAttendees
  include Interactor

  def call
    if context.attendees.present?
      context.pdf = export(context.attendees)
    elsif context.blanks && context.event.present?
      context.pdf = export_blanks(context.event)
    else
      context.fail!(message: "No attendees to export.")
    end
  end

  private

  def export(attendees)
    CaseyBadgePdf.new(attendees)
  end

  def export_blanks(event)
    CaseyBadgePdf.new(nil, event)
  end
end
