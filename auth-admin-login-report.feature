 @auth @admin
 Feature: Admin Authentication
   In order to access protected booking operations
   As an admin
   The system must validate authentication credentials



  @positive
  Scenario: Successful login with valid credentials
    When the admin submits login credentials:
      | username | password |
      | admin    | password |
    Then the system should authenticate successfully
    And a valid authentication token should be generated
    And the response status code should be 200


  @negative
  Scenario Outline: Login failure with invalid credentials
    When the admin submits login credentials:
      | username   | password   |
      | <username> | <password> |
    Then the system should reject authentication
    And the response status code should be 401

    Examples:
      | username | password   |
      | admin1   | password   |
      | admin    | wrong      |
      |          | password   |
      | admin    |            |



  @security
  Scenario: Access protected endpoint without authentication
    When a request is made to update booking without authentication token
    Then the system should deny access
    And the response status code should be 403

  @security
  Scenario: Access protected endpoint with invalid token
    Given an invalid authentication token is provided
    When a request is made to cancel booking
    Then the system should reject the request
    And the response status code should be 403

  @security
  Scenario: Access protected endpoint with expired token
    Given an expired authentication token is provided
    When a request is made to update booking
    Then the system should reject the request
    And the response status code should be 403