
# SplitWise — Collaborative Expense Tracker

A Java web application for recording personal expenses and
eventually managing shared expenses between friends.

## Current Features

- Add and view personal expenses
- Edit and delete expenses
- PostgreSQL database persistence
- Dashboard with expense count and total spending
- Spring MVC controllers and JSP views
- JDBC data access using JdbcTemplate

## Technology Stack

- Java 21
- Spring MVC
- JSP and JSTL
- PostgreSQL
- JDBC and JdbcTemplate
- Maven
- Apache Tomcat

## Architecture

Controller → Service → DAO → PostgreSQL

JSP pages provide the user interface. Spring MVC controllers
handle requests, service classes implement business rules,
and DAO classes perform database operations.

## Setup

1. Install Java 21, Maven, PostgreSQL, and a compatible Tomcat server.
2. Create a PostgreSQL database named `splitwise_db`.
3. Execute the SQL schema provided in the project.
4. Configure your local database credentials.
5. Reload Maven dependencies and build the project.
6. Deploy the generated WAR file to Tomcat.
7. Open the application's dashboard in your browser.

## Database Setup

SplitWise uses **PostgreSQL** as its relational database for storing personal expenses, users, expense groups, group members, shared expenses, and individual expense shares.

### Database Technology

- **Database:** PostgreSQL
- **Database name:** `splitWise_db`
- **Java database access:** JDBC
- **Spring integration:** Spring `JdbcTemplate`
- **Database driver:** PostgreSQL JDBC Driver

### Database Schema

The database contains the following core tables:

| Table | Description |
|---|---|
| `users` | Stores user information, including name and email. |
| `personal_expenses` | Stores personal expenses belonging to individual users. |

### 1. Users Table

| Column | Data Type | Description |
|---|---|---|
| `id` | BIGINT | Unique user identifier and primary key |
| `full_name` | VARCHAR(100) | Full name of the user |
| `email` | VARCHAR(255) | User's email address |
| `created_at` | TIMESTAMP | Date and time when the record was created |

### 2. Personal Expenses Table

| Column | Data Type | Description |
|---|---|---|
| `id` | BIGINT | Unique expense identifier and primary key |
| `user_id` | BIGINT | ID of the user who owns the expense |
| `title` | VARCHAR(120) | Expense title, such as Lunch or Transport |
| `amount` | NUMERIC(12,2) | Expense amount, which must be greater than zero |
| `category` | VARCHAR(50) | Expense category, such as Food, Shopping, or Education |
| `expense_date` | DATE | Date on which the expense occurred |
| `notes` | TEXT | Optional additional details |
| `created_at` | TIMESTAMP | Date and time when the expense record was created |

## Project Status

This is an educational prototype built while learning
traditional Spring MVC, JSP, JDBC, and PostgreSQL.

The current version uses a predefined demo user.
Authentication and collaborative expense-splitting features
are planned for later development.
<img width="1920" height="1014" alt="Screenshot (363)" src="https://github.com/user-attachments/assets/41b6dfd1-13f4-4a4c-98be-a0074a81e343" />
<img width="1920" height="1017" alt="Screenshot (364)" src="https://github.com/user-attachments/assets/19fff39f-cee8-4ce9-84e6-3bbc665cf2a8" />


## Future Improvements

- Group creation and member management
- Shared expense splitting
- Group balances and settlements
- Authentication and authorization
- Migration to Spring Boot and React
