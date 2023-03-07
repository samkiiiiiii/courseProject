/*
* CSCI3180 Principles of Programming Languages
*
* --- Declaration ---
*
* I declare that the assignment here submitted is original except for source
* material explicitly acknowledged. I also acknowledge that I am aware of
* University policy and regulations on honesty in academic work, and of the
* disciplinary guidelines and procedures applicable to breaches of such policy
* and regulations, as contained in the website
* http://www.cuhk.edu.hk/policy/academichonesty/
*
* Assignment 1
* Name : Cheung Sam Ki
* Student ID : 1155131407
* Email Addr : 1155131407@link.cuhk.edu.hk
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
char *strcat(char *dest, const char *src);
char *strcpy(char *dest, const char *src);
void myMonster();
void grandMonster();
void decide_theAttacker();
void define_effectiveRatio();
float choose_the_skill();
float effective_ratio(char attack_element[15],char defense_element[15]);
void attack_the_defender(float demage);
void swap();
void result();
// vaiable used in whole program
struct monster{
	char name[16];
	char element[9];
	float health_point;
	int attack;
	int defense;
	int speed;
	char skill_1_element[9];
	int skill_1_demage;
	char skill_2_element[9];
	int skill_2_demage;
};
char element[18][15] = {"Normal","Fire","Water","Grass","Electric","Ice","Fighting","Poison","Ground","Flying","Psychic",
					"Bug","Rock","Ghose","Dragon","Dark","Steel","Fairy"};
float ratio_skill[18][18];

// the monster for battle
struct monster my_monster[6];
struct monster grand_monster[6];
//default grand_monster attack first
struct monster *attack = grand_monster;
struct monster *defense = my_monster;

// the number of the monster
int num_Mymonster=0;
int num_grandMonster=0;

int total_my_monster = 0;
int total_grand_monster = 0;
int test_round =0;


int main(){
// create two struct array

myMonster();
grandMonster();

define_effectiveRatio();

//Battle 
// decide who attack first
decide_theAttacker();
while (test_round <100){
  // printf("attack name: %s\n",attack->name );
  // printf("defense name:  %s\n",defense->name );
  test_round ++;
	float demage = choose_the_skill();
	attack_the_defender(demage);
	if (0 >= defense -> health_point){
        result();
      // my_monster lose
      // printf("%d\n",attack );
      // printf("%d\n",grand_monster );
      // printf("%d\n",defense );
      // printf("%d\n", &grand_monster[0]);
      // printf("%s\n",attack -> name );
     if (attack == &grand_monster[num_grandMonster]){
      // printf("first \n\n");
           num_Mymonster++;;
          if (total_my_monster == num_Mymonster){
            
            exit(0);
         }
         else{
             
             defense = &my_monster[num_Mymonster];
             
          
         }
     }
     // // my_monster win
     else{
      num_grandMonster++;
        // printf("second \n\n");
        if(total_grand_monster == num_grandMonster){

            exit(0);
        }
        else{
            
            defense = &grand_monster[num_grandMonster];
        }
     }
    // the defense is the last element of the array

	}

 // printf("%s\n",attack -> name );
   // printf("Defense name %s Health point %d\n", defense->name,defense-> health_point );
    swap();

}
//round end
// result();

}
//question one: can i check the pointer point to which array
//question two: can i check it is the last element of the array


//round end
void result(){
	//problem: the name repeat
     char result[32];
     int c;
      // my_monster lose
     if (attack == &grand_monster[num_grandMonster]){
      strcpy(result,defense -> name);
      strcat(result,attack -> name);
      strcat(result,"2\0");
     }
     // // my_monster win
     else{
      strcpy(result,attack->name);
       strcat(result,defense->name);
       strcat(result,"1\0");
     }
        FILE *fp = fopen("testcase/battle_results.txt", "a");
      if (fp == NULL){
       //  code 
        printf("file cannot open in write sequence%s\n");
        exit(1);
      }

   fprintf(fp, "%s\n",result );
printf("%s\n",result );
   fclose (fp);
     //  //check the monster point to which array
     //  printf("%s\n",attack->name );
      // char result[31] = attack->name;
      // strcat(result,attack->name)


}


//battle
void swap(){
struct monster *tmp = attack;
	attack = defense;
	defense = tmp;
}

// attack the defender
void attack_the_defender(float demage){
	// deduct the health point
	defense -> health_point = defense -> health_point - demage;
//      printf("demage %f\n", demage);
//      printf("%d\n",defense -> health_point);
}

// attacker choose the skill
float choose_the_skill(){
	float final_demage = 0;

  int skill_demage[2] ={attack -> skill_1_demage , attack -> skill_2_demage};
  char skill_element[2][9];

  // version two
 // char buffer[20];
 // itoa(attack->skill_1_demage,buffer,10);
 // strcpy(skill_demage[0],buffer);
 // itoa(attack->skill_2_demage,buffer,10);
 // strcpy(skill_demage[1],buffer);

 strcpy(skill_element[0], attack -> skill_1_element);
  strcpy(skill_element[1], attack -> skill_2_element);
  for (int i = 0; i < 2; ++i){
  //   /* code */

    double sum = 0;
    sum = skill_demage[i] * (double)attack -> attack / (double)defense->defense * effective_ratio(skill_element[i], defense->element);
    // printf("skill_demage %d\n",skill_demage[i]  );
    // printf("attack -> attack %f\n",(double)attack -> attack );
    // printf("defense->defense %f\n", (double)defense->defense);
    // printf("effective_ratio %f\n", effective_ratio(skill_element[i], defense->element));
    if (sum > final_demage){
      /* code */
      final_demage = sum;
    }
  }
	// edit
	final_demage = roundf(final_demage*1000)/1000;
  // printf("%f\n",final_demage );
	return final_demage;
}
float effective_ratio(char attack_element[15],char defense_element[15]){
  int i=0,j=0;
	for ( i = 0; i < 18; ++i)
	{
		if (strncmp(attack_element, element[i],strlen(element[i]))==0){
			 // code 
        break;}
}
    for ( j = 0; j < 18; ++j)
  {
    if (strncmp(defense_element, element[j],strlen(element[j]))==0)
    {
       // code 
      break;
    }
  }
  // printf("%s  %s\n",attack_element, defense_element );
	return ratio_skill[i][j];
}
void decide_theAttacker(){
	if(my_monster[0].speed >= grand_monster[0].speed){
		attack = my_monster;
    defense = grand_monster;
	}

}


//init()
void myMonster(){
    FILE *fp = fopen("testcase/my_sequence.txt", "r");
    int numMonster = 0;
  
    if(fp == NULL) {
          printf("Uable to open the file"); 
          exit(1);
     }
    char line[256],line_stat[256];
    int check = 0;
    while (fgets(line, sizeof(line), fp)) {
    	//need to mondifys
        total_my_monster = total_my_monster + 1;
    	FILE *fp_mystat = fopen("testcase/my_statistics.txt", "r");
      if(fp_mystat == NULL) {
          printf("Uable to open the file"); 
          exit(1);
     }
          while (fgets(line_stat, sizeof(line_stat), fp_mystat)) {

          	char health_point[4];
          	char attack[4];
          	char defense[4];
       		char name[16];
       		char speed[4];
       		char skill_1_demage[4];
       		char skill_2_demage[4];
       		for (int i = 0; i < 15; i++){
      			name[i] = line_stat[i];
        	}
        	if (strncmp(line, name, 15) ==0){

        	struct monster *m1= (struct monster*)malloc(sizeof(struct monster));
        	for (int i = 0; i < 15; i++){
      			m1->name[i] = line_stat[i];
        	}

			m1->name[15] = '\0';
			for (int i = 15; i < 23; i++){
      			m1->element[i-15] = line_stat[i];
        	}
        	m1->element[8] = '\0';
            for (int i =23 ; i < 26; i++){
                health_point[i-23] = line_stat[i];
            }
            health_point[3] = '\0';
            m1 -> health_point = atoi(health_point);

            for (int i =26 ; i < 29; i++){
                attack[i-26] = line_stat[i];
            }
           attack[3] = '\0';
			     m1 -> attack = atoi(attack);
                  for (int i =29 ; i < 32; i++){
                defense[i-29] = line_stat[i];
            }
            defense[3] = '\0';
            m1 -> defense = atoi(defense);

            for (int i =32 ; i < 35; i++){
                speed[i-32] = line_stat[i];
            }
            speed[3] = '\0';
			m1 -> speed = atoi(speed);
            for (int i =35 ; i < 43; i++){
                m1->skill_1_element[i-35] = line_stat[i];
            }
            m1->skill_1_element[8] = '\0';

            for (int i =43 ; i < 46; i++){
               skill_1_demage[i-43] = line_stat[i];
            }
            skill_1_demage[3] = '\0';
			m1 -> skill_1_demage = atoi(skill_1_demage);
            for (int i =46 ; i < 54; i++){
                m1->skill_2_element[i-46] = line_stat[i];
            }
            m1->skill_2_element[8] = '\0';

            for (int i =54 ; i < 57; i++){
                skill_2_demage[i-54] = line_stat[i];
            }
            skill_2_demage[3] = '\0';
            m1 -> skill_2_demage = atoi(skill_2_demage);
   			my_monster[numMonster] = *m1;
   			numMonster += 1;
        	}

    	}
    	fclose(fp_mystat);
       
	}
 fclose(fp);
}

void grandMonster(){
   FILE *fp = fopen("testcase/grandmaster_sequence.txt", "r");
    int numMonster = 0;
  
    if(fp == NULL) {
          printf("Uable to open the file"); 
          exit(1);
     }
    char line[256],line_stat[256];
    int check = 0;
    while (fgets(line, sizeof(line), fp)) {
    	//need to mondify
        total_grand_monster =total_grand_monster + 1;
    	FILE *fp_mystat = fopen("testcase/grandmaster_statistics.txt", "r");
          while (fgets(line_stat, sizeof(line_stat), fp_mystat)) {
            
          	char health_point[4];
          	char attack[4];
          	char defense[4];
       		char name[16];
       		char speed[4];
       		char skill_1_demage[4];
       		char skill_2_demage[4];
       		for (int i = 0; i < 15; i++){
      			name[i] = line_stat[i];
        	}
        	if (strncmp(line, name, 15) ==0){
        		// printf("%s\n",name );
        	struct monster *m1= (struct monster*)malloc(sizeof(struct monster));
        	for (int i = 0; i < 15; i++){
      			m1->name[i] = line_stat[i];
        	}
			m1->name[15] = '\0';
			for (int i = 15; i < 23; i++){
      			m1->element[i-15] = line_stat[i];
        	}
        	m1->element[8] = '\0';
            for (int i =23 ; i < 26; i++){
                health_point[i-23] = line_stat[i];
            }
            health_point[3] = '\0';
            m1 -> health_point = atoi(health_point);
            for (int i =26 ; i < 29; i++){
                attack[i-26] = line_stat[i];
            }
           attack[3] = '\0';
			m1 -> attack = atoi(attack);
            for (int i =29 ; i < 32; i++){
                defense[i-29] = line_stat[i];
            }
            defense[3] = '\0';
            m1 -> defense = atoi(defense);
            for (int i =32 ; i < 35; i++){
                speed[i-32] = line_stat[i];
            }
            speed[3] = '\0';
			m1 -> speed = atoi(speed);
            for (int i =35 ; i < 43; i++){
                m1->skill_1_element[i-35] = line_stat[i];
            }
            m1->skill_1_element[8] = '\0';

            for (int i =43 ; i < 46; i++){
               skill_1_demage[i-43] = line_stat[i];
            }
            skill_1_demage[3] = '\0';
			m1 -> skill_1_demage = atoi(skill_1_demage);
            for (int i =46 ; i < 54; i++){
                m1->skill_2_element[i-46] = line_stat[i];
            }
            m1->skill_2_element[8] = '\0';

            for (int i =54 ; i < 57; i++){
                skill_2_demage[i-54] = line_stat[i];
            }
            skill_2_demage[3] = '\0';
            m1 -> skill_2_demage = atoi(skill_2_demage);
   			grand_monster[numMonster] = *m1;
   			numMonster += 1;
        	}
        	
    	}
    	fclose(fp_mystat);
       
	}
 fclose(fp);
}

void define_effectiveRatio(){
	FILE *fp = fopen("testcase/effectiveness_table.txt", "r");
	char line[256],ratio[4];
	int a=0, j=0;
	while (fgets(line, sizeof(line), fp)) {
		for(int i=8; i<11;i++){
			ratio[i-8] = line[i];
			}
      ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;
   
    for(int i=11; i<14;i++){
      ratio[i-11] = line[i];
      }
      ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);

      j = j+1;

    for(int i=14; i<17;i++){
      ratio[i-14] = line[i];
      }
      ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;


    for(int i=17; i<20;i++){
      ratio[i-17] = line[i];
      }
      ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;



    for(int i=20; i<23;i++){
      ratio[i-20] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);

      j = j+1;

    for(int i=23; i<26;i++){
      ratio[i-23] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

    for(int i=26; i<29;i++){
      ratio[i-26] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

    for(int i=29; i<32;i++){
      ratio[i-29] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;
		

    for(int i=32; i<35;i++){
      ratio[i-32] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;
    for(int i=35; i<38;i++){
      ratio[i-35] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

    for(int i=38; i<41;i++){
      ratio[i-38] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

  for(int i=41; i<44;i++){
      ratio[i-41] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;
    

  for(int i=44; i<47;i++){
      ratio[i-44] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;
    
  for(int i=47; i<50;i++){
      ratio[i-47] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

  for(int i=50; i<53;i++){
      ratio[i-50] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

  for(int i=53; i<56;i++){
      ratio[i-53] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

  for(int i=56; i<59;i++){
      ratio[i-56] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
      j = j+1;

  for(int i=59; i<62;i++){
      ratio[i-59] = line[i];
     }
     ratio[4] = '\0';
      ratio_skill[a][j]= atof(ratio);
    a++;
		j=0;
  }

  // for (int i = 0; i < 18; ++i)
  // {
  //   for (int j = 0; j < 18; ++i)
  //   {
  //     /* code */
  //     printf("%.1f\n",ratio_skill[i][j] );
  //   }
  //   /* code */
  // }
	}


	



//fight
//function one: decide the attacker
// function two: attacker choose skill to attack
//function three: attack the defender



// result




