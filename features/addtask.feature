Feature: Adding task
	As a time-manager
  In order to group my activity
  I want to add a task
  
  Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание     | 1415812561 |
      | Тестовая задача 2   | Описание     | 1415812566 |

  Scenario: Successfully add tasks
    When I run command `add`
    And I type a task title "Тестовая задача 3"
    And I type a task description "Описание"
    Then I should see "Задача 'Тестовая задача 3' (#3) добавлена"

  #  Scenario: Add multiline descriptions for tasks