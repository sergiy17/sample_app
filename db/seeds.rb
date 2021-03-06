User.create!(name: "Example name", email: "admin@mail.com",
						 password: "foobar", password_confirmation: "foobar",
						 admin: true, activated: true, activated_at: DateTime.now)

100.times do |examp|
	name = Faker::Name.name
	email = "example-#{examp + 1}@gmail.com"
	password = "password1"
	User.create!(name: name, email: email,
							 password: password, password_confirmation: password,
							 activated:true, activated_at: DateTime.now)
end
