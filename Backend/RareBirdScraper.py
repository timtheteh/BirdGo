with open('birddata.txt')as f:
    lines = f.readlines()

imptlist = []

for line in lines:
    cur = line.split()
    if cur[0]== "Family":
        continue
    for n in range(len(cur)-1,-1,-1):
        if cur[n] == "A" or cur[n] == "C" or cur[n] == "U" or cur[n] == "R":
            if cur[n] == "A":
                break
            else:
                # only use common birds and above (remove abundant)
                # convert the 3 ratings into 1 num
                rating = cur[n]
                if cur[n] == "C":
                    ratingNum = 1
                if cur[n] == "U":
                    ratingNum = 2
                if cur[n] == "R":
                    ratingNum = 3

                cur = cur[:n] # remove unnecessary data
                cur = cur[1:len(cur)-1] # remove number, abundance rating

                sciName = cur[len(cur)-2:] # last 2 words are sci names
                sciName = " ".join(sciName)

                birdName = cur[:len(cur)-2] # the rest are normal names
                birdName = " ".join(birdName)

                # remove unnecessary markings
                while birdName.find("*")!= -1 or birdName.find("#")!= -1:
                    if birdName.find("*")!= -1:
                        birdName = birdName[:birdName.find("*")]
                    if birdName.find("#")!= -1:
                        birdName = birdName[:birdName.find("#")]
                birdName = birdName.strip()

                imptlist.append((sciName, birdName, ratingNum))
                #imptlist.append(sciName)

                break

print(imptlist)
