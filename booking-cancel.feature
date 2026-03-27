@booking @cancellation @reservation-cancellation
Feature: Cancel Booking
  In order to release reserved rooms
  As an admin
  The system must allow cancellation of existing bookings

  Background:
    Given the hotel booking API is accessible
    And the admin is authenticated

  

  @positive
  Scenario Outline: Cancel an existing booking successfully
    Given booking id "<bookingid>" exists
    When the admin cancels the booking
    Then the booking should be cancelled successfully
    And the response status code should be 200

    Examples:
      | bookingid |
      | 1         |
      | 2         |
      | 5         |

 

  @negative
  Scenario Outline: Reject cancellation with non-numeric booking id
    Given booking id "<bookingid>"
    When the admin cancels the booking
    Then the system should reject the request
    And the response status code should be 400

    Examples:
      | bookingid |
      | abc       |
      | !@#$      |

  @negative
  Scenario Outline: Return not found for non-existing booking id
    Given booking id "<bookingid>" does not exist
    When the admin cancels the booking
    Then the system should return not found
    And the response status code should be 404

    Examples:
      | bookingid |
      | 9999      |
      | 2147483647|

  

  @consistency
  Scenario: Confirm cancelled booking cannot be retrieved
    Given booking id "1" exists
    When the admin cancels the booking
    And the user retrieves the same booking
    Then the system should return not found
    And the response status code should be 404

  

  @edge
  Scenario: Handle repeated cancellation request gracefully
    Given booking id "1" has already been cancelled
    When the admin cancels the booking again
    Then the system should handle the request gracefully
    And the response status code should be 200



  @security
  Scenario: Reject cancellation without authentication
    Given no authentication token is provided
    When a request is made to cancel booking
    Then the system should deny access
    And the response status code should be 403

  @security
  Scenario: Reject cancellation with invalid token
    Given an invalid authentication token is provided
    When a request is made to cancel booking
    Then the system should deny access
    And the response status code should be 403