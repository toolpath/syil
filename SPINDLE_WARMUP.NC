
#101 = 10 (number of minutes at each speed)

S2000 M3

#100 = 1
(loop to get around max values for G04, so we can have a 10 minute dwell)
WHILE [#100 <= [60*#101]] 
    G04 P1000 (1 second)
    #100 = #100 + 1
END_WHILE

S4000 M3
#100 = 1
WHILE [#100 <= [60*#101]] 
    G04 P1000 (1 second)
    #100 = #100 + 1
END_WHILE

S6000 M3
#100 = 1
WHILE [#100 <= [60*#101]] 
    G04 P1000 (1 second)
    #100 = #100 + 1
END_WHILE

M30