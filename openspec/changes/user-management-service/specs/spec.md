# Specification: User Management Service

## Purpose
To provide secure, reliable, and compliant user management capabilities for the banking web application, including registration, authentication, profile management, and integration with onboarding and analytics systems.

---

### Requirement 1: User Registration and Management
#### Scenario: Register a New User
- **Given** a valid registration payload,
- **When** `POST /api/v1/users` is called,
- **Then** the system SHALL create a new user, persist it in PostgreSQL, and return a 201 response.

#### Scenario: Retrieve User Details
- **Given** a valid user ID and authentication token,
- **When** `GET /api/v1/users/{id}` is called,
- **Then** the system SHALL return user details if the user exists and the requester is authorized.

#### Scenario: Update User Profile
- **Given** a valid update payload and authentication,
- **When** `PUT /api/v1/users/{id}` is called,
- **Then** the system SHALL update the user profile and return a 200 response.

#### Scenario: Delete User
- **Given** a valid user ID and authorization,
- **When** `DELETE /api/v1/users/{id}` is called,
- **Then** the system SHALL delete the user and return a 204 response.

---

### Requirement 2: Authentication and Session Management
#### Scenario: User Login
- **Given** valid credentials,
- **When** `POST /api/v1/auth/login` is called,
- **Then** the system SHALL authenticate the user, issue a JWT token, and return a 200 response.

#### Scenario: Token Validation
- **Given** a protected endpoint,
- **When** a request is made with a valid JWT,
- **Then** the system SHALL authorize the request; otherwise, return 401/403.

---

### Requirement 3: Security and Compliance
- All sensitive data SHALL be encrypted in transit and at rest.
- OAuth2 and JWT SHALL be used for authentication and session management.
- The service SHALL comply with PDPL and ISO 27001 for data protection.
- Error responses SHALL use standard HTTP codes and custom error formats.

---

### Requirement 4: Integration and Extensibility
- The service SHALL integrate with Onboarding Service for new user flows.
- The service SHALL publish user events to Analytics Service via Kafka.
- The service SHALL support extension for additional identity providers.

---

## Technologies and Runtime Stack
- **Languages/Frameworks**: Spring Boot (Java), Node.js (for BFF), PostgreSQL, Redis, Kafka.
- **Security**: OAuth2, JWT, CSRF protection.
- **Deployment**: Docker, Kubernetes, CI/CD via GitHub Actions.

---

## Components
- **UserManagementService**: Handles business logic for user operations.
- **UserRepository**: Data access for user entities.
- **UserVerificationService**: Manages verification codes and flows.
- **Controllers/Handlers**: Expose REST endpoints.
- **Integration Clients**: For Onboarding, Analytics, Notification services.

---

## APIs (from ApiSpec)
- `GET /api/v1/users` — List users
- `GET /api/v1/users/{id}` — Get user details
- `POST /api/v1/users` — Create user
- `PUT /api/v1/users/{id}` — Update user
- `DELETE /api/v1/users/{id}` — Delete user
- `POST /api/v1/auth/login` — Authenticate user
- `GET /health` — Health check

### Authentication
- Bearer token (JWT) in `Authorization` header.

### Error Handling
- Standard HTTP codes (400, 401, 403, 404, 500).
- Custom error response: `{ "error": string, "message": string, "statusCode": integer }`

---

## Data Models
- **User**: `{ id: string, name: string, email: string, createdAt: datetime }`
- **ErrorResponse**: `{ error: string, message: string, statusCode: integer }`
- **Pagination**: `{ totalItems: integer, totalPages: integer, currentPage: integer, itemsPerPage: integer }`
- **UserDTO, VerificationRequest, VerificationResponse, UserCreatedEvent** (see C4 for structure).

---

## Interactions with Dependencies
- **Onboarding Service**: REST API for onboarding flows.
- **Analytics Service**: Publishes events via Kafka.
- **Notification Service**: (Indirect) for OTP/verification.
- **Redis**: Session caching.
- **PostgreSQL**: User and session persistence.

### Protocols
- REST (HTTP/HTTPS) for APIs.
- Kafka for event streaming.

### Error and Retry
- Retry on transient errors (network, 5xx).
- Circuit breaker for downstream service failures.

---

## Key Flows

### User Registration Flow (Example)
1. User submits registration via frontend.
2. BFF forwards to User Management Service (`POST /api/v1/users`).
3. Service validates and persists user.
4. Sends verification code via Notification Service.
5. Publishes `UserCreatedEvent` to Analytics Service (Kafka).
6. Returns success response to frontend.

### User Login Flow
1. User submits credentials to BFF.
2. BFF calls `POST /api/v1/auth/login`.
3. Service authenticates and issues JWT.
4. JWT returned to frontend for session management.

---

## TODO
- Clarify additional user roles and permissions model if required.
- Specify payloads for all endpoints in OpenAPI format if needed.

---