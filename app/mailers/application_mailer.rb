class ApplicationMailer < ActionMailer::Base
  default from: "bideowego@danebook.com"
  layout 'mailer'

  protected
  def subject(text)
    "BideoWego Danebook - #{text}"
  end
end
