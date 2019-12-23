Cyclist.destroy_all

daniel = Cyclist.create(name: "Daniel", email: "daniel@daniel.com", bio: "I like riding my bike", password: "test")

flo = Cyclist.create(name: "Flo", email: "flo@flo.com",bio: "I am a future century finisher", password: "cat")

Post.create(title: "Sunday Baked'N Wired ride",description: "super chill pace, our goal is to enjoy the rolling hils of Virginia", user_id: flo.id)

Post.create(title: "Saturday morning Thrasher", description: "fast from the begining, make sure you are caffeined up !, gonna hit the flat areas of Maryland wiht a fury ", user_id: daniel.id)

Ride.create(ride_date: "December 20th, 2019", ride_distance: " 70 to 80 miles",  location: "test village ", description: "modorate pace, with a few stingers", user_id: daniel.id)

Ride.create(ride_date: "January 1st, 2020", ride_distance: " 40 to 55 miles" , location: "country roads test villa", description: "ride to a coffee shop and call it a day ", user_id: flo.id)
