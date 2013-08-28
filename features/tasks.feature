Feature: Tasks

  Scenario: Create a new task
    Given I am logged in
    And a backlog item exists
    And I'm on the new task page
    When I enter the new task info
    And submit
    Then the task should exist
