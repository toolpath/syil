
T99 M6;

MSG_OK["Remove probe for charging", "put probe in charging cradle",""]

#100 = INPUT["Choose a tool for warmup","Tool number?","",1,97,4];

T#100 M6;

MSG_OK["Check for tool", "Confirm there is a tool in the spindle?",""]

#102 = 60 (number of minutes at each speed)

S3000 M3
#100 = 1
WHILE [#100 <= [60*#102]] 
    G04 P1000 (1 second)
    #100 = #100 + 1
END_WHILE

S6000 M3
#100 = 1
WHILE [#100 <= [60*#102]] 
    G04 P1000 (1 second)
    #100 = #100 + 1
END_WHILE

T99 M6;

MSG_OK["Reload the probe", "Put the probe back in the machine",""]

M30;

