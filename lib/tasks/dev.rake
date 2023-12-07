desc "Fill the database tables with some sample data"
# lib/tasks/sample_data.rake

# Task for generating fake users, preferred_times, and calendar_times
task :generate_fake_users => :environment do
  if Rails.env.development?
    User.all.each do |user|
      user.preferred_times.destroy_all
      user.calendar_times.destroy_all
      user.destroy
    end
    puts "Deleted prior fake users data."
  end
  puts "Now on to user creation."
  10.times do
    user = User.create!(
      email: Faker::Internet.email,
      password: "password",  # Set a default password for simplicity
      username: Faker::Internet.username,
      # Add other user attributes as needed
    )

    pp "Everything is fine so far"

    start_time = Time.zone.parse(Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :short).to_s)

    start_hour = start_time.hour
    end_hour = rand(1..2).hours.since(start_time).hour

    user.preferred_times.create!(
      # day_of_week: days_of_week.sample,
      start_hour: start_hour,
      end_hour: end_hour,
    )

    pp user.preferred_times

    start_time_calendar = Time.zone.parse(Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :short).to_s)

    start_hour_calendar = start_time_calendar.hour
    end_hour_calendar = rand(1..2).hours.since(start_time_calendar).hour

    user.calendar_times.create!(
      start_hour: start_hour_calendar,
      end_hour: end_hour_calendar,
      description: Faker::Lorem.sentence,
    )

    pp user.calendar_times
  end

  p "There are now #{User.count} users."
end

# Task for generating fake data for a single gym
task :generate_fake_gym do
  # Check if there are any existing places
  if Place.count.zero?
    # Create a new Place
    gym = Place.create!(
      name: "Ape-X Universe",
      # Add other gym attributes as needed
    )
  else
    pp "A Place already exists."
  end

  # Iterate over all places and destroy associated busy times
  Place.all.each do |gym|
    gym.busy_times.destroy_all
  end

  # Create busy times for the new or existing place
  gym.busy_times.create!(
    busy_times: generate_fake_busy_times,
  )
end

def generate_fake_busy_times
  # empty array to store busyness levels
  busy_times = []

  # Fake busyness levels for each hour (1-100)
  (1..24).each do |_hour|
    # Generate a random number between 1 and 100
    busyness = rand(1..100)

    # Append the random busyness to the array
    busy_times.push(busyness)
  end
  busy_times
end

# Task to generate all fake data
task :generate_all => [:generate_fake_users, :generate_fake_gym] do
  puts "All fake data generated successfully!"
  p "There are now #{PreferredTime.count} preferred times"
  p "There are now #{CalendarTime.count} calendar times"
  p "There are now #{BusyTime.count} busy times"
end
