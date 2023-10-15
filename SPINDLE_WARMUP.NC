
T99 M6;

MSG_OK["Remove probe for charging", "put probe in charging cradle",""]

#100 = INPUT["Choose a tool for warmup","Tool number?","",1,97,4];

T#100 M6;

MSG_OK["Check for tool", "Confirm there is a tool in the spindle?",""]

#102 = 10 

#102 = 10
S2000 M3
G04 X[60*#102]
S4000 M3
G04 X[60*#102]
S6000 M3
G04 X[60*#102]

T99 M6;

MSG_OK["Reload the probe", "Put the probe back in the machine",""]

M30