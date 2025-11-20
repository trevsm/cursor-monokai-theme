#!/bin/bash
# Shell Script Demo File

# Variables
API_URL="https://api.example.com"
MAX_RETRIES=3
TIMEOUT=5
DEBUG=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
greet_user() {
    local name=$1
    echo "Hello, $name!"
}

calculate_total() {
    local total=0
    for price in "$@"; do
        total=$((total + price))
    done
    echo $total
}

# Error handling
fetch_user_data() {
    local user_id=$1
    local url="${API_URL}/users/${user_id}"
    
    if [ -z "$user_id" ]; then
        echo -e "${RED}Error: User ID is required${NC}" >&2
        return 1
    fi
    
    if command -v curl &> /dev/null; then
        curl -s "$url" || {
            echo -e "${RED}Failed to fetch user data${NC}" >&2
            return 1
        }
    else
        echo -e "${YELLOW}Warning: curl not found${NC}" >&2
        return 1
    fi
}

# Conditional logic
check_status() {
    local status=$1
    
    if [ "$status" = "active" ]; then
        echo -e "${GREEN}Status is active${NC}"
    elif [ "$status" = "inactive" ]; then
        echo -e "${RED}Status is inactive${NC}"
    else
        echo -e "${YELLOW}Unknown status: $status${NC}"
    fi
}

# Loops
process_users() {
    local users=("Alice" "Bob" "Charlie")
    
    for user in "${users[@]}"; do
        echo "Processing user: $user"
        greet_user "$user"
    done
}

# Arrays
declare -a fruits=("apple" "banana" "orange")
declare -A user_roles=(
    ["Alice"]="admin"
    ["Bob"]="user"
    ["Charlie"]="moderator"
)

# Case statement
get_role_description() {
    local role=$1
    
    case $role in
        admin)
            echo "Administrator with full access"
            ;;
        user)
            echo "Regular user"
            ;;
        moderator)
            echo "User with moderation privileges"
            ;;
        *)
            echo "Unknown role"
            ;;
    esac
}

# File operations
create_backup() {
    local file=$1
    local backup="${file}.bak"
    
    if [ -f "$file" ]; then
        cp "$file" "$backup"
        echo -e "${GREEN}Backup created: $backup${NC}"
    else
        echo -e "${RED}File not found: $file${NC}" >&2
        return 1
    fi
}

# Main execution
main() {
    echo -e "${BLUE}=== Cursor Monokai Theme Demo ===${NC}"
    
    # Function calls
    greet_user "World"
    
    # Calculations
    total=$(calculate_total 10 20 30)
    echo "Total: $total"
    
    # Process users
    process_users
    
    # Check status
    check_status "active"
    
    # Get role description
    get_role_description "admin"
    
    # Array access
    echo "First fruit: ${fruits[0]}"
    echo "Alice's role: ${user_roles[Alice]}"
    
    # Debug mode
    if [ "$DEBUG" = true ]; then
        echo "Debug mode enabled"
        set -x
    fi
}

# Trap signals
trap 'echo -e "\n${YELLOW}Script interrupted${NC}"; exit 1' INT TERM

# Run main function
main "$@"

