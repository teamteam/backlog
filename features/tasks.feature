Feature: Tasks

  Background:
    Given I am logged in

  Scenario: Create a new task
    Given a backlog item exists
    And I'm on the new task page
    When I enter the new task info
    And submit
    Then I should see the task on the item

  Scenario: Complete a task
    Given a backlog item exists
    And a task exists
    And I'm on the backlog item page
    When I mark the task as complete
    Then the task shows up as completed
