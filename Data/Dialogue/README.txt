This is a file explaining how dialogue is formatted in the dialogue.json file

Dialogue Keys
-------------------------------------------------------------------------------
"pre-quest-dialogue"
	This contains the dialogue that is played when you first talk to an npc.
	After this dialogue plays, the quest should be given to the player

"during-quest-dialogue"
	This contains the dialogue that is played if the player decides to talk to
	the npc after getting the qiest but before completing it.

"post-quest-dialogue"
	This contains the dialogue that is played when the quest is completed. The
	dialogue should only be played once when turning in the quest.

"residual-dialogue"
	This contains the dialogue that is played after the quest is completed. The
	dialogue should only play if the player chooses to talk to an npc whose 
	quest is finished
-------------------------------------------------------------------------------

Unique Chars Within Dialogue String Literals
-------------------------------------------------------------------------------
@n
	Tells the dialogue lexer to switch the dialogue box image to the npc
@c
	Tells the dialogue lexer to switch the dialogue box image to the cat
/n
	Tells the dialogue lexer to clear the dialogue box, usually is used to put
	emphasis on certain lines of dialogue or to switch the character who is
	talking.
-------------------------------------------------------------------------------
