import os
import time
#f = open("result.txt", "w")
while(1):
    req = str(os.system('curl IP:PORT'))
    f = open("result.txt", "w")
    #print(type(req))
    #text = open("result.txt", 'w')
    print("\n", str(req))
    if req == '0':
        #print("Cat!!!!!!")
        f.write("Cat")
    elif req == '1':
        #print("Dog!!!!!!")
        f.write("Dog")
    f.close()
    time.sleep(3)
#f.close()
