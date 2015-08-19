class ImportAttendees
  include Interactor

  def call
    if context.file
      context.failed_imports = []
      context.attendees = import(context.file)
    else
      context.fail!(message: "Unable to import attendees")
    end
  end

  private

  def import(file)
    require "csv"

    CSV.foreach(file.path, headers: true) do |row|
      attendee = Attendee.find_or_create_by(confirmation: row['confirmation'], event: context.event)

      unless attendee.exported
        attendee.update_attributes(
          first_name: row['first-name'],
          last_name: row['last-name'],
          email: row['email'],
          twitter_handle: row['website-twitter'],
          shirt_size: row['shirt'],
          role: Role.find_by(name: "Speaker"),
          exported: false
        )
      end

      # unless attendee.exported
      #   attendee.update_attributes(
      #     first_name: row['first_Name'],
      #     last_name: row['last_Name'],
      #     company: row['Company'],
      #     exported: false
      #   )

      #   case row['RegTypeDescription']
      #   when /Sponsor/, /Sponsor Guest/, /SoftwareGR Board Member/, /GLSEC/
      #     attendee.update_attribute(:role, Role.find_by(name: "Sponsor"))
      #   when /Guest/
      #     attendee.update_attribute(:role, Role.find_by(name: "Speaker"))
      #   when /Volunteer/
      #     attendee.update_attribute(:role, Role.find_by(name: "Volunteer"))
      #   else
      #     attendee.update_attribute(:role, Role.find_by(name: "Attendee"))
      #   end

      #   if context.event.sponsor_companies.map { |c| c.company.downcase.squish }.include?(attendee.company.try(:downcase).try(:squish))
      #     attendee.update_attribute(:role, Role.find_by(name: "Sponsor"))
      #   end
      # end
    end
  end
end
