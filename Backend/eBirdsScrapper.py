import requests
import json
import csv
from calendar import monthrange

dellist = ["obsValid","obsReviewed","locationPrivate","subId"]
stplist = ["speciesCode", "comName","sciName", "lat","lng", "howMany", "locId", "locName", "obsDt"]

with open('test.csv', mode='w') as testfile:
    testwriter = csv.writer(testfile, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)

    # every year in range
    for datey in range(1986,2022):
        datey = f'{datey:04d}'

        # every month in range
        for datem in range(1,13):
            datem = f'{datem:02d}'

            # find the no. of days in the month given year and month
            for dated in range(1,monthrange(int(datey), int(datem))[1]):
                dated = f'{dated:02d}'

                url = f"https://api.ebird.org/v2/data/obs/SG/historic/{datey}/{datem}/{dated}"

                headers = {"X-eBirdApiToken": "8g22h17vr30c"}
                resp = requests.get(url,headers=headers)

                try:
                    jsonreply = resp.content.decode("utf-8")
                    jsonreply = json.loads(jsonreply) # returns list of dictionary

                    for birdInstance in jsonreply: # for item in list
                        for key in dellist: # remove unwanted columns
                            del birdInstance[key]

                        flag = 0
                        stp = [] # send to print

                        # check through every key and handle exceptions
                        for i in range(len(stplist)):
                            try:
                                stp.append(birdInstance[stplist[i]]) # if exists, add to stp
                            except: # if does not exist
                                if stplist[i] == "howMany": # default = 1
                                    stp.append(1)
                                elif stplist[i] == "obsDt": # default = that day at noon
                                    stp.append(f'{datey}/{datem}/{dated} 12:00')
                                elif stplist[i] == "locId" or stplist[i] == "locName": # not impt data
                                    stp.append(None)
                                else:
                                    flag = 1 # when flag raised, go to next instance
                                    break

                        if flag == 1:
                            continue


                        testwriter.writerow(stp)

                except:
                    continue
