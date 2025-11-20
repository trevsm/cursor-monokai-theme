// @ts-nocheck - Demo file for syntax highlighting only
// TypeScript Demo File
interface User {
  id: number;
  name: string;
  email: string;
  role: "admin" | "user" | "moderator";
  createdAt?: Date;
}

type Status = "active" | "inactive" | "pending";

interface ApiResponse<T> {
  data: T;
  status: number;
  message: string;
}

// Generic functions
function fetchData<T>(url: string): Promise<ApiResponse<T>> {
  return fetch(url)
    .then((response) => response.json())
    .then((data) => ({
      data,
      status: 200,
      message: "Success",
    }));
}

// Classes with generics
class Repository<T> {
  private items: T[] = [];

  add(item: T): void {
    this.items.push(item);
  }

  find(predicate: (item: T) => boolean): T | undefined {
    return this.items.find(predicate);
  }

  getAll(): T[] {
    return [...this.items];
  }
}

// Enums
enum UserRole {
  Admin = "admin",
  User = "user",
  Moderator = "moderator",
}

// Type guards
function isUser(obj: any): obj is User {
  return obj && typeof obj.id === "number" && typeof obj.name === "string";
}

// Utility types
type PartialUser = Partial<User>;
type UserEmail = Pick<User, "email">;
type UserWithoutId = Omit<User, "id">;

// Function overloads
function process(value: string): string;
function process(value: number): number;
function process(value: string | number): string | number {
  if (typeof value === "string") {
    return value.toUpperCase();
  }
  return value * 2;
}

// Decorators
function log(target: any, propertyKey: string, descriptor: PropertyDescriptor) {
  const originalMethod = descriptor.value;
  descriptor.value = function (...args: any[]) {
    console.log(`Calling ${propertyKey} with`, args);
    return originalMethod.apply(this, args);
  };
}

class Service {
  @log
  processData(data: string): string {
    return data.trim();
  }
}

// Tuples
type Point = [number, number];
type UserTuple = [number, string, string];

const point: Point = [10, 20];
const userTuple: UserTuple = [1, "Alice", "alice@example.com"];

// Union and intersection types
type ID = string | number;
type AdminUser = User & { permissions: string[] };

// Conditional types
type NonNullable<T> = T extends null | undefined ? never : T;

// Mapped types
type ReadonlyUser = {
  readonly [K in keyof User]: User[K];
};

// Export
export { User, ApiResponse, Repository, UserRole, Service };
