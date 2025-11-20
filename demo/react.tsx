// React TypeScript Demo File
// @ts-ignore - Demo file for syntax highlighting only
import React, { useState, useEffect, useCallback, useMemo } from "react";
// @ts-ignore - Demo file for syntax highlighting only
import { connect, useSelector, useDispatch } from "react-redux";

// Types
interface User {
  id: number;
  name: string;
  email: string;
}

interface Props {
  userId: number;
  onUserSelect?: (user: User) => void;
}

// Functional Component with Hooks
const UserProfile: React.FC<Props> = ({ userId, onUserSelect }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);

  const dispatch = useDispatch();
  const theme = useSelector((state: any) => state.theme);

  // useEffect hook
  useEffect(() => {
    const fetchUser = async () => {
      setLoading(true);
      try {
        const response = await fetch(`/api/users/${userId}`);
        const data = await response.json();
        setUser(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : "Failed to fetch user");
      } finally {
        setLoading(false);
      }
    };

    fetchUser();
  }, [userId]);

  // useCallback hook
  const handleClick = useCallback(() => {
    if (user && onUserSelect) {
      onUserSelect(user);
    }
  }, [user, onUserSelect]);

  // useMemo hook
  const displayName = useMemo(() => {
    return user ? `${user.name} (${user.email})` : "Loading...";
  }, [user]);

  if (loading) return <div className="spinner">Loading...</div>;
  if (error) return <div className="error">{error}</div>;
  if (!user) return null;

  return (
    <div className={`user-profile theme-${theme}`}>
      <h2>{displayName}</h2>
      <button onClick={handleClick}>Select User</button>
    </div>
  );
};

// Class Component
class UserList extends React.Component<Props, { users: User[] }> {
  constructor(props: Props) {
    super(props);
    // @ts-ignore - Demo file for syntax highlighting only
    this.state = {
      users: [],
    };
  }

  componentDidMount() {
    this.fetchUsers();
  }

  fetchUsers = async () => {
    const response = await fetch("/api/users");
    const users = await response.json();
    // @ts-ignore - Demo file for syntax highlighting only
    this.setState({ users });
  };

  render() {
    // @ts-ignore - Demo file for syntax highlighting only
    const { users } = this.state;
    return (
      <ul className="user-list">
        {users.map((user) => (
          <li key={user.id}>
            {user.name} - {user.email}
          </li>
        ))}
      </ul>
    );
  }
}

// Custom Hook
function useUser(userId: number) {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then((res) => res.json())
      .then((data) => {
        setUser(data);
        setLoading(false);
      });
  }, [userId]);

  return { user, loading };
}

// Higher-Order Component
function withAuth<P extends object>(Component: React.ComponentType<P>) {
  return (props: P) => {
    const isAuthenticated = useSelector(
      (state: any) => state.auth.isAuthenticated
    );

    if (!isAuthenticated) {
      return <div>Please log in</div>;
    }

    return <Component {...props} />;
  };
}

// Context
const UserContext = React.createContext<User | null>(null);

const UserProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [user, setUser] = useState<User | null>(null);

  return <UserContext.Provider value={user}>{children}</UserContext.Provider>;
};

// JSX with conditional rendering
const Dashboard: React.FC = () => {
  const users = useUser(1);

  return (
    <div className="dashboard">
      <header>
        <h1>User Dashboard</h1>
      </header>
      <main>
        {users.loading ? (
          <div>Loading...</div>
        ) : users.user ? (
          <UserProfile userId={users.user.id} />
        ) : (
          <div>No user found</div>
        )}
      </main>
      <footer>
        <p>&copy; 2024 My App</p>
      </footer>
    </div>
  );
};

export default Dashboard;
export { UserProfile, UserList, useUser, withAuth, UserProvider };
