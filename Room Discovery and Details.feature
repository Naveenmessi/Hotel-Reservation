@rooms @discovery
Feature: View Available Rooms
  As a user
  User wants to explore available rooms
  So that a suitable room can be selected

  Background:
    Given the booking system is accessible

  @positive
  Scenario: Retrieve all rooms successfully
    When the user requests the list of rooms
    Then the system should return available rooms details

  @negative
  Scenario Outline: Retrieve room details with invalid identifiers
    Given the user provides room id "<roomId>"
    When the user requests room details
    Then the system should not return valid room data
    And the response body should be "<response>" failing to show available rooms

  Examples:
    | roomId      | response                     |
    | -1          | { "error": "Bad Request" }   |
    | 0           | { "error": "Bad Request" }   |
    | abc         | { "error": "Bad Request" }   |
    | 9999        | { "error": "Bad Request" }   |
    | 2147483647  | { "error": "Bad Request" }   |