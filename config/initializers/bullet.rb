if defined? Bullet
  Bullet.enable = true
  # Bullet.alert = true
  Bullet.bullet_logger = true

  Bullet.alert = true
  Bullet.console = true
  #Bullet.growl = true
  # Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
  #                 :password => 'bullets_password_for_jabber',
  #                 :receiver => 'your_account@jabber.org',
  #                 :show_online_status => true }
  Bullet.rails_logger = true
  # Bullet.bugsnag = true
  # Bullet.airbrake = true
  Bullet.add_footer = true
end
