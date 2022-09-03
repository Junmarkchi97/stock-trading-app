class RegistrationConfirmationMailer < ApplicationMailer
    default from: 'test.avion.19@gmail.com' #pAssword123

    def confirmation_email
      @trader = params[:trader]

      mail(to: @trader.email, subject: "Registration Confirmation")
    end
end
