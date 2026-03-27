Hotel Reservation API – BDD Test Suite

Overview

This repository contains a comprehensive **Behavior-Driven Development (BDD)** test suite for a hotel reservation platform based on the **Restful Booker API**.

The suite validates complete booking workflows including:

* Room discovery
* Availability checks
* Booking creation
* Retrieval
* Update
* Cancellation
* End-to-End lifecycle

The tests are designed using **Gherkin syntax** and aligned with real-world API behavior, covering **positive, negative, edge, and security scenarios**.

---

Objectives

* Validate API functionality using BDD approach
* Ensure end-to-end booking lifecycle correctness
* Verify data consistency across operations
* Test boundary conditions and edge cases
* Validate role-based access control (user vs admin)

---

Test Coverage

Authentication

* Admin login validation
* Invalid credential handling
* Token-based authorization checks

Room Module

* Room discovery
* Room details validation
* Availability checks with date combinations

Booking Module

* Booking creation with valid and invalid inputs
* Booking retrieval using booking ID and room ID
* Booking update with validation rules
* Booking cancellation and idempotency checks

End-to-End Flow

* Complete booking lifecycle:

  * Availability → Create → Retrieve → Update → Cancel → Verify deletion

---

Test Design Techniques

The suite incorporates:

* **Boundary Value Analysis (BVA)**
* **Equivalence Partitioning**
* **Negative Testing**
* **Edge Case Validation**
* **Data-driven testing (Scenario Outline)**
* **Idempotency validation**
* **Role-based access testing**

---

roject Structure

```
features/
  auth/
    auth-admin-login.feature
  rooms/
    room-discovery.feature
    room-availability.feature
  booking/
    booking-creation.feature
    booking-retrieval.feature
    booking-update.feature
    booking-cancellation.feature
    booking-reporting.feature
  security/
    booking-summary-security.feature
  e2e/
    booking-lifecycle-e2e.feature
```

---

Tags Used

| Tag          | Purpose                        |
| ------------ | ------------------------------ |
| @positive    | Valid scenarios                |
| @negative    | Invalid scenarios              |
| @edge        | Edge cases                     |
| @security    | Authorization & access control |
| @consistency | Data integrity validation      |
| @e2e         | End-to-end flow                |
| @critical    | High-priority scenarios        |

---

Role-Based Testing Strategy

| Operation            | Role  |
| -------------------- | ----- |
| Room discovery       | User  |
| Availability check   | User  |
| Booking creation     | User  |
| Booking retrieval    | User  |
| Booking update       | Admin |
| Booking cancellation | Admin |

---


Author

**Naveen**

---
