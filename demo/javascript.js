// JavaScript Demo File
"use strict";

// Variables and constants
const API_URL = "https://api.example.com";
let userCount = 0;
var isActive = true;

// Functions
function greetUser(name) {
  return `Hello, ${name}!`;
}

const calculateTotal = (items) => {
  return items.reduce((sum, item) => sum + item.price, 0);
};

// Async/await
async function fetchUserData(userId) {
  try {
    const response = await fetch(`${API_URL}/users/${userId}`);
    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Error fetching user:", error);
    throw error;
  }
}

// Classes
class User {
  constructor(name, email) {
    this.name = name;
    this.email = email;
    this.createdAt = new Date();
  }

  getDisplayName() {
    return `${this.name} <${this.email}>`;
  }

  static fromJSON(json) {
    return new User(json.name, json.email);
  }
}

// Arrays and objects
const users = [
  { id: 1, name: "Alice", role: "admin" },
  { id: 2, name: "Bob", role: "user" },
  { id: 3, name: "Charlie", role: "moderator" },
];

const config = {
  api: {
    baseUrl: API_URL,
    timeout: 5000,
    retries: 3,
  },
  features: {
    darkMode: true,
    notifications: false,
  },
};

// Template literals
const message = `
  Welcome to the application!
  Current users: ${userCount}
  Status: ${isActive ? "Active" : "Inactive"}
`;

// Regular expressions
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const phoneRegex = /\d{3}-\d{3}-\d{4}/;

// Destructuring
const { name, email } = users[0];
const [first, second, ...rest] = users;

// Arrow functions and higher-order functions
const activeUsers = users.filter((user) => user.role !== "inactive");
const userNames = users.map((user) => user.name);
const totalUsers = users.reduce((count, user) => count + 1, 0);

// Promises
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Operation completed");
  }, 1000);
});

promise
  .then((result) => console.log(result))
  .catch((error) => console.error(error));

// Export/import (ES6 modules)
export default User;
export { greetUser, calculateTotal, fetchUserData };
