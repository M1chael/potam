Feature: View report
	As a time-manager
	In order to browse my activity per period
	I want to view reports

	Background:
		Given the date is "1415942161"	# Пт. нояб. 14 10:16:01
		And following tasks exists:
		  | title               | description  | created_at | 
      | Тестовая задача 1   | Описание 1   | 1415164561 |	# Ср. нояб.  5 10:16:01
      | Тестовая задача 2   | Описание 2   | 1415175181 |	# Ср. нояб.  5 13:13:01
      | Тестовая задача 3   | Описание 2   | 1415812566 | # Ср. нояб. 12 22:16:06
     And following subtasks exists:
      | title					| task_id 	| status 	| created_at | updated_at |
     	| Подзадача 1 	| 1 				| 0 			| 1415188825 | 0					|	# Ср. нояб.  5 17:00:25
     	| Подзадача 2 	| 2 				| 1 			| 1415250801 | 1415592621 | # Чт. нояб.  6 10:13:21, Пн. нояб. 10 09:10:21
     	| Подзадача 3 	| 3 				| 0 			| 1415858400 | 0					|	# Чт. нояб. 13 11:00:00
     And following notes exists:
			| task_id 	| text	 			| created_at |
     	| 1 				| Заметка 1 	| 1415337023 |	# Пт. нояб.  7 10:10:23 YEKT 2014
     	| 2 				| Заметка 2 	| 1415699432 |	# Вт. нояб. 11 14:50:32 YEKT 2014
     	| 3 				| Заметка 3 	| 1415858400 |	# Чт. нояб. 13 11:00:00
#
#  Scenario: view weekly report
#  	When I run command `report -w`
#  	Then I should see
#  	"""
#  	Проведена работа по следующим задачам:
#					#3      Тестовая задача 3                        2014-11-12
#    			#2      Тестовая задача 2                        2014-11-12
#  	"""