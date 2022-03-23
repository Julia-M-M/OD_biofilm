#Open file
file = []
with open("/Users/jmm/Desktop/Doctorado/OXFORD/4_Metadata/BIGSdb_040603_1365734700_35217.txt") as file:
data = file.readlines()

print(data) 


# Set variables
"""
column = 0
id=[]
for x in data:
    id.append(x.split()[column])
print(id)

column = 1
OD_neg_control=[]
for x in data:
    OD_neg_control.append(x.split()[column])
print(OD_neg_control)

column = 2
OD_neg_control_SD=[]
for x in data:
    OD_neg_control_SD.append(x.split()[column])
print(OD_neg_control_SD)
"""

id = 7376
OD_neg_control = -0.000514644
OD_neg_control_SD = 0.002276625
OD_sample = 0.042475897


# ODc formula
def ODc_formula(OD_neg_control, OD_neg_control_SD):
    ODc = OD_neg_control + (3*OD_neg_control_SD)
    return ODc

for id in data: 
    ODc = ODc_formula(OD_neg_control, OD_neg_control_SD)
    print(ODc)


# Biofilm production conditions
def biofilm_production_formula(OD_sample, ODc):
    if OD_sample <= ODc:
        return "none"

    elif ODc < OD_sample and OD_sample <= 2*ODc:
        return "low"

    elif 2*ODc < OD_sample and OD_sample <= 4*ODc:
        return "medium"

    elif 4*ODc < OD_sample:
        return "high"

    else:
        return "null"

for id in data: 
    biofilm_production = biofilm_production_formula(OD_sample, ODc)
    print(biofilm_production)


# Output
print("id\tbiofilm_production\n", id, biofilm_production_result)
