
								// включить код тестирования в проект
#macro API_TEST_ENABLE			true

								// включить все тесты, или только те,
								// что имеют включённый локальный переключатель
#macro API_TEST_ALL				false
								
								// локальный переключатель тестов
#macro API_TEST_LOCAL			var _enable =
#macro API_TEST					(API_TEST_ALL || _enable)

// образец тестов

#region tests
if (API_TEST_ENABLE) {
	
	API_TEST_LOCAL true;
	if (API_TEST) {
		
		show_debug_message(
			"<API TEST>\n\t" + "apiScrTest"
		);
		
		show_debug_message("\t<template>");
		
		show_debug_message("<COMPLETE>");
	}
}
#endregion
