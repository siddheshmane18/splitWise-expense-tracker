
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

## Project Status

This is an educational prototype built while learning
traditional Spring MVC, JSP, JDBC, and PostgreSQL.

The current version uses a predefined demo user.
Authentication and collaborative expense-splitting features
are planned for later development.

## Future Improvements

- Group creation and member management
- Shared expense splitting
- Group balances and settlements
- Authentication and authorization
- Migration to Spring Boot and React
