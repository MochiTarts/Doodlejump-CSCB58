#####################################################################
#
# CSCB58 Fall 2020 Assembly Final Project
# University of Toronto, Scarborough
#
# Student: Zining Yu, 1005060979
#
# Bitmap Display Configuration:
# - Unit width in pixels: 16
# - Unit height in pixels: 16
# - Display width in pixels: 256
# - Display height in pixels: 512
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# - Milestone 5 (choose the one the applies)
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. 5cii) - Springs (I call them 'boosts' for my game)
# 2. 5dii) - Start and game over screens
# 3. 5g) - Lethal creatures (falling bombs)
# 4. 5h) - Shields
#
# Link to video demonstration for final submission:
# - https://youtu.be/pu_7P333Z-Y
#
# Any additional information that the TA needs to know:
# - Apologies in advance if my code is messy and unclear
#   I did my best to document/comment everything but I got
#   a little lazy towards the end :<
#
#####################################################################
.data
	displayAddress:	.word	0x10008000
	jKey: .asciiz "j was pressed"          # was initially used to check if I
	kKey: .asciiz "k was pressed"          # was correctly reading key inputs
	input: .asciiz "Press a key"
	newline: .asciiz "\n"
	greyBlue: .word 0xcce7e8               # For background
	green: .word 0x00ff00                  # For doodler
	tan: .word 0xb97455                    # For platforms
	gold: .word 0xffd700                   # For doodler after obtaining shield
	shieldGold: .word 0xd1b000             # For shield
	black: .word 0x000000                  # For bombs
	white: .word 0xffffff                  # For END text
	boostPink: .word 0xfd7c6e              # For boost block
	doodler1: .word 485                    # Doodler
	platformSize: .word 5                  # Size of platform is 5 units
	platform1: .word 499,500,501,502,503   # Platform 1
	platform2: .word 442,443,444,445,446   # Platform 2
	platform3: .word 371,372,373,374,375   # Platform 3
	platform4: .word 309,310,311,312,313   # Platform 4
	platform5: .word 250,251,252,253,254   # Platform 5
	platform6: .word 178,179,180,181,182   # Platform 6
	platform7: .word 118,119,120,121,122,123     # Platform 7
	platform8: .word 51,52,53,54,55        # Platform 8
	platform9: .word 424,425,426,427,428   # Platform 9
	platform10: .word 338,339,340,341,342  # Platform 10
	platform11: .word 265,266,267,268,269  # Platform 11
	platform12: .word 179,180,181,182,183  # Platform 12
	platform13: .word 82,83,84,85,86       # Platform 13
	platform14: .word 360,361,362,363,364  # Platform 14
	platform15: .word 226,227,228,229,230  # Platform 15
	platform16: .word 105,106,107,108,109  # Platform 16
	shield: .word 0,1                      # Shield initial position
	bomb: .word 0                          # Bomb initial position
	boost: .word 0                         # Boost initial position
	shieldBool: .word 0                    # Shield boolean (1 = exists on screen right now, 0 = does not exist on screen right now)
	bombBool: .word 0                      # Bomb boolean (1 = exists on screen right now, 0 = does not exist on screen right now)
	boostBool: .word 0                     # Boost boolean (1 = exists on screen right now, 0 = does not exist on screen right now)
	doodlerShielded: .word 0               # Is doodler shielded boolean (1 = doodler shielded, 0 = doodler not shielded)
	doodlerBoosted: .word 0                # Is doodler boosted boolean (1 = doodler got boost, 0 = doodler does not have boost)
	seconds: .word 125                     # Milliseconds to wait initially
	level: .word 1                         # Stores level value (1 - easy, 2 - medium, 3 - hard)
	selectALevel: .asciiz "Please select an option: 1 - easy level, 2 - medium level, 3 - hard level"
	restart: .asciiz "Press s to restart"
	end: .word 210,211,212,226,242,243,244,258,274,275,276, 214,230,246,262,278,231,248,217,233,249,265,281, 219,235,251,267,283,220,284,237,253,269    # Units that spell out END
	start: .word 18,33,49,66,83,99,113,114, 19,20,21,36,52,68,84,100,116, 23,38,54,70,86,102,118,71,40,56,72,88,104,120, 25,41,57,73,89,105,121,26,74,43,59,91,107,123, 28,29,30,45,61,77,93,109,125   # Units that spell out START
	lvl1: .word 177,193,209,225,241,242, 180,196,212,228,245,182,198,214,230, 184,200,216,232,248,249, 204,189,205,221,237,253   # Units that spell out LVL 1
	lvl2: .word 273,289,305,321,337,338, 276,292,308,324,341,278,294,310,326, 280,296,312,328,344,345, 284,332,348,285,317,349,302,350   # Units that spell out LVL 2
	lvl3: .word 369,385,401,417,433,434, 372,388,404,420,437,374,390,406,422, 376,392,408,424,440,441, 380,412,444,381,413,445,398,430   # Units that spell out LVL 3
	shieldS: .word 33,81,18,50,82,19,67
	shieldH: .word 20,36,52,68,84,53,22,38,54,70,86
	shieldI: .word 23,39,55,71,87
	shieldE: .word 24,40,56,72,88,25,57,89
	shieldL: .word 26,42,58,74,90,91
	shieldD: .word 28,44,60,76,92,29,93,46,62,78
	boostB: .word 177,193,209,225,241,178,210,242,195,227
	boostO1: .word 196,212,228,181,245,198,214,230
	boostO2: .word 199,215,231,184,248,201,217,233
	boostS: .word 202,250,187,219,251,236
	boostT: .word 188,189,205,221,237,253,190
	bombB1: .word 337,353,369,385,401,338,370,402,355,387
	bombO: .word 356,372,388,341,405,358,374,390
	bombM: .word 343,359,375,391,407,360,377,362,347,363,379,395,411
	bombB2: .word 348,364,380,396,412,349,381,413,366,398

.text
initialize:
# Draw the start screen
lw $t0, displayAddress
li $t1, 0
li $t2, 512
while_background:
	beq $t1, $t2, done_background
	mul $t3, $t1, 4
	add $t3, $t3, $t0
	lw $t4, greyBlue
	sw $t4, ($t3)
	addi $t1, $t1, 1
	j while_background
done_background:

lw $t0, displayAddress
li $t1, 0
li $t2, 54
la $t3, start
# Draw the 'START' text
while_start:
	beq $t1, $t2, done_start
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_start
done_start:

lw $t0, displayAddress
li $t1, 0
li $t2, 27
la $t3, lvl1
# Draw the 'LVL 1' text
while_lvl1:
	beq $t1, $t2, done_lvl1
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_lvl1
done_lvl1:

lw $t0, displayAddress
li $t1, 0
li $t2, 29
la $t3, lvl2
# Draw the 'LVL 2' text
while_lvl2:
	beq $t1, $t2, done_lvl2
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_lvl2
done_lvl2:

lw $t0, displayAddress
li $t1, 0
li $t2, 29
la $t3, lvl3
# Draw the 'LVL 3' text
while_lvl3:
	beq $t1, $t2, done_lvl3
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_lvl3
done_lvl3:

# Painting my doodler's starting position (on start screen)
lw $t0, displayAddress
lw $t1, doodler1
lw $t2, green
mul $t1, $t1, 4
add $t1, $t1, $t0
sw $t2, ($t1)

# Painting platform1 (on start screen)
la $t4, platform1
move $a0, $t4
li $a1, 0
jal paint_platform

# Check the entered difficulty: 1 - easy, 2 - medium, 3 - hard, anything else - repeat
li $v0, 4
la $a0, selectALevel
syscall
li $v0, 4
la $a0, newline
syscall

select_level:
lw $t0, 0xffff0000
beq $t0, 1 difficulty_input
j select_level

difficulty_input:
	lw $t0, 0xffff0004
	beq $t0, 0x31, easy_selected
	beq $t0, 0x32, medium_selected
	beq $t0, 0x33, hard_selected

	li $v0, 4
	la $a0, selectALevel
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	sw $zero, 0xffff0000
	j select_level

easy_selected:
	li $t0, 1
	sw $t0, level
	j INIT
medium_selected:
	li $t0, 2
	sw $t0, level
	j INIT
hard_selected:
	li $t0, 3
	sw $t0, level

INIT:
lw $t0, displayAddress	# $t0 stores the base address for display
lw $t1, greyBlue	# $t1 stores the grey-blue colour code
lw $t2, green		# $t2 stores the green colour code
lw $t3, tan		# $t3 stores the tan colour code

PAINT_INIT:
	li $t4, 0
	li $t5, 512
	lw $t6, displayAddress
# Painting my background
WHILE_PAINT:
	beq $t4, $t5, DONE_PAINT
	sw $t1, 0($t6)
	addi $t6, $t6, 4
	addi $t4, $t4, 1
	j WHILE_PAINT
DONE_PAINT:

# Painting my doodler's starting position (on start screen)
lw $t0, displayAddress
lw $t1, doodler1
lw $t2, green
mul $t1, $t1, 4
add $t1, $t1, $t0
sw $t2, ($t1)

# Painting platform1 (on start screen)
la $t4, platform1
move $a0, $t4
li $a1, 0
jal paint_platform

# Painting the shield word, letter by letter (on start screen)
li $t1, 0
li $t2, 7
la $t3, shieldS
while_shieldS:
	beq $t1, $t2, done_shieldS
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_shieldS
done_shieldS:

li $t1, 0
li $t2, 11
la $t3, shieldH
while_shieldH:
	beq $t1, $t2, done_shieldH
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_shieldH
done_shieldH:

li $t1, 0
li $t2, 5
la $t3, shieldI
while_shieldI:
	beq $t1, $t2, done_shieldI
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_shieldI
done_shieldI:

li $t1, 0
li $t2, 8
la $t3, shieldE
while_shieldE:
	beq $t1, $t2, done_shieldE
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_shieldE
done_shieldE:

li $t1, 0
li $t2, 6
la $t3, shieldL
while_shieldL:
	beq $t1, $t2, done_shieldL
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_shieldL
done_shieldL:

li $t1, 0
li $t2, 10
la $t3, shieldD
while_shieldD:
	beq $t1, $t2, done_shieldD
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_shieldD
done_shieldD:

# Painting the shield (on the start screen)
li $t1, 0
li $t2, 2
la $t3, shield
while_exampleShield:
	beq $t1, $t2, done_exampleShield
	lw $t4, ($t3)
	addi $t4, $t4, 113
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, shieldGold
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_exampleShield
done_exampleShield:

# Painting the boost word, letter by letter (on the start screen)
li $t1, 0
li $t2, 10
la $t3, boostB
while_boostB:
	beq $t1, $t2, done_boostB
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_boostB
done_boostB:

li $t1, 0
li $t2, 8
la $t3, boostO1
while_boostO1:
	beq $t1, $t2, done_boostO1
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_boostO1
done_boostO1:

li $t1, 0
li $t2, 8
la $t3, boostO2
while_boostO2:
	beq $t1, $t2, done_boostO2
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_boostO2
done_boostO2:

li $t1, 0
li $t2, 6
la $t3, boostS
while_boostS:
	beq $t1, $t2, done_boostS
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_boostS
done_boostS:

li $t1, 0
li $t2, 7
la $t3, boostT
while_boostT:
	beq $t1, $t2, done_boostT
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_boostT
done_boostT:

# Painting the example boost
lw $t1, boost
addi $t1, $t1, 273
mul $t1, $t1, 4
add $t1, $t1, $t0
lw $t2, boostPink
sw $t2, ($t1)

# Painting the bomb word, letter by letter (on the start screen)
li $t1, 0
li $t2, 10
la $t3, bombB1
while_bombB1:
	beq $t1, $t2, done_bombB1
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_bombB1
done_bombB1:

li $t1, 0
li $t2, 8
la $t3, bombO
while_bombO:
	beq $t1, $t2, done_bombO
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_bombO
done_bombO:

li $t1, 0
li $t2, 13
la $t3, bombM
while_bombM:
	beq $t1, $t2, done_bombM
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, tan
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_bombM
done_bombM:

li $t1, 0
li $t2, 10
la $t3, bombB2
while_bombB2:
	beq $t1, $t2, done_bombB2
	lw $t4, ($t3)
	mul $t4, $t4, 4
	add $t4, $t4, $t0
	lw $t5, white
	sw $t5, ($t4)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j while_bombB2
done_bombB2:

# Painting example bomb
lw $t1, bomb
addi $t1, $t1, 433
mul $t1, $t1, 4
add $t1, $t1, $t0
lw $t2, black
sw $t2, ($t1)

# Now pause to allow players to read the quick guide for a couple of seconds (10000 milliseconds)
li $v0, 32,
la $a0, 10000
syscall

# Paint background again (in game initialization)
lw $t0, displayAddress
li $t1, 0
li $t2, 512
while_background2:
	beq $t1, $t2, done_background2
	mul $t3, $t1, 4
	add $t3, $t3, $t0
	lw $t4, greyBlue
	sw $t4, ($t3)
	addi $t1, $t1, 1
	j while_background2
done_background2:

# Painting my doodler's starting position (now in-game)
lw $t4, doodler1
mul $t4, $t4, 4
add $t4, $t4, $t0
lw $t2, green
sw $t2, ($t4)

platforms_init:
# Painting my platform's starting position (Platform1 will always be painted, no matter the level)
la $t4, platform1
move $a0, $t4
li $a1, 0
jal paint_platform

# Check what level the user chose. Paint platforms accordingly
lw $t4, level
beq $t4, 2, medium_initial
beq $t4, 3, hard_initial
# Default is easy
la $t4, platform2
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform3
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform4
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform5
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform6
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform7
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform8
move $a0, $t4
li $a1, 0
jal paint_platform
j GAME_INIT

medium_initial:
la $t4, platform9
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform10
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform11
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform12
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform13
move $a0, $t4
li $a1, 0
jal paint_platform
j GAME_INIT

hard_initial:
la $t4, platform14
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform15
move $a0, $t4
li $a1, 0
jal paint_platform

la $t4, platform16
move $a0, $t4
li $a1, 0
jal paint_platform

GAME_INIT:
	li $t1, 0              # $t1 stores doodler1's jump height unit for now (doodler can jump up to 11 units high)
	lw $t2, doodler1       # $t2 stores doodler1's initial and updated positions for each iteration
	li $t7, 0              # $t7 is my boolean for up or down for doodler1 (0 = up, 1 = down)
	li $t8, 1              # $t8 keeps track of the game as it progresses, increments with each new platform I jump off
	li $s0, 0	       # $s0 keeps track of the screen scroll movement (every time screen scrolls, increment $s0, once it stops scrolling, reset $s0 = 0)

WHILE_GAME:
	lw $t3, 0xffff0000
	beq $t3, 1, keyboard_input
	j keyboard_input_done

	keyboard_input:
		lw $t4, 0xffff0004
		beq $t4, 0x6A, respond_to_j
		beq $t4, 0x6B, respond_to_k
		j keyboard_input_done

	respond_to_j:
		li $a0, -1
		lw $t3, doodlerShielded
		beq $t3, 1, doodler_gold_left
		lw $a1, green
		j move_doodler_left
		doodler_gold_left:
			lw $a1, gold
		move_doodler_left:
		jal doodler_move_sideways

		# Check if doodler's position = boost's position, if so, set doodlerBoosted boolean to true (1) and set boostBool to false (0) since doodler obtained boost
		lw $t3, boost
		beq $t3, $t2, doodler_boosted_left
		j keyboard_input_done
		doodler_boosted_left:
			li $t3, 1
			sw $t3, doodlerBoosted
			sw $zero, boostBool

		j keyboard_input_done

	respond_to_k:
		li $a0, 1
		lw $t3, doodlerShielded
		beq $t3, 1, doodler_gold_right
		lw $a1, green
		j move_doodler_right
		doodler_gold_right:
			lw $a1, gold
		move_doodler_right:
		jal doodler_move_sideways

		# Check if doodler's position = boost's position, same as respond_to_j check for boost
		lw $t3, boost
		beq $t3, $t2, doodler_boosted_right
		j keyboard_input_done
		doodler_boosted_right:
			li $t3, 1
			sw $t3, doodlerBoosted
			sw $zero, boostBool

	keyboard_input_done:
	sw $zero, 0xffff0000

	# Check if doodler is boosted, if boosted, set sleep time to lower number (7 milliseconds) b/c I want doodler to move up very fast
	lw $t3, doodlerBoosted
	beq $t3, 1, speed_up_game
	j continue_normal_seconds
	speed_up_game:
		li $v0, 32
		la $a0, 7
		syscall
		j start_game

	continue_normal_seconds:
	beq $s0, 1, increment_t8
	j determine_seconds
	increment_t8:
		addi $t8, $t8, 1   # Increment $t8 every time the screen scrolls, because that means I jumped off a new platform
	determine_seconds:
	# Decrease the seconds for sleeping as the game progresses (to make it more difficult)
	# Everytime $t8 hits a number divisible by 2, decrease the amount of time to sleep by 5, until I hit 60 milliseconds (60 is the minimum, otherwise game moves too fast IMO)
	li $t3, 2
	div $t8, $t3
	mfhi $t3
	lw $t4, seconds

	# Print seconds for debugging
	li $v0, 1
	move $a0, $t4
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# Here, I check if I should decrease or keep my current seconds value (if I already hit the min or $t8 is not a value divisible by 5, I keep seconds, if $t8 is divisible by 5, I decrement by 5)
	ble $t4, 60, keep_seconds
	beq $t3, 0, decrease_seconds
	j keep_seconds

	# Here, I decrease the seconds variable by 5
	decrease_seconds:
	beq $s0, 1, truly_decrease_seconds        # I only decrease the seconds if $s0 = 1, because that means my just scrolled (I'm not going to decrease for every unit my screen moves by, just the first one)
	j keep_seconds
	truly_decrease_seconds:
	li $v0, 32
	lw $t3, seconds
	addi $t3, $t3, -5
	sw $t3, seconds
	la $a0, ($t3)
	syscall
	j start_game

	# Here, I don't change the current value of seconds
	keep_seconds:
	li $v0, 32
	lw $t3, seconds
	la $a0, ($t3)
	syscall

	# Here, I check if I should move my doodler up or down ($t7 is my up or down boolean, $t7 = 0 means doodler moves up, $t7 = 1 means doodler moves down)
	start_game:
	bne $t7, 0, down                     # If $t7 = 1, go the down branch
	# Otherwise continue into the up branch
	up:
		# I need to check if doodler is shielded or not to determine what to colour my doodler when moving it up by 1 unit
		lw $t3, doodlerShielded
		beq $t3, 1, doodler_gold
		lw $a0, green                # If doodlerShielded = 0 (doodler isn't shielded), doodler colour will be green, the default colour
		j stay_green
		doodler_gold:
			lw $a0, gold         # If doodlerShielded = 1 (doodler is shielded), doodler colour will be gold
		stay_green:
		jal doodler_move_up          # Call the function for moving the doodler up 1 unit

		check_scroll_screen:
		# Check if doodler is past row 13 yet, if so, I will scroll the screen
		div $t3, $t2, 16            # $t3 = doodler position // 16
		ble $t3, 13, all_move_down   # This means I'm on row 13
		li $s0, 0                    # Set $s0 to 0, meaning no screen scroll, do not increment $t8
		j keep_checking              # No screen scroll, then I jump to keep_checking location that is past the block of code that deals with screen movement

		# Move all platforms down by 1 unit (or generate new platform), move doodler down by 1 unit as well (to make it seem like doodler is still moving up as platforms move down)
		all_move_down:
			# Check if shield exists, if so, move it down (shields behave similarly to platforms in terms of movement)
			lw $t3, shieldBool
			beq $t3, 1, shield_move_down
			j skip_shield
			shield_move_down:
				li $a0, 16
				jal draw_shield


				lw $t3, shield
				div $t3, $t3, 16
				beq $t3, 32, reset_shield
				beq $t3, 33, reset_shield
				j skip_shield

				reset_shield:
				li $t3, 0
				sw $t3, shieldBool
			skip_shield:

			# Check if boost exists, if so, move it down (boosts also behaves similarly to platforms in terms of movement)
			lw $t3, boostBool
			beq $t3, 1, boost_move_down
			j skip_boost
			boost_move_down:
				li $a0, 16
				jal draw_boost

				lw $t3, boost
				div $t3, $t3, 16
				beq $t3, 32, reset_boost
				beq $t3, 33, reset_boost
				j skip_boost

				reset_boost:
				li $t3, 0
				sw $t3, boostBool
			skip_boost:

			# Check if bomb eixsts, if so, move it down (bombs are similar to doodler movement, but they only move downwards)
			lw $t3, bombBool
			beq $t3, 1, bomb_move_down
			j skip_bomb
			bomb_move_down:
				li $a0, 16
				jal draw_bomb

				lw $t3, bomb
				div $t3, $t3, 16
				beq $t3, 32, reset_bomb_scroll
				beq $t3, 32, reset_bomb_scroll
				j skip_bomb

				reset_bomb_scroll:
				li $t3, 0
				sw $t3, bombBool
			skip_bomb:

			# Increment $s0 by 1 if screen scrolls, now I know the screen just scrolled
			addi $s0, $s0, 1

			# Platform1 is present for all levels, so I will paint it regardless of the level selected
			la $t3, platform1
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			# Check what level this is, move specific platforms only (platform1 will be moved regardless of level)
			lw $t3, level
			beq $t3, 2, medium_level_platforms
			beq $t3, 3, hard_level_platforms
			# Otherwise, we're on easy_level_platforms (Easy - platforms1-platforms8)
			la $t3, platform2
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			la $t3, platform3
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			la $t3, platform4
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			la $t3, platform5
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			la $t3, platform6
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			la $t3, platform7
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			la $t3, platform8
			move $a0, $t3
			li $t3, 16
			move $a1, $t3
			jal paint_platform

			# In this block, I check if any of the platforms passed the bottom of the screen (row 32 or row 33), if so, I will generate a new location for it past the top of the screen
			lw $t3, platform1
			la $t4, platform1
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform2
			la $t4, platform2
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform3
			la $t4, platform3
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform4
			la $t4, platform4
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform5
			la $t4, platform5
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform6
			la $t4, platform6
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform7
			la $t4, platform7
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			lw $t3, platform8
			la $t4, platform8
			div $t3, $t3, 16
			beq $t3, 32, new_platform
			beq $t3, 33, new_platform

			j done_moving_platforms                # Platforms are done being moved or relocated, skip the medium and hard level movement since we're on the easy movement block

			# Platform movement for medium level platforms (platform1, platform9-platform13), same logic as easy level platform movement
			medium_level_platforms:
				la $t3, platform9
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				la $t3, platform10
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				la $t3, platform11
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				la $t3, platform12
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				la $t3, platform13
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				# In this block, I check if any of the platforms passed the bototm, if so, I will generate a new location for it, same logic as easy level
				lw $t3, platform1
				la $t4, platform1
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform9
				la $t4, platform9
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform10
				la $t4, platform10
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform11
				la $t4, platform11
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform12
				la $t4, platform12
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform13
				la $t4, platform13
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				j done_moving_platforms

			# Platform movement for hard level platforms (platform1, platform14-platform16), same logic as easy level platforms movement
			hard_level_platforms:
				la $t3, platform14
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				la $t3, platform15
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				la $t3, platform16
				move $a0, $t3
				li $t3, 16
				move $a1, $t3
				jal paint_platform

				# In this block, I check if any of the platforms passed the bototm, if so, I will generate a new location for it, same logic as easy level
				lw $t3, platform1
				la $t4, platform1
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform14
				la $t4, platform14
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform15
				la $t4, platform15
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				lw $t3, platform16
				la $t4, platform16
				div $t3, $t3, 16
				beq $t3, 32, new_platform
				beq $t3, 33, new_platform

				j done_moving_platforms

			# Here, I generate the new locations for any platform that passed the bottom of the screen
			new_platform:
			move $t5, $t4                       # $t5 = address of the platform that needs to be relocated
			# Random number for moving the platform to the left or right (0 for left, 1 for right)
			li $v0, 42
			li $a0, 0
			li $a1, 2
			syscall
			move $t3, $a0                       # $t3 = random number generated

			beq $t3, 0, move_left
			move_right:
				# Perform left platform unit / 16, and obtain the remainder, 10 - remainder will be the max amount of units I'm allowed to move the platform to the right
				lw $t4, ($t5)
				li $t3, 16
				div $t4, $t3
				mfhi $t4
				mul $t4, $t4, -1
				addi $t4, $t4, 10

				li $v0, 42
				li $a0, 1
				addi $t4, $t4, 1
				move $a1, $t4
				syscall
				move $t4, $a0

				lw $t3, level
				beq $t3, 3, hard_difference_right
				j regular_platform_difference_right

				# Here, I determine the height difference between platforms, I want to put my newly generated platform above the top of the screen so it'll scroll down together with the rest of my platforms on screen
				# These immediate values are based on the platform height difference for each level, easy and medium have similar height differences, hard has a larger height difference
				hard_difference_right:
					addi $t4, $t4, -512
					j prepare_move_platform_right

				regular_platform_difference_right:
					addi $t4, $t4, -528

				# Here, I draw the new location for my platform, using function paint_platform_right
				# Since the loop for drawing platforms to the left or the right are different
				prepare_move_platform_right:
				move $a1, $t4
				addi $t5, $t5, 16
				move $a0, $t5
				jal paint_platform_right

				j done_moving_platforms     # Finished relocating the platform, so skip the block for moving the platform to the left

			# Pretty much the same as move_right, except I call paint_platform instead of paint_platform_right for drawing my new platform location
			move_left:
				# Perform left platform unit / 16, the remainder will be the max amount of units I'm allowed to move to the left
				lw $t4, ($t5)
				li $t3, 16
				div $t4, $t3
				mfhi $t4                  # $t4 = max amount of units I'm allowed to move to the left

				li $v0, 42
				li $a0, 1
				addi $t4, $t4, 1
				move $a1, $t4
				syscall
				move $t4, $a0            # $t4 = random number between 0 and the max amount of units I'm allowed to move to the left

				mul $t4, $t4, -1
				lw $t3, level
				beq $t3, 3, hard_difference_left
				j regular_platform_difference_left

				# Here, I check the difficulty to determine how far apart I should generate my new platforms from each other
				hard_difference_left:
					addi $t4, $t4, -512
					j prepare_move_platform_left

				regular_platform_difference_left:
					addi $t4, $t4, -528

				prepare_move_platform_left:
				move $a1, $t4
				move $a0, $t5
				jal paint_platform

			# Platforms are finished being moved or relocated, now I focus on the doodler again
			# I need move the doodler down a unit to make it appear it's moving up by 1 unit as platforms are moving down by 1 unit
			done_moving_platforms:
			lw $t3, doodlerShielded
			beq $t3, 1, doodler_still_gold
			lw $a0, green                              # If doodler isn't shielded, doodler will be painted green as usual
			j doodler_move_down_again
			doodler_still_gold:
				lw $a0, gold                       # Otherwise, doodler will be gold
			doodler_move_down_again:
			jal doodler_move_down                      # Move the doodler down by 1 unit

		keep_checking:
		# If max height has been reached, move down ($t1 = 11, which means doodler's reached max height, start falling)
		addi $t1, $t1, 1            # Increment the jump height unit counter by 1
		# Check if doodlerBoosted is true, if it is, increase the jump height ($t1 = 64 before it branches to go_down)
		lw $t3, doodlerBoosted
		beq $t3, 1, increase_jump_height
		j normal_jump_height
		increase_jump_height:
			beq $t1, 64, go_down           # If doodler hit the max height of 64 (when doodler is boosted, branch to go_down)
			j continue
		normal_jump_height:
		beq $t1, 11, go_down                   # If doodler hit the max height of 11 (when doodler isn't boosted, branch to go_down)
		# Otherwise, keep going up
		j continue                  # Otherwise continue the loop

		go_down:
			li $t7, 1           # $t7 = 1 (direction is now down, the next loop with branch to the down block instead of the up block)
			li $t3, 0
			sw $t3, doodlerBoosted           # Set doodlerBoosted to 0, since doodler reached max height of boost, no longer boosted

		j continue                  # Skip the down block to continue the loop

	down:
		# Check if doodler is on row 31 (meaning doodler landed on map bottom)
		div $t3, $t2, 16
		beq $t3, 31, check_if_shielded
		j continue_down
		check_if_shielded:
			# Check if doodler is shielded when it hit the map bottom, if so, don't end game, branch to go_up (so doodler can move back up)
			lw $t3, doodlerShielded
			beq $t3, 0, Exit                       # If doodler isn't shielded, exit the game
			li $t3, 0
			sw $t3, doodlerShielded                # If doodler is shielded, set the doodlerShielded boolean to false (0) since it just used the shield
			j go_up

		continue_down:
		# Check if doodler is boosted, if so, move up
		lw $t3, doodlerBoosted
		beq $t3, 1, go_up

		# Check if doodler is right on top of a platform, if so, move up
		# Obtain the address of the unit directly below the doodler's current position
		addi $t3, $t2, 16           # $t3 = unit directly below current doodler's position
		li $t4, 4
		mult $t3, $t4
		mflo $t3
		add $t3, $t3, $t0           # $t3 = address of the unit directly below doodler's position
		lw $t3, ($t3)               # $t3 = value stored in the address below the doodler's position
		li $t4, 12153941            # $t4 = decimal value of tan hexcode
		beq $t3, $t4, go_up

		# Otherwise, move the doodler down
		lw $t3, doodlerShielded
		beq $t3, 1, doodler_gold_down
		lw $a0, green
		j doodler_keep_falling
		doodler_gold_down:
			lw $a0, gold
		doodler_keep_falling:
		jal doodler_move_down       # Move the doodler down 1 unit
		j continue                  # Skip the go_up block since doodler is still moving down

		go_up:
			# Check if doodler is shielded, if so, keep the colour gold, otherwise make doodler green again
			lw $t3, doodlerShielded
			beq $t3, 1, doodler_still_gold_up
			lw $a0, green
			j doodler_bounce_up
			doodler_still_gold_up:
				lw $a0, gold
			doodler_bounce_up:
			jal doodler_move_up
			li $t7, 0                            # Set the $t7 up or down boolean to 0 (meaning doodler will be moving up now)
			li $t1, 1                            # Reset the $t1 jump height unit counter to 1 (b/c we're moving up again)

	continue:

	# Check if doodler's position is equal to bomb's position
	lw $t3, bomb
	beq $t3, $t2, check_doodler_shielded
	j check_bomb_existence
	check_doodler_shielded:
		lw $t3, doodlerShielded
		beq $t3, 0, Exit
		li $t3, 0
		sw $t3, doodlerShielded
		sw $t3, bombBool
		sw $t3, bomb

	check_bomb_existence:
	# Check if bomb exists, if so, move it down by 1 unit
	lw $t3, bombBool
	beq $t3, 1, move_bomb_down
	j check_doodler_got_boost
	move_bomb_down:
		li $a0, 16
		jal draw_bomb

		lw $t3, bomb
		div $t3, $t3, 16
		beq $t3, 32, reset_bomb
		beq $t3, 33, reset_bomb
		j check_doodler_got_boost
		reset_bomb:
		li $t3, 0
		sw $t3, bombBool

	check_doodler_got_boost:
	# Check if doodler's position is equal to boost's position
	lw $t3, boost
	beq $t3, $t2, boost_doodler
	j generate
	boost_doodler:
		li $t3, 1
		sw $t3, doodlerBoosted    # Set doodlerBoosted to 1 (meaning that doodler is now boosted, the next loop will check this bool value and perform the appropriate actions)
		li $t3, 0
		sw $t3, boostBool         # Set boostBool to 0 (meaning boost no longer exists on screen since doodler obtained it)

	generate:
	# Determine if shield, bomb, and boost should be generated
	lw $t3, seconds
	ble $t3, 124, shield_bomb_and_boost
	j loop

	shield_bomb_and_boost:
		lw $t3, shieldBool
		beq $t3, 0, shield_exist     # Check if shield does not exist (shieldBool = 0), if it doesn't exist, generate it (if random number generated is 4)
		j check_bomb_exist
		shield_exist:
			# Random number generator 0-19, if number = 4, then generate shield
			li $v0, 42
			li $a0, 2
			li $a1, 20
			syscall

			beq $a0, 4, generate_shield
			j check_bomb_exist
			generate_shield:
				# Random number generate 0-14, to determine location of shield columns
				generate_location:
				li $v0, 42
				li $a0, 2
				li $a1, 15
				syscall

				# I make sure the columns generated won't be on a platform
				mul $t3, $a0, 4
				add $t3, $t3, $t0
				lw $t3, ($t3)
				beq $t3, 12153941, generate_location
				addi $t3, $a0, 1
				mul $t3, $t3, 4
				add $t3, $t3, $t0
				lw $t3, ($t3)
				beq $t3, 12153941, generate_location

				addi $a0, $a0, -16

				# Store the two column values into the shield variable array
				la $t3, shield
				sw $a0, ($t3)
				addi $a0, $a0, 1
				sw $a0, 4($t3)

				li $t3, 1
				sw $t3, shieldBool               # Set shield boolean to exists now

				li $a0, 0
				jal draw_shield

	check_bomb_exist:
		lw $t3, bombBool
		beq $t3, 0, bomb_exist
		j check_boost_exist
		bomb_exist:
			# Random number generator 0-49, if number = 25, generate bomb
			li $v0, 42
			li $a0, 3
			li $a1, 50
			syscall

			beq $a0, 25, generate_bomb
			j check_boost_exist
			generate_bomb:
				# Random number generator 0-15 to determine the location of the bomb (it's ok if bomb overlaps with platform b/c bomb will move down anywas)
				li $v0, 42
				li $a0, 3
				li $a1, 16
				syscall

				# Store the generated location in the bomb variable
				addi $a0, $a0, -16
				la $t3, bomb
				sw $a0, ($t3)

				li $t3, 1
				sw $t3, bombBool                # Set bomb boolean to exists now

				li $a0, 0
				jal draw_bomb

	check_boost_exist:
		lw $t3, boostBool
		beq $t3, 0, boost_exist
		j loop
		boost_exist:
			# Random number generator 0-14, if number = 10, generate boost
			li $v0, 42
			li $a0, 4
			li $a1, 15
			syscall

			beq $a0, 10, generate_boost
			j loop
			generate_boost:
				# Random number generator 0-15 to determine the location of the boost
				generate_boost_location:
				li $v0, 42
				li $a0, 4
				li $a1, 16
				syscall

				# I make sure the location isn't inside a platform and isn't inside a shield
				mul $t3, $a0, 4
				add $t3, $t3, $t0
				lw $t3, ($t3)
				beq $t3, 12153941, generate_boost_location
				beq $t3, 13742080, generate_boost_location

				addi $a0, $a0, -16
				# Store the location inside the boost variable
				la $t3, boost
				sw $a0, ($t3)

				li $t3, 1
				sw $t3, boostBool               # Set boost boolean to exists now

				li $a0, 0
				jal draw_boost

	loop:
	j WHILE_GAME

# Function for moving doodler up 1 unit
doodler_move_up:
	doodler_got_shield:
	# If doodler's current position is equal to one of shield's positions, colour doodler gold and disappear the shield
	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	beq $t2, $t4, paint_gold
	beq $t2, $t5, paint_gold
	j paint_tan

	paint_gold:
	lw $a0, gold
	sw $zero, shieldBool
	mul $t3, $t2, 4
	add $t3, $t3, $t0
	sw $a0, ($t3)
	li $t3, 1
	sw $t3, doodlerShielded

	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	mul $t4, $t4, 4
	mul $t5, $t5, 4
	add $t4, $t4, $t0
	add $t5, $t5, $t0
	lw $t6, greyBlue
	sw $t6, ($t4)
	sw $t6, ($t5)

	# If left or right unit of current doodler's position is tan, colour current position tan
	paint_tan:
	addi $t3, $t2, -1                   # Get left unit of doodler's current position
	addi $t4, $t2, 1                    # Get right unit of doodler's current position
	li $t5, 4                           # Set $t5 = 4
	mult $t3, $t5                       # $t3 = left unit * 4
	mflo $t3                            #
	mult $t4, $t5                       # $t4 = right unit * 4
	mflo $t4                            #
	add $t3, $t3, $t0                   # $t3 = left unit address
	add $t4, $t4, $t0                   # $t4 = right unit address
	lw $t3, ($t3)                       # $t3 = value of left unit
	lw $t4, ($t4)                       # $t4 = value of right unit
	li $t5, 12153941                    # $t5 = decimal value of tan hexcode
	beq $t3, $t5, paint_tan_left        # If left unit is tan, paint current doodler's position tan
	beq $t4, $t5, paint_tan_right       # If right unit is tan, paint current doodler's position tan
	j paint_blue

	paint_tan_left:
	lw $t3, platformSize
	mul $t3, $t3, -1
	add $t3, $t2, $t3
	li $t5, 4
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue
	lw $t4, tan                         # Paint the current doodler position tan
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green or gold anymore
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j move_up

	paint_tan_right:
	lw $t3, platformSize
	add $t3, $t2, $t3
	li $t5, 4
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue
	lw $t4, tan                         # Paint the current doodler position tan
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j move_up

	paint_blue:
	lw $t4, greyBlue                    # Paint the current doodler position grey blue
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green or gold
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)

	move_up:
	addi $t2, $t2, -16                  # $t2 -= 16, move doodler up by 1 unit
	li $t3, 4                           # $t3 = 4, use $t3 the constant 4
	mult $t2, $t3                       # $t3 = doodler's unit position * 4 (AKA offset)
	mflo $t3                            # $t3 = offset
	add $t3, $t3, $t0                   # $t3 = offset + displayAddress
	sw $a0, ($t3)                       # Colour the updated doodler's position green or gold
	jr $ra

# Function for moving the doodler down 1 unit
doodler_move_down:
	doodler_got_shield_down:
	# If doodler's current position is equal to one of shield's positions, colour doodler gold and disappear the shield
	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	beq $t2, $t4, paint_gold_down
	beq $t2, $t5, paint_gold_down
	j paint_tan_down

	paint_gold_down:
	lw $a0, gold
	sw $zero, shieldBool
	mul $t3, $t2, 4
	add $t3, $t3, $t0
	sw $a0, ($t3)
	li $t3, 1
	sw $t3, doodlerShielded

	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	mul $t4, $t4, 4
	mul $t5, $t5, 4
	add $t4, $t4, $t0
	add $t5, $t5, $t0
	lw $t6, greyBlue
	sw $t6, ($t4)
	sw $t6, ($t5)

	# If left or right unit of current doodler's position is tan, colour current position tan
	paint_tan_down:
	addi $t3, $t2, -1                   # Get left unit of doodler's current position
	addi $t4, $t2, 1                    # Get right unit of doodler's current position
	li $t5, 4                           # Set $t5 = 4
	mult $t3, $t5                       # $t3 = left unit * 4
	mflo $t3                            #
	mult $t4, $t5                       # $t4 = right unit * 4
	mflo $t4                            #
	add $t3, $t3, $t0                   # $t3 = left unit address
	add $t4, $t4, $t0                   # $t4 = right unit address
	lw $t3, ($t3)                       # $t3 = value of left unit
	lw $t4, ($t4)                       # $t4 = value of right unit
	li $t5, 12153941                    # $t5 = decimal value of tan hexcode
	beq $t3, $t5, paint_tan_down_left   # If left unit is tan, paint current doodler's position tan
	beq $t4, $t5, paint_tan_down_right  # If right unit is tan, paint current doodler's position tan
	j paint_blue_down

	paint_tan_down_left:
	lw $t3, platformSize
	mul $t3, $t3, -1
	add $t3, $t2, $t3
	li $t5, 4
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue_down
	lw $t4, tan                         # Paint the current doodler position tan
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j move_down

	paint_tan_down_right:
	lw $t3, platformSize
	add $t3, $t2, $t3
	li $t5, 4
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue_down
	lw $t4, tan                         # Paint the current doodler position tan
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j move_down

	paint_blue_down:
	lw $t4, greyBlue                    # Paint the current doodler position grey blue
	li $t3, 4                           # so it won't be green anymore
	mult $t2, $t3                       # the new doodler position will be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)

	move_down:
	addi $t2, $t2, 16                   # $t2 += 16, move doodler up by 1 unit
	li $t3, 4                           # $t3 = 4, use $t3 the constant 4
	mult $t2, $t3                       # $t3 = doodler's unit position * 4 (AKA offset)
	mflo $t3                            # $t3 = offset
	add $t3, $t3, $t0                   # $t3 = offset + displayAddress
	sw $a0, ($t3)                       # Colour the updated doodler's position green (or gold)
	jr $ra

# Function for moving doodler left or right 1 unit
doodler_move_sideways:
	# If doodler's current position is equal to one of shield's positions, colour doodler gold and disappear the shield
	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	beq $t2, $t4, paint_gold_sideways
	beq $t2, $t5, paint_gold_sideways
	j paint_tan_sideways

	paint_gold_sideways:
	lw $a1, gold
	sw $zero, shieldBool
	mul $t3, $t2, 4
	add $t3, $t3, $t0
	sw $a1, ($t3)
	li $t3, 1
	sw $t3, doodlerShielded

	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	mul $t4, $t4, 4
	mul $t5, $t5, 4
	add $t4, $t4, $t0
	add $t5, $t5, $t0
	lw $t6, greyBlue
	sw $t6, ($t4)
	sw $t6, ($t5)

	# If left or right unit of current doodler's position is tan, colour current position tan
	paint_tan_sideways:
	addi $t3, $t2, -1                   # Get left unit of doodler's current position
	addi $t4, $t2, 1                    # Get right unit of doodler's current position
	li $t5, 4                           # Set $t5 = 4
	mult $t3, $t5                       # $t3 = left unit * 4
	mflo $t3                            #
	mult $t4, $t5                       # $t4 = right unit * 4
	mflo $t4                            #
	add $t3, $t3, $t0                   # $t3 = left unit address
	add $t4, $t4, $t0                   # $t4 = right unit address
	lw $t3, ($t3)                       # $t3 = value of left unit
	lw $t4, ($t4)                       # $t4 = value of right unit
	li $t5, 12153941                    # $t5 = decimal value of tan hexcode
	beq $t3, $t5, paint_tan_sideways_left        # If left unit is tan, paint current doodler's position tan
	beq $t4, $t5, paint_tan_sideways_right       # If right unit is tan, paint current doodler's position tan
	j paint_blue_sideways

	paint_tan_sideways_left:
	lw $t3, platformSize
	mul $t3, $t3, -1
	add $t3, $t2, $t3
	li $t5, 4
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue_sideways
	lw $t4, tan                         # Paint the current doodler position tan
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j move_sideways

	paint_tan_sideways_right:
	lw $t3, platformSize
	add $t3, $t2, $t3
	li $t5, 4
	mult $t3, $t5
	mflo $t3
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue_sideways
	lw $t4, tan                         # Paint the current doodler position tan
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j move_sideways

	paint_blue_sideways:
	lw $t4, greyBlue                    # Paint the current doodler position grey blue
	li $t3, 4                           # so it won't be green anymore (matches background)
	mult $t2, $t3                       # and the old position won't be green
	mflo $t3
	add $t3, $t3, $t0
	sw $t4, ($t3)

	move_sideways:
	add $t2, $t2, $a0                   # $t2 -= 2 OR $t2 += 2, move doodler left or right by 2 units
	li $t3, 4                           # $t3 = 4, use $t3 the constant 4
	mult $t2, $t3                       # $t3 = doodler's unit position * 4 (AKA offset)
	mflo $t3                            # $t3 = offset
	add $t3, $t3, $t0                   # $t3 = offset + displayAddress
	sw $a1, ($t3)                       # Colour the updated doodler's position green
	jr $ra

paint_platform_right:
	lw $t3, platformSize    # $t4 contains platformSize value now
	li $t5, 0
	WHILE_PLATFORM_PAINT:
		beq $t5, $t3, PLATFORM_DONE_PAINT

		# So that the old position will be the background colour and the new position will be the platform colour
		paint_current_platform_unit_greyBlue_RIGHT:
		lw $t4, ($a0)
		li $t6, 4
		mult $t4, $t6
		mflo $t4
		add $t4, $t4, $t0
		lw $t6, greyBlue
		sw $t6, ($t4)

		paint_platform_new_position_RIGHT:
		lw $t4, ($a0)             # store value at current array index (which is parameter argument $a0) in $t4, this will be the last unit of the platform, rightmost unit
		add $t4, $t4, $a1         # platform[i] += $a1 (Use $a1 to determine the new platform positions, whether to move down by 1 unit, or to create new location at top of display)
		sw $t4, ($a0)             # Store the updated position in platform[i]
		li $t6, 4                 # set $t6 to 4
		mult $t4, $t6             # value at current array multiplied by 4
		mflo $t4                  # set $t4 to product, $t4 is now the offset
		add $t4, $t4, $t0         # set $t4 to offset + displayAddress
		lw $t6, tan               # load tan colour value into $t7
		sw $t6, 0($t4)            # Paint the unit tan coloured
		addi $a0, $a0, -4         # Decrement array index pointer
		addi $t5, $t5, 1          # Increment counter
		j WHILE_PLATFORM_PAINT
	PLATFORM_DONE_PAINT:
	jr $ra

# Function for painting platforms
paint_platform:
	lw $t3, platformSize    # $t3 contains platformSize value now
	li $t5, 0
	WHILE_PLATFORM:
		beq $t5, $t3, PLATFORM_DONE

		# So that the old position will be the background colour and the new position will be the platform colour
		paint_current_platform_unit_greyBlue:
		lw $t4, ($a0)
		li $t6, 4
		mult $t4, $t6
		mflo $t4
		add $t4, $t4, $t0
		lw $t6, greyBlue
		sw $t6, ($t4)

		paint_platform_new_position:
		lw $t4, ($a0)             # store value at current array index (which is parameter argument $a0) in $t4
		add $t4, $t4, $a1         # platform[i] += $a1 (Use $a1 to determine the new platform positions, whether to move down by 1 unit, or to create new location at top of display)
		sw $t4, ($a0)             # Store the updated position in platform[i]
		li $t6, 4                 # set $t6 to 4
		mult $t4, $t6             # value at current array multiplied by 4
		mflo $t4                  # set $t4 to product, $t4 is now the offset
		add $t4, $t4, $t0         # set $t4 to offset + displayAddress
		lw $t6, tan               # load tan colour value into $t7
		sw $t6, 0($t4)            # Paint the unit tan coloured
		addi $a0, $a0, 4          # Increment array index pointer
		addi $t5, $t5, 1          # Increment counter
		j WHILE_PLATFORM
	PLATFORM_DONE:
	jr $ra

# Function for drawing the shield
draw_shield:
	li $t3, 0
	li $t4, 2
	la $t5, shield
	while_shield:
		beq $t3, $t4, shield_done
		lw $t6, ($t5)
		mul $t6, $t6, 4
		add $t6, $t6, $t0
		lw $s1, greyBlue
		sw $s1, ($t6)

		lw $t6, ($t5)
		add $t6, $t6, $a0         # Move the shield position down (when $a0 = 16)
		sw $t6, ($t5)
		mul $t6, $t6, 4
		add $t6, $t6, $t0
		lw $s1, shieldGold
		sw $s1, ($t6)
		addi $t3, $t3, 1
		addi $t5, $t5, 4
		j while_shield
	shield_done:
	jr $ra

# Function for drawing the bomb
draw_bomb:
	# If $a0 = 0, this means the bomb is being initialized, so I don't need to check for anything, just draw it
	beq $a0, 0, initialize_bomb

	# Check if bomb's current position is equal to doodler's current position
	lw $t3, bomb
	beq $t3, $t2, bomb_check_doodler_shielded
	j continue_bomb_position
	bomb_check_doodler_shielded:
		lw $t3, doodlerShielded
		beq $t3, 0, Exit
		li $t3, 0
		sw $t3, doodlerShielded
		sw $t3, bombBool
		sw $t3, bomb
		la $t3, shield
		sw $zero, ($t3)
		sw $zero, 4($t3)
		j return

	continue_bomb_position:
	# If bomb's current position is equal to boost's position, colour bomb boostPink
	lw $t3, bomb
	lw $t4, boost
	beq $t3, $t4, paint_pink_bomb
	j check_bomb_shield
	paint_pink_bomb:
		mul $t3, $t3, 4
		add $t3, $t3, $t0
		lw $t4, boostPink
		sw $t4, ($t3)
		j paint_bomb_down

	check_bomb_shield:
	# If bomb's current position is equal to one of shield's positions and shield exists, colour bomb shieldGold
	la $t3, shield
	lw $t4, ($t3)
	lw $t5, 4($t3)
	lw $t6, bomb
	beq $t6, $t4, paint_gold_bomb
	beq $t6, $t5, paint_gold_bomb
	j paint_tan_bomb

	paint_gold_bomb:
	lw $t3, shieldBool
	beq $t3, 1, truly_paint_gold
	j paint_tan_bomb
	truly_paint_gold:
	lw $t3, bomb
	lw $t4, shieldGold
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j paint_bomb_down

	# If left or right unit of current bomb's position is tan, colour current position tan
	paint_tan_bomb:
	lw $t6, bomb
	addi $t3, $t6, -1                   # Get left unit of bomb's current position
	addi $t4, $t6, 1                    # Get right unit of bomb's current position
	mul $t3, $t3, 4
	mul $t4, $t4, 4
	add $t3, $t3, $t0                   # $t3 = left unit address
	add $t4, $t4, $t0                   # $t4 = right unit address
	lw $t3, ($t3)                       # $t3 = value of left unit
	lw $t4, ($t4)                       # $t4 = value of right unit
	li $t5, 12153941                    # $t5 = decimal value of tan hexcode
	beq $t3, $t5, paint_tan_bomb_left   # If left unit is tan, paint current bomb's position tan
	beq $t4, $t5, paint_tan_bomb_right  # If right unit is tan, paint current bomb's position tan
	j paint_blue_bomb

	paint_tan_bomb_left:
	lw $t6, bomb
	lw $t3, platformSize
	mul $t3, $t3, -1
	add $t3, $t6, $t3
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue_bomb
	lw $t4, tan                         # Paint the current bomb position tan so it won't be green anymore (matches background) and the old position won't be black
	mul $t3, $t6, 4
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j paint_bomb_down

	paint_tan_bomb_right:
	lw $t6, bomb
	lw $t3, platformSize
	add $t3, $t6, $t3
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	lw $t3, ($t3)
	li $t5, 12153941
	beq $t3, $t5, paint_blue_bomb
	lw $t4, tan                         # Paint the current bomb position tan so it won't be green anymore (matches background) and the old position won't be black
	mul $t3, $t6, 4
	add $t3, $t3, $t0
	sw $t4, ($t3)
	j paint_bomb_down

	paint_blue_bomb:
	lw $t6, bomb
	lw $t4, greyBlue                    # Paint the current bomb position grey blue so it won't be black anymore the new bomb position will be black
	mul $t3, $t6, 4
	add $t3, $t3, $t0
	sw $t4, ($t3)

	# Move the bomb down, paint the new position black
	paint_bomb_down:
	lw $t3, bomb
	add $t3, $t3, $a0
	sw $t3, bomb
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	lw $t4, black
	sw $t4, ($t3)

	# Check if bomb's new position is equal to doodler's current position, if it is, and doodler isn't shielded, exit the game
	# Otherwise, we just get rid of the shield
	lw $t3, bomb
	beq $t3, $t2, bomb_check_doodler_shielded_new
	j return
	bomb_check_doodler_shielded_new:
		lw $t3, doodlerShielded
		beq $t3, 0 Exit
		li $t3, 0
		sw $t3, doodlerShielded
		sw $t3, bombBool
		sw $t3, bomb

	j return

	initialize_bomb:
	lw $t3, bomb
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	lw $t4, black
	sw $t4, ($t3)

	return:
	jr $ra

# Function for drawing boost
draw_boost:
	# Check if current position = doodler's position, if so, set doodlerBoosted to 1 and set boostBool to 0, and don't draw boost
	lw $t3, boost
	beq $t3, $t2, set_boosted
	j continue_drawing_boost
	set_boosted:
		li $t3, 1
		sw $t3, doodlerBoosted
		sw $zero, boostBool
		j return_boost

	continue_drawing_boost:
	lw $t3, boost
	lw $t4, greyBlue
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	sw $t4, ($t3)

	lw $t3, boost
	lw $t4, boostPink
	la $t5, boost
	add $t3, $t3, $a0
	sw $t3, ($t5)
	mul $t3, $t3, 4
	add $t3, $t3, $t0
	sw $t4, ($t3)

	# Check if new position = doodler's position, if so, do same as initial check
	lw $t3, boost
	beq $t3, $t2, set_boosted_new
	j return_boost
	set_boosted_new:
		li $t3, 1
		sw $t3, doodlerBoosted
		sw $zero, boostBool

	return_boost:
	jr $ra

Exit:
	# Draw the end screen here
	lw $t0, displayAddress
	li $t1, 0
	li $t2, 33
	la $t3, end
	while_draw_end:
		beq $t1, $t2, done_draw_end
		lw $t4, ($t3)
		mul $t4, $t4, 4
		add $t4, $t4, $t0
		lw $t5, white
		sw $t5, ($t4)
		addi $t1, $t1, 1
		addi $t3, $t3, 4
		j while_draw_end

	done_draw_end:
	# Print press s to restart
	li $v0, 4
	la $a0, restart
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	# Check to see if s was pressed, if not, keep looping, until s is pressed to restart the game
	check_s_is_pressed:
	lw $t0, 0xffff0000
	beq $t0, 1 check_if_restart

	check_if_restart:
		lw $t0, 0xffff0004
		beq $t0, 0x73, reinitialize

		sw $zero, 0xffff0000
		j check_s_is_pressed

	reinitialize:
	# Reinitialize the variables
	li $t0, 0
	sw $t0, shieldBool
	sw $t0, bombBool
	sw $t0, boostBool
	sw $t0, doodlerShielded
	sw $t0, doodlerBoosted
	sw $t0, bomb
	sw $t0, boost
	la $t0, shield
	sw $zero, ($t0)
	li $t1, 1
	sw $t1, 4($t0)

	li $t0, 125
	sw $t0, seconds

	li $t0, 499
	la $t1, platform1
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 442
	la $t1, platform2
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 371
	la $t1, platform3
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 309
	la $t1, platform4
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 250
	la $t1, platform5
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 178
	la $t1, platform6
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 118
	la $t1, platform7
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 51
	la $t1, platform8
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 424
	la $t1, platform9
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 338
	la $t1, platform10
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 265
	la $t1, platform11
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 179
	la $t1, platform12
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 82
	la $t1, platform13
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 360
	la $t1, platform14
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 226
	la $t1, platform15
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	li $t0, 105
	la $t1, platform16
	sw $t0, ($t1)
	addi $t0, $t0, 1
	sw $t0, 4($t1)
	addi $t0, $t0, 1
	sw $t0, 8($t1)
	addi $t0, $t0, 1
	sw $t0, 12($t1)
	addi $t0, $t0, 1
	sw $t0, 16($t1)

	j initialize

	li $v0, 10 # terminate the program gracefully
	syscall
