@booking @retrieval @reservation
Feature: Retrieve Booking Details
  In order to verify reservations
  As a user
  The system must provide booking details for valid queries

  Background:
    Given the booking system is accessible

  

  @positive
  Scenario Outline: Retrieve booking details using valid booking id
    Given booking id "<bookingid>" exists
    When the user requests booking details
    Then the system should return booking information with the same id
    And the response status code should be 200

    Examples:
      | bookingid |
      | 1         |
      | 2         |
      | 5         |

  @positive
  Scenario Outline: Retrieve booking details using room id
    Given room id "<roomid>" exists
    When the user requests bookings for the room id
    Then the system should return booking details for that room
    And the response status code should be 200

    Examples:
      | roomid |
      | 1      |
      | 2      |
      | 3      |

  

  @negative
  Scenario Outline: Retrieve booking with invalid booking id
    Given booking id "<bookingid>"
    When the user requests booking details
    Then the system should return not found
    And the response status code should be 404

    Examples:
      | bookingid |
      | -1        |
      | 0         |
      | 9999      |

  @negative
  Scenario: Retrieve booking with non-numeric booking id
    Given booking id "abc"
    When the user requests booking details
    Then the system should return validation error
    And the response status code should be 400

 

  @edge
  Scenario: Handle booking retrieval after system reset
    Given a booking has been created previously
    And the platform reset cycle has completed
    When the user requests the same booking details
    Then the system should return not found
    And the response status code should be 404