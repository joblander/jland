@api
Feature: List domains
  As an API client
  In order to do things with positions
  I want to retrieve a list of positions

  Scenario: retrieve all positions for a user as JSON
    Given I am an API user
    And I send and accept JSON
    And I have a position
    When I send a GET request for "/users/1/positions.json"
    Then the response code should be 200
    And the JSON response should be an array with 1 "domain" elements