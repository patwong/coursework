︠d55f6441-b118-4ff9-b0fb-7dc47d74b334︠
F.<x> = QQ[]
z = 3
K.<w> = GF(2^128, modulus=x^128 + x^7 + x^2 + x + 1)
g = K.random_element()
a = ZZ.random_element(2^128-1)
b = ZZ.random_element(2^128-1)
︡aa27e24c-737b-43a0-9f81-639ec846fa48︡︡{"done":true}
︠52b5743c-01a4-47ba-8d87-68167dfecbad︠
a

︡b42c5a50-0910-4bb4-80e5-c738f042cbd4︡︡{"stdout":"290359047706163070207274294572900589099\n","done":false}︡{"done":true}
︠2e3d5495-f0e5-400c-9d1c-71239e1636f4︠
q = 24591437642601686069585809261845683826072619627520957132835061935152051389061
︡e57a8ddb-8b5b-4a73-b68a-d7698c2cc9e3︡︡{"done":true}
︠3b33cf35-2e3f-493b-8cb7-cd00774fdb33︠
def pow(g,a,n):
    if a == 0:
        return 1
    if Mod(a,2) == 0:
        t = pow(g,a/2,n)
        return Mod(t*t,n)
    if Mod(a,2) == 1:
        t = pow(g,a-1,n)
        return Mod(g*t,n)
︡7ae687fe-4b49-4c0e-93dd-f03a2b10665d︡︡{"done":true}
︠21cfeefe-d9a3-46f3-a5ca-f2b6a38b6a9b︠
1/(Integers(29)(11))
︡fe503538-e220-43a4-b5eb-3bfb37b9057e︡︡{"stdout":"8\n","done":false}︡{"done":true}
︠08729110-e25b-4a71-9d6e-8b8451f9ad0b︠
Integers(97)(51^2006)
︡d2bd2156-3824-4b60-ab39-5fc149820ed5︡︡{"stdout":"12\n","done":false}︡{"done":true}

︠cf198894-1d75-40c8-b699-9a6b4e17bdd7︠
p = 131
q = 137
n = p*q
phi_n = (p-1)*(q-1)
e = 3
m = 827
Integers(phi_n)(3)
︡501d80ba-23d2-4ada-9bfd-7644b3ba638f︡︡{"stdout":"3\n","done":false}︡{"done":true}
︠30b858d9-1305-4425-af48-e05bcc88e4fe︠
1/(Integers(phi_n)(e))
︡b22d90eb-52a7-4f20-811a-0fd82aed55c8︡︡{"stdout":"11787\n","done":false}︡{"done":true}
︠2240bbb6-d13a-4cb4-9bac-e9eee82e39aa︠
R.<x,y> = ZZ[]
︡3afcaaf5-929c-4fca-bfa0-55f73c56e959︡︡{"done":true}
︠9c41c9d9-7aa4-44bd-a61f-c9f367b72d85︠
x.parent()

︡91f1abe5-97a1-49e1-98a9-eacbd97e3f15︡︡{"stdout":"Multivariate Polynomial Ring in x, y over Integer Ring\n","done":false}︡{"done":true}
︠886d8240-70c5-4d59-94fa-36575d02fd7b︠
nz = 29
c1 = Integers(nz)(5)^3
c1
︡c01996e0-779c-4e32-904a-d4cbc724c5b8︡︡{"stdout":"9\n","done":false}︡{"done":true}
︠56857cb6-e330-4875-a5c1-e68a1d08146c︠
c2 = Integers(nz)(5^3)
c2
︡4f5443fa-fe89-4fb0-88e5-f34c89c6cdcc︡︡{"stdout":"9\n","done":false}︡{"done":true}
︠f514c345-72bd-4254-acf9-4443bda475bd︠
m.gcd(n)
︡8f261160-1243-4b77-9d7f-a3740311f7ef︡︡{"stdout":"1\n","done":false}︡{"done":true}
︠3bb5612f-1fd0-46cd-b449-28f0dc18c467︠
m1 = m*4 + 1
m2 = m*4 + 3
c1 = Integers(n)(m1)^e
c2 = Integers(n)(m2)^e
c1
c2
f = x^3 -ZZ(c1)
g = (x+y)^3 - ZZ(c2)
h = f.resultant(g)
h
1 + 9777 + 5730085587+34614102979
h(1000,1)
︡cec74356-407f-4637-ab83-cf68270a4221︡︡{"stdout":"16248\n","done":false}︡{"stdout":"12989\n","done":false}︡{"stdout":"y^9 + 9777*y^6 + 5730085587*y^3 + 34614102979\n","done":false}︡{"stdout":"40344198344\n","done":false}︡{"stdout":"40344198344\n","done":false}︡{"done":true}
︠9146f534-fe9d-4b87-bad4-7789a9c277e5︠
f.gcd((x+2)^3 - ZZ(c2))
P.<X> = Integers(n)[]
F = (X^3 - c1)
F.gcd((X + 2)^3 - c2)
F.quo_rem(X+14638)
G.quo_rem(X+14638)
︡d690e6b4-467c-40c2-a8c8-3de6f7034bda︡︡{"stdout":"1\n","done":false}︡{"stdout":"X + 14638\n","done":false}︡{"stdout":"(X^2 + 3309*X + 1811, 0)\n","done":false}︡{"stdout":"(X^2 + 3315*X + 3730, 0)\n","done":false}︡{"done":true}
︠f1924823-4268-4bfc-b943-201d9abe9db9︠
print "hi i am a string"
︡0f9f8ed1-d6b0-49d7-8f86-a2f2d031e77d︡︡{"stdout":"hi i am a string\n","done":false}︡{"done":true}
︠350782c8-2220-44f8-8afc-ead4e8c4495d︠
F.gcd((X+2)^3 - c2)
m1
G = (X+2)^3 - c2
G
F
F322 = F.gcd((X+2)^3 - c2)
F322.roots(multiplicities=False)

︡ef05c5d1-6c81-4139-a8e7-8395777016ff︡︡{"stdout":"X + 14638\n","done":false}︡{"stdout":"3309\n","done":false}︡{"stdout":"X^3 + 6*X^2 + 12*X + 4966\n","done":false}︡{"stdout":"X^3 + 1699\n","done":false}︡{"stdout":"[3309]\n","done":false}︡{"done":true}
︠dff50b9b-dab6-4f2f-b8ad-e5aa3e94297f︠
#F.quo_rem(G)
F2 = X^3
F3 = X^3+1
#F2.quo_rem(F3)
P.<X1> = ZZ[]
z = F2.quo_rem(F3)
#10.quo_rem(5)
X1^2*(X1^3+1)
z
z[0]
z[1]
︡295d1997-9d26-4466-a1d4-eaac39c70082︡︡{"stdout":"X1^5 + X1^2\n","done":false}︡{"stdout":"(1, 17946)\n","done":false}︡{"stdout":"1\n","done":false}︡{"stdout":"17946\n","done":false}︡{"done":true}
︠3798142b-06f7-40a0-aa89-ab9a4a259af7︠
z1212 = 29.quo_rem(11)
z1212[0]
z1212[1]
29-2*11
︡8667e555-cbeb-4a64-8084-aef2cd843c8d︡︡{"stdout":"2\n","done":false}︡{"stdout":"7\n","done":false}︡{"stdout":"7\n","done":false}︡{"done":true}
︠09cecffe-e2e1-47d9-9def-b1a840372a18︠
#def eea(rpast,rcurr,spast,scurr,tpast,tcurr):
#    q = rpast.quo_rem(rcurr)
#    r = q[1]
#    q = q[0]
#    #qdivs = q.quo_rem(scurr)
#    #qdivt = q.quo_rem(tcurr)
#    #s = spast - qdivs[0]/scurr
#    #t = tpast - qdivt[0]/tcurr
#    s = spast - q*scurr
#    t = tpast - q*tcurr
#    if r == 0:
#        return [scurr,tcurr]
#    else:
#        return eea(rcurr,r,scurr,s,tcurr,t)
def eea(rpast,rcurr,spast,scurr,tpast,tcurr):
    q = rpast.quo_rem(rcurr)
    r = q[1]
    q = q[0]
    s = spast - q*scurr
    t = tpast - q*tcurr
    if r == 0:
        return [scurr,tcurr,r,rcurr]
    else:
        return eea(rcurr,r,scurr,s,tcurr,t)
    
#hF
#r0 = F                        #29
#r1 = G                        #11
#r = r0.quo_rem(r1)
#r
#r2 = r[1]
#r = r1.quo_rem(r2)
#r
###Integers(n)(-2788/8433)
#r3 = r[1]
#r = r2.quo_rem(r3)
#r
#r4 = r[1]
#r3.roots(multiplicities=False)
###r = r3.quo_rem(r4)
###r
###r5 = r[1]
###r = r4.quo_rem(r5)
###r
###r[1] == 0
F
G
eout = eea(29,11,1,0,0,1)
eout
eea(240,46,1,0,0,1)
eout2 = eea(F,G,1,0,0,1)
eout2
eout2[3].roots(multiplicities=False)
︡5c6a830b-623b-4cd2-843b-d5bb1044ed48︡︡{"stdout":"X^3 + 1699\n","done":false}︡{"stdout":"X^3 + 6*X^2 + 12*X + 4966\n","done":false}︡{"stdout":"[-3, 8, 0, 1]\n","done":false}︡{"stdout":"[-9, 47, 0, 2]\n","done":false}︡{"stdout":"[14956*X + 5983, 2991*X + 11965, 0, 8433*X + 2788]\n","done":false}︡{"stdout":"[3309]\n","done":false}︡{"done":true}
︠095360c9-8351-4e5d-b25d-83cc9bdee47b︠
#ftest = x^3 - 5
#gtest = (x + 3)^3 - 10
#ftest / gtest
Integers(n)(-2788/8433)
︡cca37825-7ddf-4920-81e3-905c3413e196︡︡{"stdout":"3309\n","done":false}︡{"done":true}
︠f1b4d8d6-b03f-42df-a7ce-0ac9871f133f︠
n6788 = "b54400b5a0478403640d99116d42ff700732f863c6947417d6e4adbb8fbe139ca6fb6aedbc4d9ac4cdddc9de29fa2e581bd6a2b40f3488ec67b30bf5b74e62cd77af6f507a486d0c38256b52cfb1313b3f19c2ef10fa00dd91b9f50e137dc0efbc21d7d2dd6b45361b340e77e02703ab1cbee71c22975272c31b9db17c24f42f18fcfa55d96f6fb90ac3e62171ff622edcc550fd3d113f743ee9aad57dc4d6dcbee1c2caa3061991ebc6cdb6fdba77ae445d25f858669bca4176c8982149a27fe863c0110b1c55dcfe47d512fc2cf0bdd6959590318f4b09e1fc4b351f9b814a9a651414b674b3e81d5f1989874197c2e5cc83b06cd85e49d7440adb1aedf55f"
n6788 = int(n6788,16)
x_coef = 15837320062140447583099440976779418150988102731411125723050789866138581044830822189471404645133948446535000692720655681367237284703044945537284787138854807681837898184164866805190918803352499187119848181908777204908840486821291839337230528460160645801044688112551443664805633693972451065020791985638866583397801230539577239519982062858041549363381735170796749842746969914355115133325369802641806023821491834369590263375406511237330951054954920826568124595678293960018297178944308414539159370542990613685078539824883031869045289431938766675096219984237968699974042044995575755885461162335343330740660071907542306226125
poly_num = 21362329153277560751060367949145626582183499029517276902584574663769098588344868421684619655650367135969731469913356847916806810915675313603702112379489667543192469528010398265285771973202969888828926018484828579842182101195188530308569067392563801310809448390149595974223633895981034522433811476148964286123337754024748358305559955954838269923224050875409633977829714706386525590064939572459344322689726557159578474241433654079192372363849303252896424406532715271559772292353285582337153611695621980835569083534249742863060293941089390338717389856071618253706048592660500562547369606592044665004729288936761976403072
z6788 = poly_num/x_coef
Integers(n6788)(-z6788)


︡5af7ad7f-2a64-4b48-99d4-98c15b03c98c︡︡{"stdout":"13914397845631924886733116452942441148738404272529842557304914528684255675977968715561910527828547439639257897419639123463812331172113338272826604754655839318542026034942326351195259768776033118523410811340528190350957457842880871958488704909245526361718503300996499250776396276996193236689340699758052072343614615890655596542460274592603117032495296464354582474948535841139852968732382297906064006129598761040787023415080463343924177315668989619829682692505650309521272700728082144666437175043330737842484940795985569489402484599659189819649820363591911030732327218698666016377890295003553801260144092522720865428371\n","done":false}︡{"done":true}
︠e0230073-f422-4f02-927f-cbeb14d29dbe︠









