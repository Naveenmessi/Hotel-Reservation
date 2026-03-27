@e2e @critical @booking-lifecycle
Feature: End-to-End Booking Flow
  In order to validate complete booking lifecycle
  As a system
  The booking journey must function correctly from creation to cancellation

  Background:
    Given the hotel booking API is accessible

  

  @positive @complete-cycle
  Scenario Outline: Complete hotel booking lifecycle successfully
    When the user checks room availability from "<checkin>" to "<checkout>"
    And the user creates a booking with:
      | firstname   | lastname   | email   | phone   | depositpaid |
      | <firstname> | <lastname> | <email> | <phone> | <depositpaid> |
    Then the booking should be created successfully
    And a booking id should be generated

    When the user retrieves the booking using the generated booking id
    Then the system should return booking details
    And the response status code should be 200

    Given the admin is authenticated
    When the admin updates the booking with:
      | firstname   | lastname   | depositpaid   | checkin   | checkout   | roomid   |
      | <updateFirstName> | <updateLastName> | <updateDepositPaid> | <updateCheckin> | <updateCheckout> | <roomid> |
    Then the booking should be updated successfully
    And the response status code should be 200

    When the admin cancels the booking using the generated booking id
    Then the booking should be cancelled successfully
    And the response status code should be 200

    When the user retrieves the same booking
    Then the system should return not found
    And the response status code should be 404

    Examples:
      | roomid | checkin    | checkout   | firstname | lastname | email           | phone       | depositpaid | updateFirstName | updateLastName | updateDepositPaid | updateCheckin | updateCheckout |
      | 1      | 2026-03-10 | 2026-03-12 | Naveen    | Kumar    | naveen@mail.com | 91234567890 | false       | Alice           | Brown          | true              | 2026-03-11    | 2026-03-13     |
      | 2      | 2026-04-15 | 2026-04-18 | Bobby     | Sindu    | bob@mail.com    | 99876543210 | true        | Bob             | Jones          | false             | 2026-04-16    | 2026-04-19     |



  @negative @security
  Scenario: Prevent update and cancellation without authentication
    Given a booking has been created
    When a request is made to update booking without authentication
    Then the system should deny access
    And the response status code should be 403

    When a request is made to cancel booking without authentication
    Then the system should deny access
    And the response status code should be 403

  

  @edge
  Scenario: Handle booking lifecycle after platform reset
    Given a booking has been created
    And the platform reset cycle has completed
    When the user retrieves the booking
    Then the system should return not found
    And the response status code should be 404