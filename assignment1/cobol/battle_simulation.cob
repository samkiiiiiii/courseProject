\**********************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      *>   /*
 * CSC*> I3180 Principles of Programming Languages
 *
 * ---*>  Declaration ---
 *
 * I d*> eclare that the assignment here submitted is original except for source
 * mat*> erial explicitly acknowledged. I also acknowledge that I am aware of
 * Uni*> versity policy and regulations on honesty in academic work, and of the
 * dis*> ciplinary guidelines and procedures applicable to breaches of such policy
 * and*>  regulations, as contained in the website
 * htt*> p://www.cuhk.edu.hk/policy/academichonesty/
 *
 * Ass*> ignment 1
 * Nam*> e : Cheung Sam Ki
 * Stu*> dent ID : 1155131407
 * Ema*> il Addr : 1155131407@link.cuhk.edu.hk
 */
      **********************

       IDENTIFICATION DIVISION.
       PROGRAM-ID.  assignment-one.
       author.      Cheung Sam Ki.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT FILE_MY_SEQUENCE ASSIGN TO 'testcase/my_sequence.txt'
         ORGANIZATION IS LINE SEQUENTIAL
         FILE STATUS IS FS_MYSEQUENCE.

       SELECT FILE_MY_STATISTICS ASSIGN TO 
       'testcase/my_statistics.txt'
          ORGANIZATION IS LINE SEQUENTIAL
          FILE STATUS IS FS_MYSTAT.

       SELECT FILE_GRANDMONSTER_SEQUENCE ASSIGN TO
       'testcase/grandmaster_sequence.txt'
          ORGANIZATION IS LINE SEQUENTIAL
          FILE STATUS IS FS_GRANDSEQUENCE.

       SELECT FILE_GRANDMONSTER_STAT ASSIGN TO
       'testcase/grandmaster_statistics.txt'
          ORGANIZATION IS LINE SEQUENTIAL
          FILE STATUS IS FS_GRANDSTAT.

       SELECT FILE_EFECTIVE_RATIO ASSIGN TO
       'testcase/effectiveness_table.txt'
          ORGANIZATION IS LINE SEQUENTIAL
          FILE STATUS IS FS_EFFECTIVE_RATIO.

       SELECT FILE_TEST_OUTPUT ASSIGN TO 
       'testcase/battle_results.txt'
       ORGANIZATION IS LINE SEQUENTIAL
       FILE STATUS IS FS_TEST_OUTPUT.
       DATA DIVISION.
       FILE SECTION.
       FD  FILE_MY_SEQUENCE.
           01 My_Sequence.
               03  mysequence-name pic X(15).

       FD  FILE_MY_STATISTICS.
           01 MY_STAT.
               03 mystat-name pic X(15).
               03 mystat-Normal PIC X(8).
               03 mystat-health_point PIC 9(3).
               03 mystat-attack PIC 9(3).
               03 mystat-Defense PIC 9(3).
               03 mystat-speed PIC 9(3).
               03 mySKILL_1_ELEMENT pic X(8).
               03 mySKILL_1_DEMAGE PIC 9(3).
               03 mySKILL_2_ELEMENT PIC X(8).
               03 mySKILL_2_DEMAGE PIC 9(3).

       FD FILE_GRANDMONSTER_SEQUENCE.
           01 GRAND_SEQUENCE.
               03 GRAND-NAME PIC X(15).

       FD FILE_GRANDMONSTER_STAT.
           01 GRAND_STAT.
               03 grandstat-name pic X(15).
               03 grandstat-Normal PIC X(8).
               03 grandstat-health_point PIC 9(3).
               03 grandstat-attack PIC 9(3).
               03 grandstat-Defense PIC 9(3).
               03 grandstat-speed PIC 9(3).
               03 grandSKILL_1_ELEMENT pic X(8).
               03 grandSKILL_1_DEMAGE PIC 9(3).
               03 grandSKILL_2_ELEMENT PIC X(8).
               03 grandSKILL_2_DEMAGE PIC 9(3).


       FD FILE_EFECTIVE_RATIO.
           01 EFFECTIVE_RATIO.
               03 element PIC X(8).
               03 NORMAL PIC 9(1).9(1).
               03 FIRE PIC 9(1).9(1).
               03 WATER PIC 9(1).9(1).
               03 GRASS PIC 9(1).9(1).
               03 ELECTRIC PIC 9(1).9(1).
               03 ICE PIC 9(1).9(1).
               03 FIGHTING PIC 9(1).9(1).
               03 POISON PIC 9(1).9(1).
               03 GROUND PIC 9(1).9(1).
               03 FLYING PIC 9(1).9(1).
               03 PSYCHIC PIC 9(1).9(1).
               03 BUG PIC 9(1).9(1).
               03 ROCK PIC 9(1).9(1).
               03 GHOST PIC 9(1).9(1).
               03 DRAGON PIC 9(1).9(1)9.
               03 DARK PIC 9(1).9(1).
               03 STEEL PIC 9(1).9(1).
               03 FAIRY PIC 9(1).9(1).

       FD FILE_TEST_OUTPUT.
           01 RESULT.
               03 MY_MONSTER PIC X(15).
               03 GRAND_MONSTER PIC X(15).
               03 winner PIC 9(1).



       WORKING-STORAGE SECTION.
       01 FS_MYSEQUENCE PIC 99.
       01 FS_MYSTAT PIC 99.
       01 FS_GRANDSEQUENCE PIC 99.
       01 FS_GRANDSTAT PIC 99.
       01 FS_EFFECTIVE_RATIO PIC 99.
       01 FS_TEST_OUTPUT PIC 99.
       01 EFFECTIVE_RATIO_VALUE PIC 9V9 VALUE 0.
       01 LOL PIC 9V9.
       01 FINAL_DEMAGE PIC 999V999.
       01 FINAL_DEMAGE_ONE PIC 999V999.
       01 FINAL_DEMAGE_TWO PIC 999V999.
       01 WHO-ATTACK PIC X(1) VALUES 'G'.
       01 WS-mybattle.
               10  battle_myname pic X(15).
               10  battle_myNormal PIC X(8).
               10  battle_myhealth_point PIC S9(3).
               10  battle_myattack PIC 9(3).
               10  battle_myDefense PIC 9(3).
               10  battle_myspeed PIC 9(3).
               10  battle_mySKILL_1_ELEMENT pic X(8).
               10  battle_mySKILL_1_DEMAGE PIC 9(3).
               10  battle_mySKILL_2_ELEMENT PIC X(8).
               10  battle_mySKILL_2_DEMAGE PIC 9(3).
       01 WS-grandbattle.
               10  battle_grandname pic X(15).
               10  battle_grandNormal PIC X(8).
               10  battle_grandhealth_point PIC S9(3).
               10  battle_grandattack PIC 9(3).
               10  battle_grandDefense PIC 9(3).
               10  battle_grandspeed PIC 9(3).
               10  battle_grandSKILL_1_ELEMENT pic X(8).
               10  battle_grandSKILL_1_DEMAGE PIC 9(3).
               10  battle_grandSKILL_2_ELEMENT PIC X(8).
               10  battle_grandSKILL_2_DEMAGE PIC 9(3).

       01 BATTLE_END PIC X(1) VALUES 'N'.
       01 TEST_ROUND PIC 9(2) VALUES 0.
       01 TEST_HEALTHPOINT PIC S9(3) VALUE 0.
       


       PROCEDURE DIVISION.
       MAIN-PARAGRAPH.
            PERFORM CHECK-FILE-EXIST.
            PERFORM FIND-NEXT-MONSTER-TOBATTLE.
       STOP RUN.

       CHECK-FILE-EXIST.
           OPEN INPUT FILE_MY_SEQUENCE.
           IF  FS_MYSEQUENCE = 35 THEN
               DISPLAY 'my_sequence.txt not exist'.
           CLOSE FILE_MY_SEQUENCE.

           OPEN INPUT FILE_MY_STATISTICS.
           IF FS_MYSTAT = 35 THEN
               DISPLAY 'my_statistic.txt not exist'.
           CLOSE FILE_MY_STATISTICS.

           OPEN INPUT FILE_GRANDMONSTER_STAT.
           IF FS_GRANDSTAT = 35 THEN
               DISPLAY 'grandmaster_sequence.txt not exist'.
           CLOSE FILE_GRANDMONSTER_STAT.


           OPEN INPUT FILE_GRANDMONSTER_SEQUENCE.
           IF FS_GRANDSEQUENCE = 35 THEN 
               DISPLAY 'grandmaster_stat.txt not exist'.
           CLOSE FILE_GRANDMONSTER_SEQUENCE.

           OPEN  INPUT FILE_EFECTIVE_RATIO.
           IF FS_EFFECTIVE_RATIO = 35 THEN
               DISPLAY 'EFFECTIVE_RATIO.TXT NOT EXIST'.
           CLOSE FILE_EFECTIVE_RATIO.
    
           OPEN OUTPUT FILE_TEST_OUTPUT.
           IF FS_TEST_OUTPUT = 35 THEN
               DISPLAY 'output.txt not exist'.
           CLOSE FILE_TEST_OUTPUT.
          

    

       FIND-NEXT-MONSTER-TOBATTLE.
           OPEN INPUT FILE_MY_SEQUENCE.
           OPEN INPUT FILE_GRANDMONSTER_SEQUENCE.
           OPEN OUTPUT FILE_TEST_OUTPUT.
           PERFORM FIND-NEXT-MYMONSTER.
           PERFORM FIND-NEXT-GRANDMONSTER.
           PERFORM DECIDE_THE_ATTACK.
           PERFORM BATTLE-MAIN-LOGIC.
           CLOSE FILE_GRANDMONSTER_SEQUENCE.
           CLOSE FILE_MY_SEQUENCE.
           CLOSE FILE_TEST_OUTPUT.

       BATTLE-MAIN-LOGIC.
           IF BATTLE_END = 'N'
              IF WHO-ATTACK='M'   
                 
                 PERFORM MY-ATTACK-AROUND
                 COMPUTE battle_grandhealth_point = 
                 battle_grandhealth_point- FINAL_DEMAGE
                 MOVE 'G' TO WHO-ATTACK
                 IF battle_grandhealth_point <= 0 
                      PERFORM WRITE_RESULT_MY
                      PERFORM FIND-NEXT-GRANDMONSTER
                 END-IF
                 IF battle_grandhealth_point > 0 
                     PERFORM BATTLE-MAIN-LOGIC
                 END-IF
              END-IF
              IF WHO-ATTACK ='G'

                 PERFORM GRAND-ATTACK-ROUND
                 COMPUTE battle_myhealth_point = 
                 battle_myhealth_point - FINAL_DEMAGE
                 MOVE 'M' TO WHO-ATTACK
                 IF battle_myhealth_point <= 0 
                      PERFORM WRITE-RESULT_GRAND
                      PERFORM FIND-NEXT-MYMONSTER
                      
                 END-IF
                 IF battle_myhealth_point > 0
                      PERFORM BATTLE-MAIN-LOGIC
                 END-IF
              END-IF
           END-IF.


       WRITE_RESULT_MY.
          
          MOVE battle_myname TO MY_MONSTER.
          MOVE battle_grandname TO GRAND_MONSTER.
          MOVE 1 TO winner.
          WRITE RESULT.
          

       WRITE-RESULT_GRAND.
          MOVE battle_myname TO MY_MONSTER.
          MOVE battle_grandname TO GRAND_MONSTER.
          MOVE 2 TO winner.
          WRITE RESULT.


       FIND-NEXT-MYMONSTER.
          READ FILE_MY_SEQUENCE INTO My_Sequence 
          IF FS_MYSEQUENCE = 10 THEN
             MOVE 'Y' TO BATTLE_END
          END-IF.
          IF FS_MYSEQUENCE = 00 THEN
              OPEN INPUT FILE_MY_STATISTICS
              PERFORM COMPARE_WITH_MYSEQUENCE
              CLOSE FILE_MY_STATISTICS
          END-IF.

       COMPARE_WITH_MYSEQUENCE.

            READ FILE_MY_STATISTICS INTO MY_STAT
            IF FS_MYSTAT = 00 THEN 
              IF mysequence-name = mystat-name THEN
                     MOVE mystat-name TO battle_myname
                     MOVE mystat-Normal TO battle_myNormal
                     MOVE mystat-health_point TO battle_myhealth_point
                     MOVE mystat-attack TO battle_myattack
                     MOVE mystat-Defense TO battle_myDefense
                     MOVE mystat-speed TO battle_myspeed
                     MOVE mySKILL_1_ELEMENT TO battle_mySKILL_1_ELEMENT
                     MOVE mySKILL_1_DEMAGE TO battle_mySKILL_1_DEMAGE
                     MOVE mySKILL_2_ELEMENT TO battle_mySKILL_2_ELEMENT
                     MOVE mySKILL_2_DEMAGE TO battle_mySKILL_2_DEMAGE
                END-IF
                IF mysequence-name NOT = mystat-name THEN
                      PERFORM COMPARE_WITH_MYSEQUENCE
                END-IF
            END-IF.

       FIND-NEXT-GRANDMONSTER.
            READ FILE_GRANDMONSTER_SEQUENCE INTO GRAND_SEQUENCE
            IF FS_GRANDSEQUENCE = 10 THEN
                MOVE 'Y' TO BATTLE_END
             END-IF.
            IF FS_GRANDSEQUENCE = 00 THEN
                OPEN INPUT FILE_GRANDMONSTER_STAT
                PERFORM COMPARE_WITH_GRANDSEQUENCE
                CLOSE FILE_GRANDMONSTER_STAT
            END-IF.


       COMPARE_WITH_GRANDSEQUENCE.
            READ FILE_GRANDMONSTER_STAT INTO GRAND_STAT
            IF FS_GRANDSTAT = 00 THEN
                IF GRAND-NAME = grandstat-name THEN
                     MOVE grandstat-name TO battle_grandname
                     MOVE grandstat-Normal TO battle_grandNormal
                     MOVE grandstat-health_point TO 
                     battle_grandhealth_point
                     MOVE grandstat-attack TO battle_grandattack
                     MOVE grandstat-Defense TO battle_grandDefense
                     MOVE grandstat-speed TO battle_grandspeed
                     MOVE grandSKILL_1_ELEMENT TO 
                     battle_grandSKILL_1_ELEMENT
                     MOVE grandSKILL_1_DEMAGE TO 
                     battle_grandSKILL_1_DEMAGE
                     MOVE grandSKILL_2_ELEMENT TO 
                     battle_grandSKILL_2_ELEMENT
                     MOVE grandSKILL_2_DEMAGE TO 
                     battle_grandSKILL_2_DEMAGE
                END-IF
                IF GRAND-NAME NOT= grandstat-name THEN
                      PERFORM COMPARE_WITH_GRANDSEQUENCE
                END-IF
            END-IF.
            

       DECIDE_THE_ATTACK.
            IF battle_myspeed > battle_grandspeed
              MOVE 'G' TO WHO-ATTACK
            END-IF.
            IF battle_grandspeed <= battle_myspeed
              MOVE 'M' TO WHO-ATTACK
            END-IF.

       MY-ATTACK-AROUND.
            OPEN INPUT FILE_EFECTIVE_RATIO.
            PERFORM MY_EFFECTIVE_RATION_ONE.
            COMPUTE FINAL_DEMAGE_ONE =  battle_mySKILL_1_DEMAGE *
            battle_myattack/ battle_grandDefense * EFFECTIVE_RATIO_VALUE.
            CLOSE FILE_EFECTIVE_RATIO.

            OPEN INPUT FILE_EFECTIVE_RATIO.
            PERFORM MY_EFFECTIVE_RATION_TWO.
            COMPUTE FINAL_DEMAGE_TWO =  battle_mySKILL_2_DEMAGE *
            battle_myattack/ battle_grandDefense * EFFECTIVE_RATIO_VALUE.
            CLOSE FILE_EFECTIVE_RATIO.
            MOVE FINAL_DEMAGE_ONE TO FINAL_DEMAGE.
            IF FINAL_DEMAGE_TWO > FINAL_DEMAGE_ONE THEN
                 MOVE FINAL_DEMAGE_TWO TO FINAL_DEMAGE.
            END_IF.


       GRAND-ATTACK-ROUND.
            OPEN INPUT FILE_EFECTIVE_RATIO.
            PERFORM GRAND_EFFECTIVE_RATIO_ONE.
            
            COMPUTE FINAL_DEMAGE_ONE = battle_grandSKILL_1_DEMAGE * 
            battle_grandattack/ battle_myDefense * EFFECTIVE_RATIO_VALUE.
            CLOSE FILE_EFECTIVE_RATIO.

            OPEN INPUT FILE_EFECTIVE_RATIO.
            PERFORM GRAND_EFFECTIVE_RATIO_TWO.
            COMPUTE FINAL_DEMAGE_TWO = (battle_grandSKILL_2_DEMAGE * 
            battle_grandattack)/battle_myDefense * EFFECTIVE_RATIO_VALUE.
            
            CLOSE FILE_EFECTIVE_RATIO.
            MOVE FINAL_DEMAGE_ONE TO FINAL_DEMAGE.
            IF FINAL_DEMAGE_TWO > FINAL_DEMAGE_ONE THEN
                 MOVE FINAL_DEMAGE_TWO TO FINAL_DEMAGE.
            END_IF.


       MY_EFFECTIVE_RATION_ONE.
            READ FILE_EFECTIVE_RATIO INTO EFFECTIVE_RATIO
            IF element = battle_mySKILL_1_ELEMENT THEN
              IF grandstat-Normal = 'Normal' THEN
                  MOVE NORMAL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Fire' THEN
                 MOVE FIRE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Water' THEN
                 MOVE WATER TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Grass' THEN
                 MOVE GRASS TO EFFECTIVE_RATIO_VALUE
               
              END-IF
              IF grandstat-Normal = 'Electric' THEN
                 MOVE ELECTRIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Ice' THEN
                 MOVE ICE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Fighting' THEN
                 MOVE FIGHTING TO EFFECTIVE_RATIO_VALUE
              END-IF              
              IF grandstat-Normal = 'Poison' THEN
                 MOVE POISON TO EFFECTIVE_RATIO_VALUE
              END-IF

              IF grandstat-Normal = 'Ground' THEN
                 MOVE GROUND TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Flying' THEN
                 MOVE FLYING TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Psychic' THEN
                 MOVE PSYCHIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Bug' THEN
                 MOVE BUG TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Rock' THEN
                 MOVE ROCK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Ghost' THEN
                 MOVE GHOST TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Dragon' THEN
                 MOVE DRAGON TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Dark' THEN
                 MOVE DARK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Steel' THEN
                 MOVE STEEL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Fairy' THEN
                 MOVE FAIRY TO EFFECTIVE_RATIO_VALUE
              END-IF                                                      
            END-IF.
          IF element NOT = battle_mySKILL_1_ELEMENT THEN
              PERFORM MY_EFFECTIVE_RATION_ONE
          END-IF.

       MY_EFFECTIVE_RATION_TWO.
            READ FILE_EFECTIVE_RATIO INTO EFFECTIVE_RATIO
            IF element = battle_mySKILL_2_ELEMENT THEN
              IF grandstat-Normal = 'Normal' THEN
                  MOVE NORMAL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Fire' THEN
                 MOVE FIRE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Water' THEN
                 MOVE WATER TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Grass' THEN
                 MOVE GRASS TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Electric' THEN
                 MOVE ELECTRIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Ice' THEN
                 MOVE ICE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Fighting' THEN
                 MOVE FIGHTING TO EFFECTIVE_RATIO_VALUE
              END-IF              
              IF grandstat-Normal = 'Poison' THEN
                 MOVE POISON TO EFFECTIVE_RATIO_VALUE
              END-IF

              IF grandstat-Normal = 'Ground' THEN
                 MOVE GROUND TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Flying' THEN
                 MOVE FLYING TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Psychic' THEN
                 MOVE PSYCHIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Bug' THEN
                 MOVE BUG TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Rock' THEN
                 MOVE ROCK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Ghost' THEN
                 MOVE GHOST TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Dragon' THEN
                 MOVE DRAGON TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Dark' THEN
                 MOVE DARK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Steel' THEN
                 MOVE STEEL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF grandstat-Normal = 'Fairy' THEN
                 MOVE FAIRY TO EFFECTIVE_RATIO_VALUE
              END-IF                                                      
            END-IF.
          IF element NOT = battle_mySKILL_2_ELEMENT THEN
              PERFORM MY_EFFECTIVE_RATION_TWO
          END-IF.
       GRAND_EFFECTIVE_RATIO_ONE.
          READ FILE_EFECTIVE_RATIO INTO EFFECTIVE_RATIO
            IF battle_grandSKILL_1_ELEMENT = element
              IF mystat-Normal = 'Normal' THEN
                  MOVE NORMAL TO EFFECTIVE_RATIO_VALUE
              END-IF
              
              IF mystat-Normal = 'Fire' THEN
                 MOVE FIRE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Water' THEN
                 MOVE WATER TO EFFECTIVE_RATIO_VALUE
              END-IF
             
              IF mystat-Normal = 'Grass' THEN
                 MOVE GRASS TO EFFECTIVE_RATIO_VALUE
              END-IF
            
              IF mystat-Normal = 'Electric' THEN
                 MOVE ELECTRIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Ice' THEN
                 MOVE ICE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Fighting' THEN
                 MOVE FIGHTING TO EFFECTIVE_RATIO_VALUE
              END-IF              
              IF mystat-Normal = 'Poison' THEN
                 MOVE POISON TO EFFECTIVE_RATIO_VALUE
              END-IF

              IF mystat-Normal = 'Ground' THEN
                 MOVE GROUND TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Flying' THEN
                 MOVE FLYING TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Psychic' THEN
                 MOVE PSYCHIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Bug' THEN
                 MOVE BUG TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Rock' THEN
                 MOVE ROCK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Ghost' THEN
                 MOVE GHOST TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Dragon' THEN
                 MOVE DRAGON TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Dark' THEN
                 MOVE DARK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Steel' THEN
                 MOVE STEEL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Fairy' THEN
                 MOVE FAIRY TO EFFECTIVE_RATIO_VALUE
              END-IF 

          END-IF.
          IF element NOT = grandstat-Normal THEN
              PERFORM GRAND_EFFECTIVE_RATIO_ONE
          END-IF. 


          GRAND_EFFECTIVE_RATIO_TWO.
          READ FILE_EFECTIVE_RATIO INTO EFFECTIVE_RATIO
            IF battle_grandSKILL_2_ELEMENT = element
              IF mystat-Normal = 'Normal' THEN
                  MOVE NORMAL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Fire' THEN
                 MOVE FIRE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Water' THEN
                 MOVE WATER TO EFFECTIVE_RATIO_VALUE
              END-IF

              IF mystat-Normal = 'Grass' THEN
                 
                 MOVE GRASS TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Electric' THEN
                 MOVE ELECTRIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Ice' THEN
                 MOVE ICE TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Fighting' THEN
                 MOVE FIGHTING TO EFFECTIVE_RATIO_VALUE
              END-IF              
              IF mystat-Normal = 'Poison' THEN
                 MOVE POISON TO EFFECTIVE_RATIO_VALUE
              END-IF

              IF mystat-Normal = 'Ground' THEN
                 MOVE GROUND TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Flying' THEN
                 MOVE FLYING TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Psychic' THEN
                 MOVE PSYCHIC TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Bug' THEN
                 MOVE BUG TO EFFECTIVE_RATIO_VALUE  
              END-IF
              IF mystat-Normal = 'Rock' THEN
                 MOVE ROCK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Ghost' THEN
                 MOVE GHOST TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Dragon' THEN
                 MOVE DRAGON TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Dark' THEN
                 MOVE DARK TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Steel' THEN
                 MOVE STEEL TO EFFECTIVE_RATIO_VALUE
              END-IF
              IF mystat-Normal = 'Fairy' THEN
                 MOVE FAIRY TO EFFECTIVE_RATIO_VALUE
              END-IF 
          END-IF.
          IF element NOT = grandstat-Normal THEN
              PERFORM GRAND_EFFECTIVE_RATIO_TWO
          END-IF.


          GRAND_ATTACK_DEFENDER.
              COMPUTE battle_myhealth_point = 
              battle_myhealth_point- FINAL_DEMAGE.



