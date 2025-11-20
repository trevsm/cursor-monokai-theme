// Rust Demo File
use std::collections::HashMap;
use std::fmt;
use std::error::Error;

// Constants
const API_URL: &str = "https://api.example.com";
const MAX_RETRIES: u32 = 3;
const TIMEOUT: u64 = 5;

// Structs
#[derive(Debug, Clone)]
struct User {
    id: u32,
    name: String,
    email: String,
    role: UserRole,
}

#[derive(Debug, Clone, PartialEq)]
enum UserRole {
    Admin,
    User,
    Moderator,
}

// Traits
trait DisplayName {
    fn get_display_name(&self) -> String;
}

impl DisplayName for User {
    fn get_display_name(&self) -> String {
        format!("{} <{}>", self.name, self.email)
    }
}

// Error handling
#[derive(Debug)]
enum ApiError {
    NotFound,
    NetworkError(String),
    ParseError(String),
}

impl fmt::Display for ApiError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            ApiError::NotFound => write!(f, "Resource not found"),
            ApiError::NetworkError(msg) => write!(f, "Network error: {}", msg),
            ApiError::ParseError(msg) => write!(f, "Parse error: {}", msg),
        }
    }
}

impl Error for ApiError {}

// Functions
fn greet_user(name: &str) -> String {
    format!("Hello, {}!", name)
}

fn calculate_total(items: &[f64]) -> f64 {
    items.iter().sum()
}

// Result type for error handling
fn fetch_user_data(user_id: u32) -> Result<User, ApiError> {
    if user_id == 0 {
        return Err(ApiError::NotFound);
    }
    
    Ok(User {
        id: user_id,
        name: "Alice".to_string(),
        email: "alice@example.com".to_string(),
        role: UserRole::Admin,
    })
}

// Option type
fn find_user_by_id(users: &[User], id: u32) -> Option<&User> {
    users.iter().find(|user| user.id == id)
}

// Ownership and borrowing
fn process_users(users: &[User]) -> Vec<String> {
    users.iter()
        .map(|user| user.get_display_name())
        .collect()
}

// Generics
fn find<T: PartialEq>(slice: &[T], value: &T) -> Option<usize> {
    slice.iter().position(|x| x == value)
}

// Closures
fn filter_admin_users(users: Vec<User>) -> Vec<User> {
    users.into_iter()
        .filter(|user| user.role == UserRole::Admin)
        .collect()
}

// Pattern matching
fn get_role_description(role: &UserRole) -> &str {
    match role {
        UserRole::Admin => "Administrator with full access",
        UserRole::User => "Regular user",
        UserRole::Moderator => "User with moderation privileges",
    }
}

// Struct methods
impl User {
    fn new(id: u32, name: String, email: String, role: UserRole) -> Self {
        Self { id, name, email, role }
    }

    fn is_admin(&self) -> bool {
        self.role == UserRole::Admin
    }

    fn update_email(&mut self, new_email: String) {
        self.email = new_email;
    }
}

// Lifetimes
fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
        x
    } else {
        y
    }
}

// Iterator chains
fn process_user_names(users: &[User]) -> Vec<String> {
    users.iter()
        .filter(|u| u.is_admin())
        .map(|u| u.name.clone())
        .collect()
}

// Main function
fn main() -> Result<(), Box<dyn Error>> {
    let users = vec![
        User::new(1, "Alice".to_string(), "alice@example.com".to_string(), UserRole::Admin),
        User::new(2, "Bob".to_string(), "bob@example.com".to_string(), UserRole::User),
        User::new(3, "Charlie".to_string(), "charlie@example.com".to_string(), UserRole::Moderator),
    ];

    // Pattern matching with Result
    match fetch_user_data(1) {
        Ok(user) => {
            println!("{}", greet_user(&user.name));
            println!("Display name: {}", user.get_display_name());
            println!("Role: {}", get_role_description(&user.role));
        }
        Err(e) => eprintln!("Error: {}", e),
    }

    // Using Option
    if let Some(user) = find_user_by_id(&users, 2) {
        println!("Found user: {}", user.name);
    }

    // Iterator usage
    let admin_names: Vec<String> = process_user_names(&users);
    println!("Admin users: {:?}", admin_names);

    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_greet_user() {
        assert_eq!(greet_user("Alice"), "Hello, Alice!");
    }

    #[test]
    fn test_calculate_total() {
        assert_eq!(calculate_total(&[1.0, 2.0, 3.0]), 6.0);
    }
}

