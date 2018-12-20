class ApplicationMailer < ActionMailer::Base
  default from: ENV['RAILS_MAILER_USER'] ||
                'eotc-helper@spotswoodcollege.school.nz'
  layout 'mailer'
end
