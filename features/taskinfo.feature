Feature: Show info about task
	As a time-manager
	In order to learn my activity with specific task
	I want to view details about task and its notes

	Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание 1   | 1415812561 |
      | Тестовая задача 2   | Описание 2   | 1415812566 |

	Scenario: view task info
		When I run command `-t 1 list`
		Then I should see
		"""
		#1 "Тестовая задача 1"
		2014-11-12
		Описание 1
		"""