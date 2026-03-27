@security @booking-summary
Feature: Booking Summary Access Control

  Scenario Outline: Validate access control for booking summary endpoint
    Given the booking summary endpoint access policy is enforced
    When the user requests booking summary for room id "<roomid>" without authentication
    Then the system behavior should match access rules

    Examples:
      | roomid |
      | 1      |
      | 2      |