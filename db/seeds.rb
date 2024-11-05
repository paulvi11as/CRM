# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
customers = [
  { full_name: "Drock Johnson", phone_number: "123-456-7890", email: "drock@gmail.com", notes: "VIP customer", image: "customer1.jpg" },
  { full_name: "Al Exel", phone_number: "987-654-3210", email: "alexel@gmail.com", notes: "Loyal Customer since est", image: "customer2.jpg" },
  { full_name: "John Doe", phone_number: "555-123-4567", email: nil, notes: "Huge Businessman", image: "customer3.jpg" },
  { full_name: "Derick Odom", phone_number: "444-555-6666", email: "dodom@gmail.com", notes: "First-time customer", image: "customer4.jpg" },
  { full_name: "Jose White", phone_number: "333-222-1111", email: nil, notes: "Really nice customer", image: "customer5.jpg" }
]

customers.each do |customer_data|
  customer = Customer.create(
    full_name: customer_data[:full_name],
    phone_number: customer_data[:phone_number],
    email: customer_data[:email],
    notes: customer_data[:notes]
  )

  # Attach the image if it exists in the specified path
  image_path = Rails.root.join('db', 'seeds', 'images', customer_data[:image])
  if File.exist?(image_path)
    customer.image.attach(
      io: File.open(image_path),
      filename: customer_data[:image],
      content_type: 'image/jpeg'
    )
    puts "Attached image #{customer_data[:image]} to #{customer.full_name}"
  else
    puts "Image #{customer_data[:image]} not found for #{customer.full_name}"
  end
end

puts "Seeded #{Customer.count} customers with images."