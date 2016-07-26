from random import randrange, uniform


def gettingTariff(maxnumber):
    x = 1
    m = 2
    Result = list()
    while x <= maxnumber:

        y = str(m)
        Result.append("xpath=.//*[@id='pricePlanTable']/tbody/tr[" + y + "]/td[5]/a")
        x += 1
        m +=2
    length = len(Result)
    irand = randrange(0, length)
    tariff = Result[irand]
    return tariff