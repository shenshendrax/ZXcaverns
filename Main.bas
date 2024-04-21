
 REM The Lost Caverns
# include <input.bas>
# include <print42.bas>


starter:

DIM Name AS STRING
DIM B AS STRING
DIM Race AS STRING
DIM direction AS STRING
DIM playerX AS BYTE = 1
DIM playerY AS BYTE = 1
DIM tempX AS BYTE = 1
DIM tempY AS BYTE = 1
DIM PLOTX AS BYTE = 1
DIM PLOTY AS BYTE = 1
DIM skill AS BYTE = 20
DIM power AS BYTE = 10
DIM HP AS BYTE = 10
DIM gold AS BYTE = 0
DIM keyexist AS UBYTE =0
DIM doorexist AS UBYTE =0 
DIM monsterexist AS BYTE=0
DIM genkey AS LONG=0
DIM doorgen AS LONG=0
DIM gengold AS LONG=0
DIM Mskill AS BYTE = 1
DIM Mpower AS BYTE = 1
DIM MHP AS BYTE = 1
DIM playerAttk AS BYTE=0
DIM MAttk AS BYTE=0
DIM playerDMG AS BYTE=0
DIM MDMG AS BYTE=0

 
REM MAIN 
    opening_credits()
    get_user_name()
 cls
 DATA 56,56,16,124,16,56,68,68
 LET p=USR "A" 
 FOR c=0 TO 7 
 READ a 
 POKE p+c,a 
 NEXT c 
 REM PRINT CHR$ 144
 PRINT " " 
 DATA 60, 66, 66, 82, 66, 66,126,0
 LET p=USR "D" 
 FOR c=0 TO 7 
 READ a 
 POKE p+c,a 
 NEXT c 
 REM PRINT CHR$ 147
 PRINT " "
 DATA 0,126,90,126,126,66, 90,126
 LET p=USR "M" 
 FOR c=0 TO 7 
 READ a 
 POKE p+c,a 
 NEXT c 
REM  PRINT CHR$ 156
  PRINT " "
 DATA   28, 20,  8,  8,  8, 24,  8, 56
 LET p=USR "K" 
 FOR c=0 TO 7 
 READ a 
 POKE p+c,a 
 NEXT c 
REM  PRINT CHR$ 154
 
 

 
 
 
 
 

     canvas_it_1()
     canvas_it_2()
     canvas_it_3()
     compass()
     stats()
     
     
  Looper: 
     show_player() 
     move_player()
     door_stuff()
     gold_stuff()
     key_stuff()
     monster_stuff()
     IF monsterexist=1 THEN
        battle()
         PAUSE 100
      ENDIF
     
     GOTO Looper:
     
     
 SUB opening_credits()
      BORDER 0: PAPER 0: FLASH 0: INK 6: CLS
      PRINT AT 1,8; BRIGHT 1;"THE LOST CAVERNS"
      PRINT ""
      PRINT ""
      PRINT "Following a cave-in you are now" 
      PRINT "trapped in an ancient dungeon." 
      PRINT ""
      PRINT "Find your way out of these "
      PRINT "dangerous caverns. ": 
      BEEP .05,4: BEEP .05,2: BEEP .05,0
 END SUB
 
 REM get user choices
 SUB get_user_name()
 get_user_name1: 
    PRINT AT 11,3; INK 5; "Who art thou?"
    PRINT "": PRINT "":
    PRINT AT 12,1; INK 2;" 1 : Human"
    PRINT AT 13,1; INK 2;" 2 : Elf"
    PRINT AT 14,1; INK 2;" 3 : Dwarf"
    PRINT AT 17,1; BRIGHT 1;"Select 1,2 or 3 :"
    Race= INPUT(1)
    IF Race="1" OR Race="2" OR Race="3" THEN GOTO get_user_2:
    GOTO get_user_name1:   

    REM get user choices x2
get_user_2:

   
    IF Race="1" THEN LET skill=10: IF Race="1" THEN LET HP=10: IF Race="1" THEN LET power=10: IF Race="1" THEN  B="the Human"
    IF Race="2" THEN LET skill=11: IF Race="2" THEN LET HP=5: IF Race="2" THEN LET power=6: IF Race="2" THEN  B="the Elf"
    IF Race="3" THEN LET skill=9: IF Race="3" THEN LET HP=16: IF Race="3" THEN LET power=16: IF Race="3" THEN  B="the Dwarf"
    INK 5: BRIGHT 0: PRINT "What is thy name?"
    LET Name=  INPUT(14)
    BEEP .05,9: BEEP .05,6: BEEP .05,7
END SUB





SUB canvas_it_1() 
    CLS
    BORDER 0: PAPER 0: INK 1: CLS
    FOR r=1 TO 12 STEP 3
    FOR c=1 TO 12 STEP 3
    PRINT AT r,c;"\::\:: "
    PRINT AT r+1,c;"\::\:: "
    NEXT c
    NEXT r
END SUB

SUB canvas_it_2()
 INK 7
 LET PLOTX=7
 LET PLOTY=167
  FOR R=1 TO 4
  FOR M=1 TO 4
 PLOT PLOTX,PLOTY
DRAW 17,0
DRAW 0,17
DRAW -17,0
DRAW 0,-17
 LET PLOTX=PLOTX+24
 NEXT M
 LET PLOTX=7
 LET PLOTY=PLOTY-24
 NEXT R
 
END SUB

SUB canvas_it_3()

  LET PLOTX=25
  LET PLOTY=175
  FOR n=1 TO 4
  FOR m=1 TO 3
  PLOT PLOTX,PLOTY
  DRAW 5,0
  LET PLOTX=PLOTX+24
  NEXT m
  LET PLOTX=25
  LET PLOTY=PLOTY-24
  NEXT n
   LET PLOTX=15
    LET PLOTY=165
    FOR n=1 TO 3
    FOR m=1 TO 4
    PLOT PLOTX,PLOTY
    DRAW 0,-5
    LET PLOTX=PLOTX+24
    NEXT m
    LET PLOTX=15
    LET PLOTY=PLOTY-24
    NEXT n
END SUB

SUB compass()
INVERSE 0:
PRINT AT 9,15; PAPER 4; INK 1;"N": 
PRINT AT 11,15; PAPER 4; INK 1;"S": 
PRINT AT 10,16; PAPER 4; INK 1;"E": 
PRINT AT 10,14; PAPER 4; INK 1;"W": 
PRINT AT 10,15; PAPER 4; INK 1;"+":
INK 7: CIRCLE 124,108,16
END SUB

SUB stats()
    INK 7:PAPER 2
    PRINTAT42(1,17)
    PRINT42(Name)
    INK 6
    PRINTAT42(2,17)
    PRINT42 (B)

    INK 6: PAPER 0:
    PRINTAT42 (3,17)
    PRINT42 ("Skill:") 
    PRINTAT42 (3,24) 
    INK 7
    PRINT42 STR(skill)
    INK 6
    PRINTAT42 (4,17)
    PRINT42 ("Power:") 
    PRINTAT42 (4,24) 
    INK 7
    PRINT42 STR(power)
    INK 6
    PRINTAT42 (5,17)
    PRINT42 ("Health:") 
    PRINTAT42 (5,24)
    INK 7 
    PRINT42 STR(HP)
    INK 6
    PRINTAT42 (6,17)
    PRINT42 ("Gold:") 
    PRINTAT42 (6,24)
    INK 7 
    PRINT42 STR(gold)
    INK 6
    PRINTAT42 (7,17)
    PRINT42 ("Items:") 
    
    IF keyexist=1 THEN
        PRINT AT 8,16; INK 6; "KEY" 
    ENDIF
        
   
END SUB

SUB show_player()
    PRINT AT playerX,playerY; PAPER 5;"  "
    PRINT AT playerX+1,playerY; PAPER 5;"  "
    PRINT AT playerX,playerY; PAPER 5; INK 0; CHR$ 144
    PRINTAT42(14,1)
    PRINT42("                     ")
    
    IF monsterexist=1 THEN
        PRINT AT playerX+1,playerY+1; PAPER 5; INK 2;CHR$ 156
   ENDIF 
   
   IF keyexist=1 THEN 
      PRINT AT 7,18;INK 7; CHR$ 154 
   ENDIF
    
END SUB

SUB move_player()
    PAPER 0
    LET tempX=playerX
    LET tempY=playerY
    move:
    PRINTAT42(13,1)
    PRINT42("Move which direction (n,s,e,w) ")
    PRINT AT 13,24; INK 7; "?"
    LET direction=INPUT(1)
    IF (direction="n" AND playerX<>1) THEN playerX=playerX-3
    IF (direction="s" AND playerX<>10) THEN  playerX=playerX+3
    IF (direction="w" AND playerY<>1) THEN  playerY=playerY-3
    IF (direction="e" AND playerY<>10) THEN  playerY=playerY+3
    PRINT AT tempX,tempY; PAPER 1;"  "
    PRINT AT tempX+1,tempY; PAPER 1;"  "
  
       
END SUB

SUB gold_stuff()

    RANDOMIZE
    
        LET gengold=INT(RND*100)
        IF gengold>=95 THEN
             LET gold=gold+INT(RND*6)+1
             PRINTAT42(14,1)
             PRINT42("You find some gold and pocket it.")
             PRINTAT42 (6,24)
             INK 7 
             PRINT42 STR(gold)
             BEEP .02,19
            PAUSE 100
        ENDIF
          PRINTAT42(14,1)
          PRINT42("                                        ")
    
   
END SUB

SUB key_stuff()

    RANDOMIZE
    IF keyexist=0 THEN
        LET genkey=INT(RND*100)
        IF genkey>=90 THEN
            keyexist=1
             PRINTAT42(14,1)
             PRINT42("You found a key! ")
             BEEP .02,19
            PAUSE 100
        ENDIF
    ENDIF
   
END SUB

SUB monster_stuff
    monsterexist=0
    RANDOMIZE
    LET genmonster=INT(RND*100) 
    IF genmonster>=80 THEN 
        monsterexist=1
        PRINT AT playerX,playerY; PAPER 5;"  "
        PRINT AT playerX+1,playerY; PAPER 5;"  "
        PRINT AT playerX,playerY; PAPER 5; INK 0;CHR$ 144
        PRINT AT playerX+1,playerY+1; PAPER 5; INK 2;CHR$ 156 
        PRINTAT42(14,1)
        PRINT42("You see a monster! ")
        BEEP .29,9: BEEP .25,3
        PAUSE 100 
    ENDIF
    
END SUB

SUB battle()
             PRINTAT42(15,1)
             PRINT42("You prepare to battle. ")
             PAUSE 100
             INK 7:PAPER 1
             LET Z$="ABADEFGHIAKLMNOPERSTUOTIYO"
             LET P$=""
             FOR A=1 TO 7
             LET R=INT (RND*26)+1
             LET P$=P$+Z$(R) 
             NEXT A
             
             
    PRINTAT42(1,28)
    PRINT42(P$)
    INK 7
    PRINTAT42(2,28)
    PRINT42 "The Monster"
    INK 7: PAPER 0:
    PRINTAT42 (3,28)
    PRINT42 ("Skill:") 
    PRINTAT42 (4,28) 
    PRINT42 ("Power:") 
    PRINTAT42 (5,28) 
    PRINT42 ("Health:") 
    RANDOMIZE
    LET Mskill=INT(RND*13)+1
    LET Mpower=INT(RND*13)+1 
    LET MHP=INT(RND*13)+1
    PRINTAT42 (3,36)
    PRINT42 STR(Mskill) 
    PRINTAT42 (4,36) 
    PRINT42 STR(Mpower) 
    PRINTAT42 (5,36) 
    PRINT42 STR(MHP) 
    
    REM fight begins
    fightloop: 
    PRINTAT42(14,1)
    PRINT42("                          ")
    PRINTAT42(15,1)
    PRINT42("                          ")
    PRINTAT42(16,1)
    PRINT42("                            ")
    PRINTAT42(17,1)
    PRINT42("                            ")
    playerAttk=skill+(INT(RND*12))
    MAttk=Mskill+(INT(RND*12))
  rem   PRINT at 19,24;(playerAttk) 
  rem   PRINT at 20,24;(MAttk) 
    PRINTAT42(14,1)
    PRINT42("You swing your sword...")
    PAUSE 100
    IF playerAttk>MAttk THEN

             
             playerDMG= INT(power/2) 
             PRINTAT42(15,1)
             PRINT42("You hit for ")
             PRINTAT42(15,15)
             PRINT42 STR(playerDMG)
             MHP=MHP-playerDMG
             PRINTAT42 (5,36) 
             PRINT42("  ")
             PRINT42 STR(MHP)
             PAUSE 100
             
             
             IF MHP<=0 
               GOTO winfight
             ENDIF
    ELSE 
        PRINTAT42(15,1)
             PRINT42("You miss. ")
    ENDIF
    
    PAUSE 100
    
    PRINTAT42(14,1)
    PRINT42("                        ")
    PRINTAT42(15,1)
    PRINT42("                        ")
       PRINTAT42(16,1)
    PRINT42("                            ")
    PRINTAT42(17,1)
    PRINT42("                           ")
    
    PRINTAT42(15,1)
    PRINT42("The Monster attacks you...")
     IF MAttk>playerAttk THEN

             
             MDMG= INT(Mpower/2) 
             PRINTAT42(16,1)
             PRINT42("Monster hits for ")
             PRINTAT42(16,21)
             PRINT42 STR(MDMG)
             HP=HP-MDMG
             PRINTAT42 (5,23) 
             PRINT42("  ")
             PRINTAT42 (5,24) 
             PRINT42("  ")
             PRINTAT42 (5,24)
             PRINT42 STR(HP)
             PAUSE 100
             
             
             IF HP<=0 
               GOTO losefight
             ENDIF
    ELSE 
        PRINTAT42(17,1)
             PRINT42("The Monster misses.")
    ENDIF
    
    
    PAUSE 100
    GOTO fightloop:
    
    
    
    
    REM fight over, clear up stuff
winfight:
    
    PAUSE 100
    monsterexist=0
    gold=gold+1
                 PRINTAT42 (6,24)
             INK 7 
             PRINT42 STR(gold)
    PRINTAT42(1,28)
    PRINT42("           ")
    PRINTAT42(2,28)
    PRINT42 ("           ")
    PRINTAT42 (3,28)
    PRINT42 ("            ") 
    PRINTAT42 (4,28) 
    PRINT42 ("          ") 
    PRINTAT42 (5,28) 
    PRINT42 ("            ") 
    PRINTAT42(14,1)
    PRINT42("                        ")
    PRINTAT42(15,1)
    PRINT42("                        ")
    PRINTAT42(15,1)
    PRINT42("You are victorious and continue...")
    PAUSE 100
      PRINTAT42(15,1)
    PRINT42("                                      ")
    
losefight: 
    IF HP<=0 
      CLS
       PRINT AT 5,11; INK 2; inverse 1; flash 1; bright 1;"GAME OVER"  
       FOR i=0 TO 5
         BEEP 0.1,i
         BEEP 0.1,16-i 
         BEEP .09,15
           NEXT i
         BEEP 0.2,1
       PRINT AT 9,0; INK 7; "Your epic journey has ended." 
       PRINT AT 12,0; INK 7 ;"Your final gold tally was:"; ink 6; gold 
      
      
      PAUSE 1000
      goto starter:
    ENDIF
    
END SUB



SUB door_stuff()

    RANDOMIZE
    
        LET doorgen=INT(RND*100)
        
        IF doorgen>=91 THEN
            doorexist=1
            PRINT AT playerX,playerY; PAPER 5;"  "
            PRINT AT playerX+1,playerY; PAPER 5;"  "
            PRINT AT playerX,playerY; PAPER 5; INK 0;CHR$ 144
            PRINT AT playerX+1,playerY; PAPER 5; INK 3;CHR$ 147 
    
             BEEP .02,19
             
        ENDIF
        
        IF (keyexist=1 AND doorexist=1) THEN 
                         PRINTAT42(16,1)
                    PRINT42("You see a door!")
                     PRINTAT42(17,1)
                   PRINT42("Using your key you unlock the door")
                   PAUSE 300
                   CLS


           PRINT AT 5,7; INK 2; inverse 1; flash 1; bright 1;"YOU ESCAPE!"  
           PRINT AT 7,5; INK 2; inverse 0; flash 0; bright 0;"CONGRATULATIONS." 
           
    
           
           
       PRINT AT 9,0; INK 7; "Your epic journey has ended." 
       PRINT AT 11,0; INK 7 ;"Your final gold tally was:"; ink 6; gold 
                    for f= 1 to 5
                    beep .1,30
                    beep .1,35
                    beep .1,40
                    beep .1,45
                    next f
             PAUSE 1000
             goto starter:
        ENDIF
            
        IF  (keyexist=0 AND doorexist=1) THEN
                        PRINT AT playerX,playerY; PAPER 5;"  "
            PRINT AT playerX+1,playerY; PAPER 5;"  "
            PRINT AT playerX,playerY; PAPER 5; INK 0;CHR$ 144
            PRINT AT playerX+1,playerY; PAPER 5; INK 3;CHR$ 147 
                      PRINTAT42(16,1)
             PRINT42("You see a door!")
             PRINTAT42(17,1)
             PRINT42("Without a key, the door won't open.")
             doorexist=0
             PAUSE 100
        ENDIF
        
    PRINTAT42(14,1)
    PRINT42("                        ")
    PRINTAT42(15,1)
    PRINT42("                        ")
    PRINTAT42(16,1)
    PRINT42("                          ")
    PRINTAT42(17,1)
    PRINT42("                                   ")
    PRINTAT42(18,1)
    PRINT42("                                   ")
  END SUB
  
