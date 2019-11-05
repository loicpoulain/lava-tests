def lava_result_convert(pytest_outcome):
	if pytest_outcome is 'passed':
		return'pass'
	else:
		return 'fail'

def pytest_report_teststatus(report):
	test_name= report.location[2][5:]
	if report.when is 'setup':
		print('\n')
		print('<LAVA_SIGNAL_STARTTC '+ test_name+ '>')
	elif report.when is 'call':
		test_result= lava_result_convert(report.outcome)
		print('\n')
		print('<LAVA_SIGNAL_ENDTC '+ test_name+ '>')
		print('<LAVA_SIGNAL_TESTCASE TEST_CASE_ID='+ test_name+' RESULT='+ test_result+ '>')
