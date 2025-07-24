class RatingMailer < ApplicationMailer
  def new_rating(event, rating)
    @event = event
    @rating = rating
    mail(
      to: event.speakers.map(&:email),
      subject: "[#{event.conference.acronym}] New rating for your event: #{event.title}"
    )
  end
end