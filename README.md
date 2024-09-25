# Full-Stack Activity Tracker

This project is a full-stack application for tracking user activities. It consists of a backend API built with Node.js and Express, and a frontend application built with Flutter.

## Project Structure

The project is divided into two main parts:

1. Backend (Node.js + Express + TypeScript)
2. Frontend (Flutter)

## Architecture

This project follows a modular architecture to promote code organization, reusability, and maintainability. We use dependency injection to manage dependencies and ensure that our code is loosely coupled.



### Backend Architecture

The backend follows a modular structure with clear separation of concerns:

1. **Entry Point**: `src/app.ts`
   - Sets up the Express application
   - Configures middleware (cors, body-parser)
   - Initializes and connects controllers

2. **Database**: `src/database.ts`
   - Manages the PostgreSQL connection pool
   - Provides database initialization function

3. **Modules**:
   - Located in `src/modules/`
   - Each module (e.g., auth, user, activity) has its own folder
   - Typical module structure:
     - `controller.ts`: Handles HTTP requests and responses
     - `service.ts`: Contains business logic
     - `repository.ts`: Manages database operations
     - `dtos/`: Data Transfer Objects for input/output
     - `types/`: TypeScript interfaces and types

4. **Types**: `src/@types/`
   - Contains global type definitions
   - Includes base entity interfaces (e.g., `BaseEntity`)

5. **Controllers**:
   - Each controller extends a base controller class
   - Controllers use dependency injection for services
   - Router setup is handled within each controller

6. **Authentication**:
   - JWT-based authentication
   - Passport.js integration for JWT strategy

### Frontend Architecture

The frontend is built with Flutter, following these architectural principles:

1. **Widgets**: UI components following Flutter's widget-based architecture
2. **State Management**: (Specify your chosen state management solution, e.g., Provider, Riverpod, BLoC)
3. **Navigation**: Flutter's built-in navigation system
4. **API Integration**: HTTP requests to interact with the backend API
5. **Platform-specific code**: Separated into respective folders for iOS, Android, Web, and desktop platforms

### API Communication

The backend exposes RESTful endpoints that the frontend consumes:

- `/auth`: Authentication endpoints (login, register)
- `/users`: User management
- `/activities`: Activity tracking and management
- `/user-activities`: User-specific activity operations

### Data Flow

1. User interacts with the Flutter UI
2. Frontend sends HTTP requests to the backend API
3. Backend controller receives the request
4. Controller delegates to the appropriate service
5. Service performs business logic, potentially interacting with the repository
6. Repository executes database operations
7. Results flow back through the service and controller
8. Backend sends HTTP response to the frontend
9. Frontend updates the UI based on the received data


## Getting Started

### Backend Setup

1. Navigate to the `backend` directory:
   ```
   cd backend
   ```

2. Install dependencies:
   ```
   npm install
   ```

3. Set up your environment variables:
   Create a `.env` file in the `backend` directory with the following variables:
   ```
   DB_USER=your_database_user
   DB_PASSWORD=your_database_password
   DB_DATABASE=your_database_name
   ```

4. Run the development server:
   ```
   npm run dev
   ```

The server will start on `http://localhost:3025`.

### Frontend Setup

1. Ensure you have Flutter installed on your system.

2. Navigate to the `frontend` directory:
   ```
   cd frontend
   ```

3. Get Flutter dependencies:
   ```
   flutter pub get
   ```

4. Run the app:
   ```
   flutter run
   ```
