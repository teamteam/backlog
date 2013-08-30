Feature: Backlog

  Background:
    Given I am logged in

  Scenario: View remaining task count
    Given a backlog item exists
    And a task exists
    When I view the backlog
    Then I should see the remaining task count
