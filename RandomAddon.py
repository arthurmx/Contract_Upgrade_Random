from random import randrange, uniform


def gettingAddon(DevicesNr):
	x = 1
	Result = list()
	while x<=DevicesNr:
		y = str(x)
		Result.append("xpath=.//*[@id='pricePlanTable']/tbody/tr[" + y + "]/td[4]/a")
		x +=1
	length = len(Result)
	irand = randrange(0, length)
	RandomTariff = Result[irand]
	return RandomTariff