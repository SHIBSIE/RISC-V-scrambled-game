#done by Omar Shibli and Omar Mardini

.data 
CORCT_WORDS1:
  .asciz "hum"
  .align 3
    .asciz "base"
    .align 3
    .asciz "silk"
    .align 3
    .asciz "float"
    .align 3
    .asciz "count"
    .align 3
    .asciz "smooth"
    .align 3
    .asciz "lonely"
    .align 3
    .asciz "deceive"
    .align 3
    .asciz "mindless"
    .align 3
    .asciz "recondite"
    .align 3

TEST_WORDS1:
    .asciz "hum"
    .align 3
    .asciz "base"
    .align 3
    .asciz "silk"
    .align 3
    .asciz "float"
    .align 3
    .asciz "count"
    .align 3
    .asciz "smooth"
    .align 3
    .asciz "lonely"
    .align 3
    .asciz "deceive"
    .align 3
    .asciz "mindless"
    .align 3
    .asciz "recondite"
    .align 3
string_startgame: .asciz "Press 'Enter' to start."
string_level: .asciz "Your word is:"
string_unscramble: "Unscramble it: "
string_intro: .asciz "At the end of each level you will get a score out of a 100 based on your number of tries. Enjoy!"
string_initialization: .asciz "Welcome to 'scrambled', on every level you will have 5 tries to get the right answer."
string_finish: " words correctly"
string_where: "LEVEL: "
string_outcome: "You have guessed: "
string_newline: .asciz "\n"
string_try: .align 3
	.asciz "Try again. \n" 
string_score: .asciz "Your score, out of 100, is: "
string_win: .align 3
		.asciz "You win \n"
string_lose: .align 3
		.asciz "You lose this level.\n"
Mystring: .align 3
string_guess:
.text
add x9, x0, x0 # counter for words
addi x18, x0, 11 # number of words
addi x23,x0,8


	la x7,CORCT_WORDS1 #address of the word
reload:
    	add x5, x0,x0 #initialize the counter of length to zero
	length:
		lb x8,0(x7) #loading the character
		beq x8,x0,swap #if character is 0 stop counting
		addi x5,x5,1 #increment counter otherwise
		addi x7,x7,1 #move to next character
		beq x0,x0,length

# x5 holds the length of the string should be untouched
swap:
	beq x5,x0,condition
	sub x7,x7,x5
	add x6,x0,x0 #counter of index initialized to zero

	rand: #random number generator
		li a0, 0 
		li a1, 20
		li a7, 42 
		ecall 
	add x28, x6, x10 #checks if random number leaves boundary of word
	bge x28, x5, rand
	
	exec: #this swaps the letters
		lb x28, 0(x7)
		add x7,x7,x10
		lb x29, 0(x7)
		sb x28, 0(x7)
		sub x7,x7,x10
		sb x29, 0(x7)


addi x6,x6,1 #this keeps track of the index we are on.
addi x7,x7,1 #this moves to second index of word to swap it
blt x6, x5,rand

condition:	
	sub x7,x7,x5
	addi x7,x7,8
	addi x9,x9,1
	blt x9,x18,reload

add x9,x0,x0
addi x23,x0,8
la x7, CORCT_WORDS1
la x19, TEST_WORDS1
addi x30,x0,11
add x31,x0,x0
add x21, x0,x0
game_initialize: 

	     
	     addi a7,x0,4      # prints "Press 'Enter' to start."
	     la a0, string_startgame
	     ecall
	     
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	     
	     
	enter_game:   #this chunk of code starts the game when enter is pressed  
	     addi a7,x0,8      # waits for enter
	     la a0, string_guess
	     addi a1, x0, 2
	     ecall
	     
	     lb x30,string_guess
	     lb x29, string_newline
	     bne x29,x30,enter_game
	     
	     
	     addi a7,x0,4      # prints "string of initialization"
	     la a0, string_initialization
	     ecall
	     
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	     addi a7,x0,4      # prints "string of initialization"
	     la a0, string_intro
	     ecall
	     
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall

level:
	add x5, x0, x0 # Initialize counter
	addi x29, x0, 5 # Total number of attempts allowed
	addi x6, x0, 100 # Initialize score

	game: #Here our game is launched:
	add x18, x0,x0 #initialize the counter of length to zero
	size:
		lb x8,0(x7) #loading the character
		beq x8,x0,con #if character is 0 stop counting
		addi x18,x18,1 #increment counter otherwise
		addi x7,x7,1 #move to next character
		beq x0,x0,size
	con:
	     sub x7,x7,x18
	     addi x18,x18,1
	     addi x20,x18,-1
	     
	try: 
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	     lb x25, 0(x19)
	     beq x25, x0,exit
	     
	     
	     addi a7,x0,4      # prints "level"
	     la a0, string_where
	     ecall
	     
	     addi x9,x9,1
	     addi a7, x0, 1
    	     add a0, x0, x9
  	     ecall
  	     addi x9,x9,-1
	     
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	     addi a7,x0,4      # prints "your word is:"
	     la a0, string_level
	     ecall
	     
	     mul x22, x9, x23
	     addi a7,x0,4      # prints "word"
	     la a0, CORCT_WORDS1
	     add a0, a0, x22
	     ecall
	
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	     addi a7,x0,4      # prints "Unscramble it"
	     la a0, string_unscramble
	     ecall
		
	     addi a7,x0,8      # read string from keyboard
	     la a0, Mystring
	     add a1, x0, x18
	     ecall
	     
	     addi a7,x0,4      # goes to new line
	     la a0, string_newline
	     ecall
	     
	la x8, Mystring
	add x26,x0,x0
	add x27,x0,x0  
	check:
		beq x27, x20, youWin
		add x8, x8,x26
		add x19,x19,x26	
		lb x24, 0(x8)
		lb x25, 0(x19)
		sub x8, x8,x26
		sub x19,x19,x26	
		addi x26,x26,1
		addi x27,x27,1
		beq x24, x25, check
		addi x5,x5,1
		beq x5,x29,loss
		bne x24,x25, tryAgain
	

youWin:

	addi x21,x21,1
	
	addi a7,x0,4      # goes to new line
	la a0, string_newline
	ecall
	     
   	addi a7,x0,4      # prints "You win"
   	la a0, string_win
    	ecall
    	
     
   	addi a7,x0,4      # prints score
	la a0, string_score
	ecall
    
    	addi a7, x0, 1
    	add a0, x0, x6
  	ecall
  	
  	addi a7,x0,4      # goes to new line
	la a0, string_newline
	ecall
	
  	
     	beq x0, x0, exit

tryAgain:
     	addi a7,x0,4      # prints "Try again. \n"
     	la a0, string_try
     	ecall
     	
     	addi a7,x0,4      # goes to new line
	la a0, string_newline
	ecall
     
     	addi x6, x6, -20 # decrements scoreb by 20
     	bne x5, x29, try

loss:
 	addi a7,x0,4      # prints "you lose"
     	la a0, string_lose
     	ecall
exit:
	addi x7,x7,8
	addi x19,x19,8
	addi x9,x9,1
	beq x30,x31,end
	addi x31,x31,1
	beq x0,x0,level
end:
	addi a7,x0,4      # goes to new line
	la a0, string_newline
	ecall
	
	addi a7,x0,4      # prints "YOU HAVE GUESSED"
     	la a0, string_outcome
     	ecall
	
	addi a7, x0, 1
    	add a0, x0, x21
  	ecall
  	
  	addi a7,x0,4      # prints "words correctly"
     	la a0, string_finish
     	ecall
