Feature: Adding note
	As a time manager
	In order to fix my activity
	I want to add notes for specified task

	Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание     | 1415812561 |
      | Тестовая задача 2   | Описание     | 1415812566 |

  Scenario Outline: Successfully add notes
    When I run command `-t <task> add -n`
    And I type a note "<text>"
    Then I should see "Заметка к задаче #<task> добавлена"

    Examples:
      | task 	| note  | text 				|
      | 1 		| 1 		| Описание    |
      | 1 		| 2 		| Описание    |
      | 2 		| 1 		| Описание    |
      | 2 		| 2 		| Описание    |