︠aec7ff1d-4aec-47ab-be2e-a4532042a7f3s︠
p = 131
q = 137
n = p*q
n
phi_n = (p-1)*(q-1)
e = 3
d = 1/(Integers(phi_n)(e))
m = 827
m1 = m*(2^2) + 1
m2 = m*(2^2) + 3
m1
m2
︡0d550dec-5cbd-431c-a5cc-a5a2ee904d1a︡︡{"stdout":"17947\n","done":false}︡{"stdout":"3309\n","done":false}︡{"stdout":"3311\n","done":false}︡{"done":true}
︠bbbe7272-12bb-4b5c-adba-9c1b175c508es︠
c1 = Integers(n)(m1)^e
c2 = Integers(n)(m2)^e
c1
c2
R.<x,y> = ZZ[]
f = x^3 - ZZ(c1)
g = (x+y)^3 - ZZ(c2)
h = f.resultant(g)
Integers(n)(h(0,2))
︡3a19ea3f-8647-4567-a4d1-252242e5bcbb︡︡{"stdout":"16248\n","done":false}︡{"stdout":"12989\n","done":false}︡{"stdout":"0\n","done":false}︡{"done":true}
︠4da3ca03-403e-46ce-be3a-1158591a3203s︠

P.<X> = Integers(n)[]
F = (X^3 - c1)
G = (X + 2)^3 - c2

r0 = F
r1 = G

def eea(rpast,rcurr,spast,scurr,tpast,tcurr):
    q = rpast.quo_rem(rcurr)
    r = q[1]
    if r == 0:
        return [scurr,tcurr,rcurr]
    else:
        q = q[0]
        s = spast - q*scurr
        t = tpast - q*tcurr
        return eea(rcurr,r,scurr,s,tcurr,t)

eea_out = eea(r0,r1,1,0,0,1)
eea_out[2]
pnum = -2788
pden = 8433
rootofpoly = Integers(n)(pnum/pden)
rootofpoly
︡66390d1b-d8b5-402b-b544-9714feb505bd︡︡{"stdout":"8433*X + 2788\n","done":false}︡{"stdout":"3309\n","done":false}︡{"done":true}
︠6a5d865c-d2ad-4f24-839d-3c07466bfee5s︠
listoftuples = []
temptuple = (1, 3)
listoftuples.append(temptuple)
t32 = Integers(n)(2)^(-2)              #some ugly number     #ring of ints mod n #reverse offset
loopcond = True
loopcounter = 0
#while (loopcond == True):
temptuple = listoftuples[loopcounter]
#temptuple
    #temproot = rootofpoly
    #"decrypt"
m1 = Integers(n)(rootofpoly)
m1 = Integers(n)(m1 - temptuple[0])
m1 = m1 * t32
m1
n
e
    #"encrypt"
#cchk = m1 * Integers(n)(2)^2
#cchk = cchk + temptuple[0]
#cchk = Integers(n)(cchk)
print "real ecrypt"
m = m*(2^2) + temptuple[0]
m
c_final = Integers(n)(m)^e
c_final.parent()

if(cchk == rootofpoly):
    print "success!!!!!!!!!"
    loopcond = False
elif(loopcounter == 22):
    print "failure :("
    loopcond = False
loopcounter = loopcounter + 1

print "loop safely exited"

#this obviously works - what we need to do is use the other offset to create a new encryption
#to see if we have chosen the correct offset and if it matches the original c1 or c2
︡d1a64730-c83a-414c-9817-db2e0022b6e8︡︡{"stdout":"827\n","done":false}︡{"stdout":"17947\n","done":false}︡{"stdout":"3\n","done":false}︡{"stdout":"real ecrypt\n","done":false}︡{"stdout":"3309\n","done":false}︡{"stdout":"Ring of integers modulo 17947\n","done":false}︡{"stdout":"success!!!!!!!!!\n","done":false}︡{"stdout":"loop safely exited\n","done":false}︡{"done":true}
︠4f519878-c422-420a-bd2e-339e716409d4s︠
︡9ed6f13c-c1cb-46a6-970f-246af141b9e0︡︡{"done":true}
︠f47a1910-c633-4c02-afec-b4bcee5688f0︠











