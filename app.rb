require './models/account'

Account.create({
  :name => 'Testy',
  :password_hash => BCrypt::Password.create('ajsajflsfjfljsffljsadlfj'),
  :email => 'test@heyya.outkast'
}).save

get '/' do
  Account.all.to_json
end
