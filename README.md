# Authentication Microservice

This microservice is designed to handle authentication and user management for applications. It provides endpoints for registration, login, and user profile management.

## Architecture Overview

The microservice is built using Ruby on Rails, leveraging MVC architecture to ensure separation of concerns. It utilizes devise for secure authentication and communicates with a PostgreSQL database for persistent storage of user data.

### Components

- **Controllers**: Handle incoming HTTP requests and respond with the appropriate HTTP responses.
- **Models**: Represent the data structure and contain business logic.
- **Database**: PostgreSQL is used for storing user credentials and profile information.
- **Docker**: Containerization of the application for easy deployment and scalability.

## Prerequisites

- Docker and Docker Compose installed on your machine.
- Basic knowledge of Ruby on Rails and Docker.

## Getting Started

To get the microservice running on your local machine, follow these steps:

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Naimuru/auth_ms.git
   cd auth_ms

2. **Build the image**
This command builds the docker image.

   ```bash
   docker build -t auth_ms .

2. **Build the Docker Containers**
This command builds the Docker images and starts the containers, including the Rails application and the PostgreSQL database.

    ```bash
    docker-compose up --build

3. **Migrate the db**
Run in another terminal this command since we need to migrate the db.

    ```bash
    docker-compose exec web bin/rails db:migrate
    
## Testing the Microservice

To test the functionality of the microservice, you can use Postman or any similar API testing tool.

- Register a New User
POST /api/v1/sign_upgit add README.md
 with a JSON body containing the user's email and password:

```bash
{
  "user": {
    "email": "test9@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```
- Login
POST /api/v1/sign_in with the user's credentials to receive a JWT token:
```bash
{
  "user": {
    "email": "test9@example.com",
    "password": "password123"
  }
}
    ```bash
    {
    "user": {
        "email": "test9@example.com",
        "password": "password123",
        "password_confirmation": "password123"
    }
    }
```
- Login
POST /api/v1/sign_in with the user's credentials to receive a JWT token:

- Login
POST request - Endpoint: /api/v1/sign_in | with the user's credentials.

   ```bash
   {
     "user": {
       "email": "test9@example.com",
       "password": "password123"
     }
   }

## Testing the Microservice with GraphiQL

To test through GraphiQL, please consider the following mutations:

- Signup
```bash
mutation SignupUser($email: String!, $password: String!, $nickname: String!) {
  signup(email: $email, password: $password, nickname: $nickname) {
    __typename
    ... on AuthToken {
      token 
      user {
        id
        email
        nickname
        keyIdAuth
      }
    }
    ... on AuthError {
      message 
    }
  }
}
```
Variables:
```bash
   {
     "user": {
       "email": "test@example.com",
       "password": "password123",
       "nickname": "yournickname" 
     }
   }
```

- Login
```bash
mutation LoginUser($email: String!, $password: String!) {
  login(email: $email, password: $password) {
    __typename
    ... on AuthToken {
      token
      user {
        id
        email
        nickname
        keyIdAuth
      }
    }
    ... on AuthError {
      message 
    }
  }
}
```
Variables:
```bash
{
  "email": "test@example.com",
  "password": "password123" 
}
```
