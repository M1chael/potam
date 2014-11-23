Feature: Show info about task
	As a time-manager
	In order to learn my activity with specific task
	I want to view details about task and its notes

	Background:
    Given following tasks exists:
      | title               | description  | created_at | 
      | Тестовая задача 1   | Описание 1   | 1415812561 |
      | Тестовая задача 2   | Описание 2   | 1415812566 |
    And following subtasks exists:
    	| title					| task_id 	| status 	| created_at |
     	| Подзадача 1 	| 1 				| 0 			| 1415812661 |
     	| Подзадача 2 	| 2 				| 1 			| 1415812666 |
     	| Подзадача 3 	| 1 				| 0 			| 1415812961 |
    And following notes exists:
    	| task_id 	| text	 			| created_at |
     	| 1 				| Заметка 1 	| 1415812661 |
     	| 2 				| Заметка 2 	| 1415812666 |
     	| 1 				| Заметка 3 	| 1415812961 |
     	| 1 				| Заметка 4 	| 1415812961 |
     	| 1 				| Заметка 5 	| 1415813161 |
     	| 1 				| Заметка 6 	| 1415813261 |
     	| 1 				| Заметка 7 	| 1415813361 |
     	| 1 				| Заметка 8 	| 1415813461 |
     	| 1 				| Заметка 9 	| 1415813561 |
     	| 1 				| Заметка 10 	| 1415813661 |
     	| 1 				| Заметка 11 	| 1415813761 |
     	| 1 				| Заметка 12 	| 1415813861 |
     	| 1 				| Заметка 13 	| 1415813961 |

	Scenario: view task info with subtasks and notes
		When I run command `-t 1 list`
		Then I should see
		"""
		#1 "Тестовая задача 1"
		2014-11-12
		Описание 1
		Подзадачи:
		      2014-11-12 Подзадача 3 (#3)
		      2014-11-12 Подзадача 1 (#1)
		
		2014-11-12
		Заметка 13
		
		2014-11-12
		Заметка 12
		
		2014-11-12
		Заметка 11
		
		2014-11-12
		Заметка 10
		
		2014-11-12
		Заметка 9
		
		2014-11-12
		Заметка 8
		
		2014-11-12
		Заметка 7
		
		2014-11-12
		Заметка 6
		
		2014-11-12
		Заметка 5
		
		2014-11-12
		Заметка 4
		"""
		When I run command `-t 2 list`
		Then I should see
		"""
		#2 "Тестовая задача 2"
		2014-11-12
		Описание 2

		2014-11-12
		Заметка 2
		"""