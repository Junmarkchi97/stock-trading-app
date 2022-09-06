# Preview all emails at http://localhost:3000/rails/mailers/approval_mailer
class ApprovalMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/approval_mailer/trader_approved
  def trader_approved
    ApprovalMailer.trader_approved
  end

end
