Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "749053093082-jmk768anit73eobbu3ggppgib6k26pgq.apps.googleusercontent.com", "CFYVXSN72rXKHbTpQ3HYx2IS"
end