Ouroboros EV

Ouroboros EV is a database-driven Electric Vehicle (EV) rental platform designed as a peer-to-peer mobility marketplace. It connects EV owners with renters seeking short-term, sustainable transportation options.

This project was developed as part of CS157.

Overview

Ouroboros EV allows EV owners to list their vehicles and earn income from underutilized assets, while renters gain access to eco-friendly transportation without long-term commitments.

The system supports three main user roles:

Owners – list and manage vehicles

Renters – search and rent vehicles

Admins – manage users and listings

Features
Owner Features

Create and manage account

Register EVs with details (model, year, seats, features)

Update or delete vehicle listings

View dashboard of registered vehicles and rental status

Renter Features

Search EVs with filters:

Make, model, year

Price range

Availability

Number of seats & features

View vehicle details (price, specs, availability, reviews)

Make, modify, or cancel reservations

Leave reviews and ratings after rentals

Admin Features

Manage users (view, suspend, delete, reset passwords)

Manage vehicle listings (remove fraudulent or invalid entries)

Oversee bookings and system activity

System Architecture

The system follows a 3-tier architecture:

Frontend (Client):

HTML, CSS, JavaScript

Backend (Server):

Java (JSP) running on Apache Tomcat

Database:

MySQL

The architecture includes:

Browser client → Web server → Database server
(as shown in the system diagram on page 2 of the proposal)

Tech Stack

Languages: Java, SQL, JavaScript

Frontend: HTML, CSS

Backend: JSP (Apache Tomcat)

Database: MySQL

Tools:

MySQL Workbench

Apache Tomcat 9

Windows / macOS development environments

Security Features

Encrypted user data (AES-128 / hashing)

Input validation to prevent invalid data

Parameterized queries to prevent SQL injection

Unique email enforcement across accounts

Role-based access control

User Interface

Card-based vehicle listing UI

Filterable search system

Dynamic pricing based on rental duration

Owner dashboard for vehicle management

Getting Started
Prerequisites

Java (JDK 8+)

Apache Tomcat 9+

MySQL Server 8+

Installation

Clone the repository:

git clone https://github.com/your-username/ouroboros-ev.git
cd ouroboros-ev

Set up the database:

Create a MySQL database

Import provided SQL schema (if available)

Configure database connection:

Update connection settings in the project

Deploy on Tomcat:

Add project to Tomcat server

Start server and open in browser

Functional Highlights

Prevents double bookings (no overlapping reservations)

Real-time availability filtering

Role-specific access control

Persistent storage of users, vehicles, and reservations

Team

Ryder Sabale

Vance Nguyen

Guadalupe Carrillo Vega

