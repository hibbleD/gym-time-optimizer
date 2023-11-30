desc "Fill the database tables with some sample data"
# lib/tasks/sample_data.rake

    # Task for generating fake users, preferred_times, and calendar_times
    task :generate_fake_users do
      if Rails.env.development?
        User.destroy_all
        puts "Deleted prior fake users data."
      end

      10.times do
        user = User.create!(
          email: Faker::Internet.email,
          password: "password",  # Set a default password for simplicity
          username: Faker::Internet.username,
          # Add other user attributes as needed
        )

        pp "Everything is fine so far"
        user.preferred_times.create!(
          
          day_of_week: days_of_week.sample,
          start_hour: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :short),
          end_hour: Faker::Time.between(from: DateTime.now + 31, to: DateTime.now + 60, format: :short),
        )

        pp user.preferred_times

        user.calendar_times.create!(
          start_hour: Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :short),
          end_hour: Faker::Time.between(from: DateTime.now + 31, to: DateTime.now + 60, format: :short),
          description: Faker::Lorem.sentence,
        )
        pp user.calendar_times
      end

      p "There are now #{User.count} users."
      
    end

    # Task for generating fake data for a single gym
    task :generate_fake_gym do
      if Rails.env.development?
        Place.destroy_all
        puts "Deleted prior fake gym data."
      end

      gym = Place.create!(
        name: "Ape-X Universe",
        # Add other gym attributes as needed
      )

      gym.busy_times.create!(
        times_data: generate_fake_busy_times,
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
    end

    # Task to generate all fake data
    task :generate_all => [:generate_fake_users, :generate_fake_gym] do
      puts "All fake data generated successfully!"
    end
  
