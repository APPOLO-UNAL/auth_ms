# Authentication Microservice

This microservice is designed to handle authentication and user management for applications. It provides endpoints for registration, login, and user profile management.

## Architecture Overview

The microservice is built using Ruby on Rails, leveraging MVC architecture to ensure separation of concerns. It utilizes JWT (JSON Web Tokens) for secure authentication and communicates with a PostgreSQL database for persistent storage of user data.

### Components

- **Controllers**: Handle incoming HTTP requests and respond with the appropriate HTTP responses.
- **Models**: Represent the data structure and contain business logic.
- **Views**: (If applicable) Serve the HTML content (not primarily used in this API-centric service).
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

2. **Build the Docker Containers**
This command builds the Docker images and starts the containers, including the Rails application and the PostgreSQL database.

    ```bash
    docker-compose up --build
    

3. **Database Setup**
After the containers are up, set up the database with the following command:

    docker-compose run web rake db:create db:migrate
    

## Testing the Microservice

To test the functionality of the microservice, you can use Postman or any similar API testing tool.

- Register a New User
POST /api/v1/sign_upgit add README.md
 with a JSON body containing the user's email and password.
- Login
POST /api/v1/sign_in with the user's credentials to receive a JWT token.