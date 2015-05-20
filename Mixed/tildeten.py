import sys
import re

assert(len(sys.argv) > 1),  ("Du mÃ¥ste ge en fil som indata, typ: python3 %s FIL_MED_RAPPDATA" % sys.argv[0])


filnamn = sys.argv[1]
print ("Filen", filnamn, "anvÃ¤nds som indata")

#############################################
# Resultat
#
# FÃ¶r att spara antal A, B, C ... samt bonuspoÃ¤ng fÃ¶re och efter
# betygsutrÃ¤kning. 
#
class Result:
    def __init__(self, namn, sal):
        self.antal = {}
        self.antal['F']  = 0
        self.antal['Fx'] = 0
        self.antal['E']  = 0
        self.antal['D']  = 0
        self.antal['D+']  = 0
        self.antal['C']  = 0
        self.antal['B']  = 0
        self.antal['A']  = 0
        self.ACE_bonus  = 0
        self.orig_bonus = 0
        self.namn       = namn
        self.sal        = sal
    
    def __str__(self):
        ret = '- '
        if self.antal['E'] > 0: ret += ' ' + str(self.antal['E']) + 'E' 
        if self.antal['D'] > 0: ret += ' ' + str(self.antal['D']) + 'D' 
        if self.antal['C'] > 0: ret += ' ' + str(self.antal['C']) + 'C' 
        if self.antal['B'] > 0: ret += ' ' + str(self.antal['B']) + 'B'
        if self.antal['A'] > 0: ret += ' ' + str(self.antal['A']) + 'A' 
        if self.antal['Fx'] > 0: ret += ' ' + str(self.antal['Fx']) + 'Fx' 
        ret += ' ' + str(self.ACE_bonus) + '(' + str(self.orig_bonus) + ') '
        ret += self.namn
        return ret

    # bonus kan vara tom strÃ¤ng, ACE Ã¤ndras nÃ¤r betygen sÃ¤tts
    def setbonus(self, bonus):
        try:
            self.ACE_bonus = int(bonus)
            self.orig_bonus = int(bonus)
        except:
            self.ACE_bonus = 0
            self.orig_bonus = 0

    # kontrollera att det Ã¤r 10 rÃ¤ttade resultat
    def check(self):
        return self.antal['F'] + self.antal['Fx']+ self.antal['E'] + self.antal['D'] + self.antal['C'] + self.antal['B'] + self.antal['A'] == 10

    def draEbonus(self, x):
        for i in range(x):
            if self.ACE_bonus <= 0:
                return False
            if self.ACE_bonus % 10 > 0:
                self.ACE_bonus -= 1
            elif self.ACE_bonus % 100 > 0:
                self.ACE_bonus -= 10
            elif self.ACE_bonus % 1000 > 0:
                self.ACE_bonus -= 100
            else:
                return False
        return True

    def draCbonus(self, x):
        for i in range(x):
            if self.ACE_bonus <= 0:
                return False
            if (self.ACE_bonus // 10) % 10 > 0:
                self.ACE_bonus -= 10
            elif (self.ACE_bonus // 100) % 100 > 0:
                self.ACE_bonus -= 100
            else:
                return False
        return True

    def draAbonus(self, x):
        for i in range(x):
            if self.ACE_bonus <= 0:
                return False
            if (self.ACE_bonus // 100) % 10 > 0:
                self.ACE_bonus -= 100
            else:
                return False
        return True


#############################################
# Parser
#
# FÃ¶rutsÃ¤tter en infil som ser ut om om inklistrad frÃ¥n rapp
#
# TEN1 Tentamen =    
# __Tentabetyg = E
# ____tentat =    
# __Omtenta =    
# ____bonustotal = 500
# __tenta mars 2015 =    
# ____Sal = D37
# ____t1 = E
# ...
# ____t10 = F

tilldelning  = re.compile('_.*(t\d\d?) = (A|B|C|D|E|Fx?)')
bonus  = re.compile('_.*(ACE-bonus) = (\d+)')

result = Result(" Mitt namn", "X99")
f = open(filnamn, 'r')
for line in f:
    tilldelat = tilldelning.match(line)
    if tilldelat:
        result.antal[tilldelat.group(2)] += 1
        if tilldelat.group(1) == 't7' and tilldelat.group(2) == 'D':
            result.antal['D+'] = 1

    b = bonus.match(line)
    if b:
        result.setbonus(b.group(2))
f.close()

#############################################
# Betyg
#
# 

betyg = ''

if result.antal['Fx'] == 1:           # Specialbehandla uppgift 4
    if result.antal['E'] > 2:
        if result.antal['C'] + result.antal['D'] + result.antal['B'] + result.antal['A'] + 10 * result.antal['E'] == 50:
            if result.draEbonus(4):
                betyg = 'E'
            else:
                betyg = 'Fx'
        else:
            betyg = 'Fx'
    else:
        betyg = 'F'
        
elif result.antal['E'] < 3:
    betyg = 'F'
elif result.antal['E'] == 4 or result.antal['E'] == 3:
    if result.draEbonus(4):
        betyg = 'Fx'
    else:
        betyg = 'F kan_bli_fx'
        
elif result.antal['E'] == 5:
    if result.draEbonus(4):
        betyg = 'E'
    else:
        betyg = 'F men_E_om_bonus'
        
if result.antal['E'] == 6 or betyg == 'E':
    betyg = 'E'
    # Betyg C och D
    if result.antal['C'] == 2:
        betyg = 'C'
    elif result.antal['C'] == 1 and result.antal['D'] == 0:
        if result.draCbonus(5):
            betyg = 'C'                
    elif result.antal['C'] == 1 and result.antal['D'] == 1:
        if result.antal['D+'] == 1:
            if result.draCbonus(1):   # Dra endast en bonus fÃ¶r uppgift 7
                betyg = 'C'
        elif result.draCbonus(2):
            betyg = 'C'
        else:
            betyg = 'D'
    elif result.antal['D'] == 2:
        if result.draCbonus(3):   # Dra en bonus fÃ¶r uppgift 7 och tvÃ¥ fÃ¶r uppgift 8
                betyg = 'C'
        else:
            betyg = 'D'
    elif result.antal['D'] == 1 and result.antal['C'] == 0:
        if result.draCbonus(5):
            betyg = 'D'                
        
    if betyg == 'C':
        
        # Betyg A och B    
        if result.antal['A'] == 2:
            betyg = 'A'
        elif result.antal['A'] == 1 and  result.antal['B'] == 0:
            if result.draAbonus(5):
                betyg = 'A'
        elif result.antal['A'] == 1 and  result.antal['B'] == 1:
            if result.draAbonus(2):
                betyg = 'A'
            else:
                betyg = 'B'
        elif result.antal['B'] == 2:
            if result.draAbonus(4):
                betyg = 'A'
            else:
                betyg = 'B'
        elif result.antal['B'] == 1 and  result.antal['A'] == 0:
            if result.draAbonus(5):
                betyg = 'B'
    
print (betyg, result)
