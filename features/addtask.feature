Feature: Adding task
	As a time-manager
  In order to group my activity
  I want to add a task

  Scenario Outline: Successfully add tasks
    When I run command `add`
    And I type a task title "<title>"
    And I type a task description "<description>"
    Then I should see "Задача '<title>'"
    And I should see "добавлена"

    Examples:
      | title             | description | number  |
      | Тестовая задача 1 | Описание    | 1       |
      | Тестовая задача 2 | Описание    | 2       |
