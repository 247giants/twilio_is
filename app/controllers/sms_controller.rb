class SmsController < ApplicationController
  
  def send_text_message
    number_to_send_to = params[:number_to_send_to]

    twilio_sid = "ACe540ea3ae4f7620548712b8838abe3c9"
    twilio_token = "7668eade2e87d2d78f3bc948a610e66e"
    twilio_phone_number = "17039977790"

    @twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => number_to_send_to,
      :body => "This is an message. It gets sent to #{number_to_send_to}"
    )
    
   redirect_to root_url
  end
  
  def receive_text_message 
    # let's pretend that we've mapped this action to 
    # http://localhost:3000/sms in the routes.rb file
    
    message_body = params["Body"]
    from_number = params["From"]

    SMSLogger.log_text_message from_number, message_body
  end
end
