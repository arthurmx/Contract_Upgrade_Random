from random import randrange, uniform


def gettingList(DevicesNr):
	x = 1
	varPath = "xpath=.//*[@id='container']/div[3]/div[6]/div/div"
	Result = list()
	while x<=DevicesNr:
		y = str(x)
		Result.append(varPath + "[" + y + "]")
		x +=1
	length = len(Result)
	irand = randrange(0, length)
	RandomDevice = Result[irand]
	return RandomDevice




