class ApprovalMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.approval_mailer.trader_approved.subject
  #
  def trader_approved
    @greeting = "Hi, you have been approved for trading."
    @trader = params[:trader]

    mail(to: @trader.email, subject: "Approved Trading")
  end
end
