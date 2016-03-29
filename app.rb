require './models/account'

Account.create({
  :name => 'Testy',
  :password_hash => BCrypt::Password.create('ajsajflsfjfljsffljsadlfj'),
  :email => 'test@heyya.outkast'
}).save

p Account.all
