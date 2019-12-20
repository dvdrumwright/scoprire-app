User.destroy_all

Daniel = Cyclist.create(name: "Daniel", email: "daniel@daniel.com", bio: "I like riding my bike", password: "test")

Flo = Cyclist.create(name: "Flo", email: "flo@flo.com",bio: "I a furture century finisher", password: "cat")

Post.create(title: "Sunday Baked'N Wired rid",description: "super chill pace, our goal is to enjoy the rolling hils of Virginia", user_id: flo.id)

Post.create(title: "Saturday morning Thrasher", description: "fast from the begining, make sure you are caffeined up !, gonna hit the flat areas of Maryland wiht a fury ", user_id: daniel.id)

Ride.create(ride_date: "December 20th, 2019", location: "test village ", description: "modorate pace, with a few stingers", ride_distance: "100000000", user_id: daniel.id)

Ride.create(ride_date: "January 1st, 2020", location: "country roads test villa", description: "ride to a coffee shop and call it a day ", ride_distance: "20", user_id: flo.id)
