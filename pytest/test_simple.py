import pytest

def test_pytest_success():
	assert '42' == '42'

def test_pytest_failure():
	assert '42' == '32'
