@booking @update @reservation
Feature: Update Booking
  In order to maintain accurate reservations
  As an admin
  The system must allow modification of existing bookings

  Background:
    Given the hotel booking API is accessible
    And the admin is authenticated

  

  @positive
  Scenario Outline: Update booking with valid data
    Given booking id "<bookingid>" exists
    When the admin updates the booking with:
      | firstname   | lastname   | depositpaid   | checkin   | checkout   | roomid   |
      | <firstname> | <lastname> | <depositpaid> | <checkin> | <checkout> | <roomid> |
    Then the booking should be updated successfully
    And the response status code should be 200

    Examples:
      | bookingid | roomid | firstname | lastname | depositpaid | checkin    | checkout   |
      | 1         | 1      | John      | Wick     | true        | 2026-06-01 | 2026-06-05 |
      | 2         | 2      | Alice     | Brown    | false       | 2026-07-10 | 2026-07-12 |
      | 5         | 3      | Mark      | Antony   | true        | 2026-08-01 | 2026-08-04 |



  @negative
  Scenario Outline: Reject update with non-numeric booking id
    Given booking id "<bookingid>"
    When the admin updates the booking
    Then the system should reject the request
    And the response status code should be 400

    Examples:
      | bookingid |
      | abc       |
      | !@#$      |

  @negative
  Scenario Outline: Reject update for non-existing booking id
    Given booking id "<bookingid>" does not exist
    When the admin updates the booking with valid data
    Then the system should return not found
    And the response status code should be 404

    Examples:
      | bookingid |
      | 9999      |
      | 2147483647|

  @negative
  Scenario Outline: Reject update with invalid field values
    Given booking id "<bookingid>" exists
    When the admin updates the booking with:
      | firstname   | lastname   | depositpaid   | checkin   | checkout   | roomid   |
      | <firstname> | <lastname> | <depositpaid> | <checkin> | <checkout> | <roomid> |
    Then the system should reject the request
    And the response status code should be 400

    Examples:
      | bookingid | roomid | firstname | lastname | depositpaid | checkin    | checkout   |
      | 1         | 1      |           | Doe      | true        | 2026-06-01 | 2026-06-05 |
      | 1         | 1      | John      |          | true        | 2026-06-01 | 2026-06-05 |
      | 1         | 1      | John      | Doe      | true        | 2026-06-05 | 2026-06-01 |
      | 1         | 1      | John      | Doe      | true        | 2026-06-01 | 2026-06-01 |

  

  @consistency
  Scenario: Verify updated booking details are persisted
    Given booking id "1" exists
    When the admin updates the booking with valid data
    And the user retrieves the same booking
    Then the response should contain updated values
    And the response status code should be 200

  

  @security
  Scenario: Reject update without authentication
    Given no authentication token is provided
    When a request is made to update booking
    Then the system should deny access
    And the response status code should be 403

  @security
  Scenario: Reject update with invalid token
    Given an invalid authentication token is provided
    When a request is made to update booking
    Then the system should deny access
    And the response status code should be 403