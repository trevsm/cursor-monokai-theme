# Ruby Demo File

# Constants
API_URL = "https://api.example.com"
MAX_RETRIES = 3
TIMEOUT = 5.0

# Modules
module Assignee
  def assign_to(user)
    @assignee = user
  end

  def assigned?
    !@assignee.nil?
  end
end

# Classes
class User
  include Assignee

  attr_accessor :name, :email
  attr_reader :id, :created_at
  attr_writer :role

  @@user_count = 0

  def initialize(name, email, role = "user")
    @id = @@user_count += 1
    @name = name
    @email = email
    @role = role
    @created_at = Time.now
  end

  def admin?
    @role == "admin"
  end

  def display_name
    "#{@name} <#{@email}>"
  end

  def self.find_by_id(id)
    all.find { |user| user.id == id }
  end

  def self.all
    @users ||= []
  end

  def to_s
    display_name
  end

  def to_h
    {
      id: @id,
      name: @name,
      email: @email,
      role: @role,
      created_at: @created_at
    }
  end
end

# Inheritance
class Admin < User
  def initialize(name, email)
    super(name, email, "admin")
  end

  def can_delete_users?
    true
  end
end

# Modules as namespaces
module API
  class Client
    def initialize(base_url)
      @base_url = base_url
    end

    def get(endpoint)
      uri = URI("#{@base_url}#{endpoint}")
      Net::HTTP.get_response(uri)
    end
  end
end

# Blocks and Procs
def process_users(users, &block)
  users.each do |user|
    yield user if block_given?
  end
end

# Lambda
greet = ->(name) { "Hello, #{name}!" }

# Proc
calculate_total = Proc.new do |items|
  items.sum { |item| item[:price] }
end

# Symbols and Hashes
user_roles = {
  admin: "Administrator",
  user: "Regular User",
  moderator: "Moderator"
}

# Hash with default values
config = Hash.new { |h, k| h[k] = [] }
config[:features] << "dark_mode"
config[:features] << "notifications"

# Arrays
users = [
  User.new("Alice", "alice@example.com", "admin"),
  User.new("Bob", "bob@example.com", "user"),
  User.new("Charlie", "charlie@example.com", "moderator")
]

# Array methods
admin_users = users.select { |user| user.admin? }
user_names = users.map(&:name)
total_users = users.count

# Enumerables
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens = numbers.select(&:even?)
doubled = numbers.map { |n| n * 2 }
sum = numbers.reduce(:+)

# String interpolation
name = "Alice"
age = 30
message = "User #{name} is #{age} years old"

# Regular expressions
email_pattern = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
phone_pattern = /\d{3}-\d{3}-\d{4}/

# Exception handling
def fetch_user_data(user_id)
  raise ArgumentError, "User ID must be positive" if user_id <= 0

  begin
    response = Net::HTTP.get_response(URI("#{API_URL}/users/#{user_id}"))
    JSON.parse(response.body)
  rescue Net::HTTPError => e
    puts "HTTP Error: #{e.message}"
    nil
  rescue JSON::ParserError => e
    puts "JSON Parse Error: #{e.message}"
    nil
  rescue StandardError => e
    puts "Unexpected error: #{e.message}"
    raise
  ensure
    puts "Request completed"
  end
end

# Metaprogramming
class User
  ["admin", "user", "moderator"].each do |role|
    define_method("#{role}?") do
      @role == role
    end
  end
end

# Class methods and instance methods
class Repository
  def self.find(id)
    # Class method
    new.find(id)
  end

  def find(id)
    # Instance method
    @items.find { |item| item.id == id }
  end
end

# Method chaining
result = users
  .select { |u| u.admin? }
  .map(&:name)
  .join(", ")

# Splat operator
def greet_all(*names)
  names.each { |name| puts "Hello, #{name}!" }
end

greet_all("Alice", "Bob", "Charlie")

# Keyword arguments
def create_user(name:, email:, role: "user", **options)
  user = User.new(name, email, role)
  options.each { |key, value| user.send("#{key}=", value) }
  user
end

user = create_user(
  name: "Alice",
  email: "alice@example.com",
  role: "admin",
  active: true
)

# Ranges
(1..10).each { |i| puts i }
(1...10).each { |i| puts i }

# Case statements
def get_role_description(role)
  case role
  when "admin"
    "Administrator with full access"
  when "user"
    "Regular user"
  when "moderator"
    "User with moderation privileges"
  else
    "Unknown role"
  end
end

# Conditional assignment
name ||= "Guest"
email ||= "guest@example.com"

# Safe navigation operator (Ruby 2.3+)
user&.name&.upcase

# Array destructuring
first, second, *rest = users

# Hash destructuring
user_hash = { name: "Alice", email: "alice@example.com", role: "admin" }
name, email = user_hash.values_at(:name, :email)

# Yield and blocks
def with_retry(max_attempts = 3)
  attempts = 0
  begin
    attempts += 1
    yield
  rescue StandardError => e
    retry if attempts < max_attempts
    raise e
  end
end

with_retry(3) do
  fetch_user_data(1)
end

# Singleton methods
alice = User.new("Alice", "alice@example.com")
def alice.special_method
  "This method only exists on this instance"
end

# Main execution
if __FILE__ == $PROGRAM_NAME
  puts "Ruby Demo File"
  puts greet.call("World")
  puts "Total users: #{total_users}"
  puts "Admin users: #{admin_users.map(&:name).join(", ")}"
end

