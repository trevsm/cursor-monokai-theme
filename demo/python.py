# Python Demo File
"""Module docstring describing the purpose of this file."""

from typing import List, Dict, Optional, Union, Callable
from dataclasses import dataclass
from enum import Enum
import asyncio
import json

# Constants
API_URL = "https://api.example.com"
MAX_RETRIES = 3
TIMEOUT = 5.0


# Enums
class UserRole(Enum):
    ADMIN = "admin"
    USER = "user"
    MODERATOR = "moderator"


# Dataclasses
@dataclass
class User:
    id: int
    name: str
    email: str
    role: UserRole
    created_at: Optional[str] = None

    def get_display_name(self) -> str:
        return f"{self.name} <{self.email}>"

    @classmethod
    def from_dict(cls, data: Dict) -> "User":
        return cls(
            id=data["id"],
            name=data["name"],
            email=data["email"],
            role=UserRole(data["role"]),
        )


# Type hints
def greet_user(name: str) -> str:
    """Greet a user by name."""
    return f"Hello, {name}!"


def calculate_total(items: List[Dict[str, float]]) -> float:
    """Calculate the total price of items."""
    return sum(item.get("price", 0.0) for item in items)


# Async functions
async def fetch_user_data(user_id: int) -> Dict:
    """Fetch user data from API."""
    try:
        # Simulated API call
        await asyncio.sleep(0.1)
        return {"id": user_id, "name": "Alice", "email": "alice@example.com"}
    except Exception as e:
        print(f"Error fetching user: {e}")
        raise


# Generators
def fibonacci(n: int):
    """Generate Fibonacci sequence."""
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b


# List comprehensions
squares = [x**2 for x in range(10)]
even_squares = [x**2 for x in range(10) if x % 2 == 0]

# Dictionary comprehensions
user_dict = {user.id: user.name for user in users if user.role == UserRole.ADMIN}


# Context managers
class DatabaseConnection:
    def __enter__(self):
        print("Connecting to database...")
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Closing database connection...")
        return False


# Decorators
def log_calls(func: Callable) -> Callable:
    def wrapper(*args, **kwargs):
        print(f"Calling {func.__name__} with args: {args}, kwargs: {kwargs}")
        return func(*args, **kwargs)

    return wrapper


@log_calls
def process_data(data: str) -> str:
    return data.strip().upper()


# Exception handling
try:
    result = 10 / 0
except ZeroDivisionError as e:
    print(f"Division by zero: {e}")
except Exception as e:
    print(f"Unexpected error: {e}")
finally:
    print("Cleanup complete")

# F-strings
name = "Alice"
age = 30
message = f"User {name} is {age} years old"

# Lambda functions
add = lambda x, y: x + y
multiply = lambda x, y: x * y

# Filter, map, reduce
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
evens = list(filter(lambda x: x % 2 == 0, numbers))
doubled = list(map(lambda x: x * 2, numbers))

# Sample data
users = [
    User(1, "Alice", "alice@example.com", UserRole.ADMIN),
    User(2, "Bob", "bob@example.com", UserRole.USER),
    User(3, "Charlie", "charlie@example.com", UserRole.MODERATOR),
]

# Main guard
if __name__ == "__main__":
    print("Python demo file")
    print(greet_user("World"))
    print(f"Total: {calculate_total([{'price': 10.5}, {'price': 20.0}])}")
