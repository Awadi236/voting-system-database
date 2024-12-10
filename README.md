Voting System Database Schema and Data Management
This script sets up a relational database system for a voting platform, including schema definitions, constraints, and sample data insertion. It also includes permissions setup, view creation, and backup operations. Below is a breakdown of its main features:

1. Database Setup
Database creation: Initializes the voting_sys database.
Table definitions:
Elector: Stores voter details with unique constraints on elector_id and elector_email.
Elector Address: Links electors to their addresses with primary and foreign key constraints.
Candidate: Holds candidate information, with unique constraints on candidate_id and additional columns for profession and gender.
Candidate Address: Records candidate addresses with composite primary keys.
Vote: Tracks votes with relationships to elector and candidate.
Committee: Defines committees overseeing the voting process.
Committee Members: Stores committee member details.
Supervisor: Links members, committees, and candidates with role descriptions.
Candidate Contact: Contains candidate contact numbers.
2. Constraints and Integrity
Primary keys, foreign keys, and unique constraints ensure data integrity.
Constraints enforce logical rules (e.g., candidate_id > 0).
Default values for certain columns (e.g., gender for candidates).
3. Views and Procedures
Views:
e_view: Provides a detailed view of electors and their votes.
c_view: Displays candidate details along with their supervisors and committees.
Stored Procedures:
get_e_info: Fetches elector-vote information.
get_c_info: Retrieves candidate and supervisor details.
4. Permissions
User roles and permissions:
elec1: Read-only access to e_view.
cand1: Read-only access to candidate-related tables.
admin2: Full access to elector and candidate data.
5. Sample Data
Inserts records for electors, candidates, votes, addresses, committees, and supervisors.
Demonstrates various relational links (e.g., candidate addresses, elector addresses).
6. Data Management
Data backups and restores:
Full and differential backups using SQL Server's backup features.
Restoration process outlined.
Data modification:
Updates (e.g., changing elector IDs).
Deletions and re-insertions of data for testing.
7. Example Queries
Basic retrieval queries for all tables.
Joins to extract meaningful insights from related tables (e.g., linked elector and candidate data).
Highlights
This project demonstrates:

Robust schema design for a relational database.
Practical use of constraints to maintain data accuracy.
Comprehensive CRUD operations with sample data.
Security and permissions management.
Data management strategies like backups and restores.
Useful views and procedures to simplify data access.
