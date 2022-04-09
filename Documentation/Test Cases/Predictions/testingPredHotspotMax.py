import math
import csv

#LCTNS is from running BirdPredictAlgo2
lctns = [['Collocalia affinis', 'Plume-toed Swiftlet', 2, 0.941497802734375, '1.354864', '103.7969908', 'Central Catchment Nature Reserve'], ['Ptilinopus jambu', 'Jambu Fruit Dove', 2, 0.5, '1.3388322', '103.729316', 'Jurong Lake Gardens (inc. Chinese Garden and Japanese Garden)'], ['Tachybaptus ruficollis', 'Little Grebe', 3, 0.9504607915878296, '1.3797221', '103.9499173', 'Pasir Ris Park'], ['Tachybaptus ruficollis', 'Little Grebe', 3, 0.9547810554504395, '1.3957264', '103.9257288', "Lorong Halus Wetland (inc. Serangoon Reservoir and former 'Serangoon')"], ['Pycnonotus simplex', 'Cream-vented Bulbul', 2, 0.9986572451889515, '1.3619833', '103.7777245', 'Dairy Farm Nature Park'], ['Pycnonotus brunneus', 'Asian Red-eyed Bulbul', 2, 0.9963913068640977, '1.3416843', '103.8324308', 'MacRitchie Reservoir Park'], ['Tringa totanus', 'Common Redshank', 1, 0.9999997690320015, '1.4182693', '103.72886', 'Kranji Marsh'], ['Copsychus malabaricus', 'White-rumped Shama', 2, 0.9990234375, '1.4036891', '103.9608593', 'Pulau Ubin'], ['Haliaeetus ichthyaetus', 'Grey-headed Fish Eagle', 2, 0.9867112501524389, '1.3148322', '103.8159621', 'Singapore Botanic Gardens'], ['Tringa totanus', 'Common Redshank', 1, 0.9999999925494194, '1.4461788', '103.7286058', 'Sungei Buloh Wetland Reserve']]
data = []

def datenormalisation(date):
    datels = date.split('-')
    day_nrmlsed = 1 if int(datels[2][:3]) < 16 else 2
    mth = int(datels[1])
    nmrlsed = day_nrmlsed*mth
    #nmrlsed_scr = (avg/year_occr[datels[2][:4]])
    return nmrlsed


with open('eBirdClean_2020.csv', mode='r', encoding='utf-8') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for rowCSV in csv_reader:
        data.append(rowCSV)

success = 0
fail = 0
for item in lctns: # for each hotspot
    successflag = 0
    flag = 0
    if item[3]>=0.5:
        flag = 1

    for line in data: # within 2020
        if datenormalisation(line[8]) == 20: # if the date falls in the correct time period
            if line[2] == item[0]: #sci name is same
                if abs(math.dist([float(line[3]),float(line[4])], [float(item[4]),float(item[5])])) <= 0.0360: # if occurence within ~4km
                    if flag == 1:
                        successflag=1 # add to success
                        break
                    else: # did not predict
                        break
    if successflag == 1:
        success+=1
    else:
        fail+=1

print(success/(success+fail)) #
print(fail/(success+fail))



