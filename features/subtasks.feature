Feature: Adding subtask
	As a time-manager
  In order to plan my activity
  I want to manage subtasks
  
  Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание     | 1415812561 |
      | Тестовая задача 2   | Описание     | 1415812566 |

  Scenario: Successfully add subtasks
    Given the date is "1415812566"
    When I run command `-t 2 add`
    And I type a subtask title "Подзадача 1"
    Then I should see "Подзадача #1 к задаче #2 добавлена"
    When I run command `-t 2 list`
    Then I should see
    """
    #2 "Тестовая задача 2"
    2014-11-12
    Описание
    Подзадачи:
          2014-11-12 Подзадача 1 (#1)
    """

  Scenario: Successfully mark subtask finished
    When I run command `done 1`
    Then I should see "Подзадача 'Подзадача 1' завершена"

  #  Scenario: Add multiline descriptions for tasks