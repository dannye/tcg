HandText: ; 3630a (d:630a)
	text "Hand"
	done

CheckText: ; 36310 (d:6310)
	text "Check"
	done

AttackText: ; 36317 (d:6317)
	text "Attack"
	done

PKMNPowerText: ; 3631f (d:631f)
	text "PKMN Power"
	done

DoneText: ; 3632b (d:632b)
	text "Done"
	done

TypeText: ; 36331 (d:6331)
	text "Type"
	done

RetreatText: ; 36337 (d:6337)
	text "Retreat"
	done

WeaknessText: ; 36340 (d:6340)
	text "Weakness"
	done

ResistanceText: ; 3634a (d:634a)
	text "Resistance"
	done

PKMNPWRText: ; 36356 (d:6356)
	text "PKMN PWR"
	done

Text000b: ; 36360 (d:6360)
	db   $56,$19,$33,$3d,$16,$78,$4c
	done

LengthText: ; 36368 (d:6368)
	text "Length"
	done

WeightText: ; 36370 (d:6370)
	text "Weight"
	done

PokemonText: ; 36378 (d:6378)
	text " Pok`mon"
	done

Text000f: ; 36382 (d:6382)
	db   $03,$4c
	done

lbsText: ; 36385 (d:6385)
	text "lbs."
	done

Text0011: ; 3638b (d:638b)
	db   $70
	done

Text0012: ; 3638d (d:638d)
	db   $03,$52
	done

Text0013: ; 36390 (d:6390)
	db   $03,$53
	done

Text0014: ; 36393 (d:6393)
	db   $03,$54
	done

Text0015: ; 36396 (d:6396)
	text " All cards owned:"
	done

Text0016: ; 363a9 (d:63a9)
	text "Total number of cards"
	done

Text0017: ; 363c0 (d:63c0)
	text "Types of cards"
	done

Text0018: ; 363d0 (d:63d0)
	text "Grass Pok`mon"
	done

Text0019: ; 363df (d:63df)
	text "Fire Pok`mon"
	done

Text001a: ; 363ed (d:63ed)
	text "Water Pok`mon"
	done

Text001b: ; 363fc (d:63fc)
	text "Lightning Pok`mon"
	done

Text001c: ; 3640f (d:640f)
	text "Fighting Pok`mon"
	done

Text001d: ; 36421 (d:6421)
	text "Psychic Pok`mon"
	done

Text001e: ; 36432 (d:6432)
	text "Colorless Pok`mon"
	done

Text001f: ; 36445 (d:6445)
	text "Trainer Card"
	done

Text0020: ; 36453 (d:6453)
	text "Energy Card"
	done

Text0021: ; 36460 (d:6460)
	text "Deck"
	done

Text0022: ; 36466 (d:6466)
	text "Attack"
	done

NoPokemonOnTheBenchText: ; 3646e (d:646e)
	text "No Pok`mon on the Bench."
	done

UnableDueToSleepText: ; 36488 (d:6488)
	text "Unable to due to Sleep."
	done

UnableDueToParalysisText: ; 364a1 (d:64a1)
	text "Unable to due to Paralysis."
	done

Received10DamageDueToPoisonText: ; 364be (d:64be)
	text ""
	db   TX_RAM2," received\n"
	db   "10 damage due to Poison."
	done

Received20DamageDueToPoisonText: ; 364e3 (d:64e3)
	text ""
	db   TX_RAM2," received\n"
	db   "20 damage due to Double Poison."
	done

IsStillAsleepText: ; 3650f (d:650f)
	text ""
	db   TX_RAM2," is\n"
	db   "still Asleep."
	done

IsCuredOfSleepText: ; 36523 (d:6523)
	text ""
	db   TX_RAM2," is\n"
	db   "cured of Sleep."
	done

IsCuredOfParalysisText: ; 36539 (d:6539)
	text ""
	db   TX_RAM2," is\n"
	db   "cured of Paralysis."
	done

Text002b: ; 36553 (d:6553)
	text "Between Turns."
	done

Text002c: ; 36563 (d:6563)
	text "Unable to use it."
	done

Text002d: ; 36576 (d:6576)
	text "No Energy cards."
	done

Text002e: ; 36588 (d:6588)
	text "Is this OK?"
	done

YesOrNoText: ; 36595 (d:6595)
	text "Yes     No"
	done

DiscardName: ; 365a1 (d:65a1)
	text "Discard"
	done

Text0031: ; 365aa (d:65aa)
	text "Incomplete"
	done

Text0032: ; 365b6 (d:65b6)
	text "Damage"
	done

Text0033: ; 365be (d:65be)
	text "Used ",TX_RAM2,"."
	done

Text0034: ; 365c7 (d:65c7)
	text "Received damage"
	done

PokemonsAttackText: ; 365d8 (d:65d8)
	text ""
	db   TX_RAM2,"'s\n"
	text TX_RAM2,"!"
	done

Text0036: ; 365e1 (d:65e1)
	text ""
	db   TX_RAM2," received\n"
	db   TX_RAM3," damage due to Resistance!"
	done

Text0037: ; 36609 (d:6609)
	text ""
	db   TX_RAM2," received\n"
	db   TX_RAM3," damage due to Weakness!"
	done

Text0038: ; 3662f (d:662f)
	text ""
	db   TX_RAM2," received\n"
	db   TX_RAM3," damage due to Weakness!"
	done

Text0039: ; 36655 (d:6655)
	text ""
	db   TX_RAM2," did not\n"
	db   "receive damage due to Resistance."
	done

Text003a: ; 36682 (d:6682)
	text ""
	db   TX_RAM2," took\n"
	db   TX_RAM3," damage."
	done

Text003b: ; 36694 (d:6694)
	text ""
	db   TX_RAM2," did not\n"
	db   "receive damage!"
	done

NoSelectableAttackText: ; 366af (d:66af)
	text "No selectable Attack"
	done

UnableToRetreatText: ; 366c5 (d:66c5)
	text "Unable to Retreat."
	done

Text003e: ; 366d9 (d:66d9)
	text "You may only attach 1 Energy card\n"
	db   "per turn."
	done

Text003f: ; 36706 (d:6706)
	text "Use this Pok`mon Power?"
	done

Text0040: ; 3671f (d:671f)
	text "You do not need to select the\n"
	db   "Pok`mon Power to use it."
	done

DiscardDescription: ; 36757 (d:6757)
	text "You may discard this card during\n"
	db   "your turn.\n"
	db   "It will be counted as a Knock Out\n"
	db   "(This Discard is not\n"
	db   "a Pok`mon Power)"
	done

Text0042: ; 367cc (d:67cc)
	text TX_RAM1," will draw ",TX_RAM3," Prize(s)."
	done

Text0043: ; 367e5 (d:67e5)
	text TX_RAM1," drew ",TX_RAM3," Prize(s)."
	done

Text0044: ; 367f9 (d:67f9)
	text ""
	db   TX_RAM1," placed\n"
	db   "a ",TX_RAM2,"."
	done

Text0045: ; 36808 (d:6808)
	text "Unable to select."
	done

Text0046: ; 3681b (d:681b)
	text "Grass\n"
	db   "Fire\n"
	db   "Water\n"
	db   "Lightning\n"
	db   "Fighting\n"
	db   "Psychic"
	done

Text0047: ; 36848 (d:6848)
	db   TX_GRASS
	done

Text0048: ; 3684b (d:684b)
	db   TX_FIRE
	done

Text0049: ; 3684e (d:684e)
	db   TX_WATER
	done

Text004a: ; 36851 (d:6851)
	db   TX_LIGHTNING
	done

Text004b: ; 36854 (d:6854)
	db   TX_FIGHTING
	done

Text004c: ; 36857 (d:6857)
	db   TX_PSYCHIC
	done

Text004d: ; 3685a (d:685a)
	text "Bench"
	done

Text004e: ; 36861 (d:6861)
	text "Knock Out"
	done

DamageToSelfDueToConfusionText: ; 3686c (d:686c)
	text "20 damage to Self due to Confusion."
	done

Text0050: ; 36891 (d:6891)
	text "Choose the Energy card\n"
	db   "you wish to discard."
	done

Text0051: ; 368be (d:68be)
	text "The Active Pok`mon was Knocked Out.\n"
	db   "Please choose the next Pok`mon."
	done

Text0052: ; 36903 (d:6903)
	text "Press START\n"
	db   "When you are ready."
	done

Text0053: ; 36924 (d:6924)
	text "You play first."
	done

Text0054: ; 36935 (d:6935)
	text "You play second."
	done

TransmissionErrorText: ; 36947 (d:6947)
	text "Transmission Error.\n"
	db   "Start again from the beginning."
	done

Text0056: ; 3697c (d:697c)
	text "Choose the card\n"
	db   "you wish to examine."
	done

Text0057: ; 369a2 (d:69a2)
	text "Transmitting data..."
	done

Text0058: ; 369b8 (d:69b8)
	text "Waiting...\n"
	db   "    Hand        Examine"
	done

Text0059: ; 369dc (d:69dc)
	text "Selecting Bench Pok`mon...\n"
	db   "    Hand        Examine     Back"
	done

Text005a: ; 36a19 (d:6a19)
	text ""
	db   TX_RAM2,"\n"
	db   "Retreated to the Bench."
	done

Text005b: ; 36a34 (d:6a34)
	text ""
	db   TX_RAM2,"'s\n"
	db   "Retreat was unsuccessful."
	done

Text005c: ; 36a53 (d:6a53)
	text ""
	db   TX_RAM2," will use the\n"
	db   "Pok`mon Power ",TX_RAM2,"."
	done

Text005d: ; 36a74 (d:6a74)
	text "Finished the Turn\n"
	db   "without Attacking."
	done

Text005e: ; 36a9a (d:6a9a)
	text TX_RAM1,"'s Turn."
	done

Text005f: ; 36aa5 (d:6aa5)
	text "Attached ",TX_RAM2,"\n"
	db   "to ",TX_RAM2,"."
	done

Text0060: ; 36ab7 (d:6ab7)
	text ""
	db   TX_RAM2," evolved\n"
	db   "into ",TX_RAM2,"."
	done

Text0061: ; 36aca (d:6aca)
	text "Placed ",TX_RAM2,"\n"
	db   "on the Bench."
	done

Text0062: ; 36ae2 (d:6ae2)
	text ""
	db   TX_RAM2,"\n"
	db   "was placed in the Arena."
	done

Text0063: ; 36afe (d:6afe)
	text TX_RAM1," shuffles the Deck."
	done

Text0064: ; 36b14 (d:6b14)
	text "Since this is just practice,\n"
	db   "Do not shuffle the Deck."
	done

Text0065: ; 36b4b (d:6b4b)
	text "Each player will\n"
	db   "shuffle the opponent's Deck."
	done

Text0066: ; 36b7a (d:6b7a)
	text "Each player will draw 7 cards."
	done

Text0067: ; 36b9a (d:6b9a)
	text ""
	db   TX_RAM1,"\n"
	db   "drew 7 cards."
	done

Text0068: ; 36bab (d:6bab)
	text TX_RAM1,"'s deck has ",TX_RAM3," cards."
	done

Text0069: ; 36bc2 (d:6bc2)
	text "Choose a Basic Pok`mon\n"
	db   "to place in the Arena."
	done

Text006a: ; 36bf1 (d:6bf1)
	text "There are no Basic Pok`mon\n"
	db   "in ",TX_RAM1,"'s hand."
	done

Text006b: ; 36c1a (d:6c1a)
	text "Neither player has any Basic\n"
	db   "Pok`mon in his or her hand."
	done

Text006c: ; 36c54 (d:6c54)
	text "Return the cards to the Deck\n"
	db   "and draw again."
	done

Text006d: ; 36c82 (d:6c82)
	text "You may choose up to 5 Basic Pok`mon\n"
	db   "to place on the Bench."
	done

Text006e: ; 36cbf (d:6cbf)
	text "Please choose an\n"
	db   "Active Pok`mon."
	done

Text006f: ; 36ce1 (d:6ce1)
	text "Choose your\n"
	db   "Bench Pok`mon."
	done

Text0070: ; 36cfd (d:6cfd)
	text "You drew ",TX_RAM2,"."
	done

Text0071: ; 36d0a (d:6d0a)
	text "You cannot select this card."
	done

Text0072: ; 36d28 (d:6d28)
	text "Placing the Prizes..."
	done

Text0073: ; 36d3f (d:6d3f)
	text "Please place\n"
	db   TX_RAM3," Prizes."
	done

Text0074: ; 36d57 (d:6d57)
	text "If heads,\n"
	text TX_RAM2," plays first."
	done

Text0075: ; 36d72 (d:6d72)
	text "A coin will be tossed\n"
	db   "to decide who plays first."
	done

DecisionText: ; 36da4 (d:6da4)
	text "Decision..."
	done

DuelWasDrawText: ; 36db1 (d:6db1)
	text "The Duel with ",TX_RAM1,"\n"
	db   "was a Draw!"
	done

WonDuelText: ; 36dce (d:6dce)
	text "You won the Duel with ",TX_RAM1,"!"
	done

LostDuelText: ; 36de8 (d:6de8)
	text "You lost the Duel\n"
	db   "with ",TX_RAM1,"..."
	done

StartSuddenDeathMatchText: ; 36e05 (d:6e05)
	text "Start a Sudden-Death\n"
	db   "Match for 1 Prize!"
	done

Text007b: ; 36e2e (d:6e2e)
	text "Prizes Left\n"
	db   "Active Pok`mon\n"
	db   "Cards in Deck"
	done

Text007c: ; 36e58 (d:6e58)
	text "None"
	done

Text007d: ; 36e5e (d:6e5e)
	text "Yes"
	done

Text007e: ; 36e63 (d:6e63)
	text "Cards"
	done

Text007f: ; 36e6a (d:6e6a)
	text ""
	db   TX_RAM1," took\n"
	db   "all the Prizes!"
	done

Text0080: ; 36e82 (d:6e82)
	text "There are no Pok`mon\n"
	db   "in ",TX_RAM1,"'s Play Area!"
	done

WasKnockedOutText: ; 36eaa (d:6eaa)
	text ""
	db   TX_RAM2," was\n"
	db   "Knocked Out!"
	done

Text0082: ; 36ebe (d:6ebe)
	text ""
	db   TX_RAM2," have\n"
	db   "Pok`mon Power."
	done

Text0083: ; 36ed5 (d:6ed5)
	text "Unable to us Pok`mon Power due to\n"
	db   "the effect of Toxic Gas."
	done

Text0084: ; 36f11 (d:6f11)
	text "  Play\n"
	db   "  Check"
	done

Text0085: ; 36f21 (d:6f21)
	text "  Play\n"
	db   "  Check"
	done

Text0086: ; 36f31 (d:6f31)
	text "  Select\n"
	db   "  Check"
	done

Text0087: ; 36f43 (d:6f43)
	db   $03,$31,$0c,$03,$42,$0c
	done

DuelistIsThinkingText: ; 36f4a (d:6f4a)
	text TX_RAM1," is thinking."
	done

Text0089: ; 36f5a (d:6f5a)
	db   $70,$70,$70,$70,$70,$70,$70,$70,$70,$70
	done

Text008a: ; 36f65 (d:6f65)
	text "Select a computer opponent."
	done

Text008b: ; 36f82 (d:6f82)
	text "Number of Prizes"
	done

Text008c: ; 36f94 (d:6f94)
	text "Random 1"
	done

Text008d: ; 36f9e (d:6f9e)
	text "Random 2"
	done

Text008e: ; 36fa8 (d:6fa8)
	text "Random 3"
	done

Text008f: ; 36fb2 (d:6fb2)
	text "Random 4"
	done

Text0090: ; 36fbc (d:6fbc)
	text "Training COM"
	done

Text0091: ; 36fca (d:6fca)
	text "Player 1"
	done

Player2: ; 36fd4 (d:6fd4)
	text "Player 2"
	done

Text0093: ; 36fde (d:6fde)
	text "Left to Right"
	done

Text0094: ; 36fed (d:6fed)
	text "Right to Left"
	done

Text0095: ; 36ffc (d:6ffc)
	text "START: Change\n"
	db   "    A: Execute\n"
	db   "    B: End"
	done

Text0096: ; 37025 (d:7025)
	text "Other\n"
	db   "Poison\n"
	db   "Sleep\n"
	db   "Payalysis\n"
	db   "Confusion\n"
	db   "Double Poison\n"
	db   "Clear\n"
	db   "Foul Gas\n"
	db   "Opponent's Hand\n"
	db   "Discard from Hand\n"
	db   "Select Deck\n"
	db   "Select Discard\n"
	db   "From Hand to Deck\n"
	db   "Take Prize\n"
	db   "Change Player\n"
	db   "Shuffle Deck\n"
	db   "Discard Bench\n"
	db   "Change Card"
	done

Text0097: ; 370f9 (d:70f9)
	text "WIN GAME\n"
	db   "LOSE GAME\n"
	db   "DRAW GAME\n"
	db   "CHANGE CASE\n"
	db   "PAUSE MODE\n"
	db   "CHANGE COMPUTER OPPONENT\n"
	db   "CHANGE PLAYER 2 TO COM\n"
	db   "FLIP 20\n"
	db   "SAVE NOW\n"
	db   "LOAD FILE"
	done

Text0098: ; 37179 (d:7179)
	text "Save File"
	done

Text0099: ; 37184 (d:7184)
	text "Load File\n"
	db   "  ",$07,$60,$06,"  Last Saved File"
	done

Text009a: ; 371a6 (d:71a6)
	text "Pause Mode is ON\n"
	db   "Press SELECT to Pause"
	done

Text009b: ; 371ce (d:71ce)
	text "Pause Mode is OFF"
	done

Text009c: ; 371e1 (d:71e1)
	text "Computer Mode is OFF"
	done

Text009d: ; 371f7 (d:71f7)
	text "Computer Mode is ON"
	done

Text009e: ; 3720c (d:720c)
	text ""
	db   TX_GRASS," Pok`mon\n"
	text ""
	db   TX_FIRE," Pok`mon\n"
	text ""
	db   TX_WATER," Pok`mon\n"
	text ""
	db   TX_LIGHTNING," Pok`mon\n"
	text ""
	db   TX_FIGHTING," Pok`mon\n"
	text ""
	db   TX_PSYCHIC," Pok`mon\n"
	text ""
	db   TX_COLORLESS," Pok`mon\n"
	db   "Trainer Card\n"
	db   "Energy Card"
	done

Text009f: ; 37279 (d:7279)
	text "Card List"
	done

Text00a0: ; 37284 (d:7284)
	text "Test Coin Flip"
	done

Text00a1: ; 37294 (d:7294)
	text "End without Prizes?"
	done

ResetBackUpRamText: ; 372a9 (d:72a9)
	text "Reset Back Up RAM?"
	done

Text00a3: ; 372bd (d:72bd)
	text "Your Data was destroyed\n"
	db   "somehow.\n\n"
	db   "The game cannot be continued\n"
	db   "in its present condition.\n"
	db   "Please restart the game after\n"
	db   "the Data is reset."
	done

NoCardsInHandText: ; 37348 (d:7348)
	text "No cards in hand."
	done

Text00a5: ; 3735b (d:735b)
	text "The Discard Pile has no cards."
	done

Text00a6: ; 3737b (d:737b)
	text "Player's Discard Pile"
	done

Text00a7: ; 37392 (d:7392)
	text TX_RAM1,"'s Hand"
	done

Text00a8: ; 3739c (d:739c)
	text TX_RAM1,"'s Play Area"
	done

Text00a9: ; 373ab (d:73ab)
	text TX_RAM1,"'s Deck"
	done

Text00aa: ; 373b5 (d:73b5)
	text "Please select\n"
	db   "Hand."
	done

Text00ab: ; 373ca (d:73ca)
	text "Please select\n"
	db   "Card."
	done

Text00ac: ; 373df (d:73df)
	text "There are no Pok`mon\n"
	db   "with Damage Counters."
	done

Text00ad: ; 3740b (d:740b)
	text "There are no Damage Counters."
	done

Text00ae: ; 3742a (d:742a)
	text "No Energy cards are attached to\n"
	db   "the opponent's Active Pok`mon."
	done

Text00af: ; 3746a (d:746a)
	text "There are no Energy cards\n"
	db   "in the the Discard Pile."
	done

Text00b0: ; 3749e (d:749e)
	text "There are no Basic Energy cards\n"
	db   "in the Discard Pile."
	done

Text00b1: ; 374d4 (d:74d4)
	text "There are no cards left in the Deck."
	done

Text00b2: ; 374fa (d:74fa)
	text "There is no space on the Bench."
	done

Text00b3: ; 3751b (d:751b)
	text "There are no Pok`mon capable\n"
	db   "of Evolving."
	done

Text00b4: ; 37546 (d:7546)
	text "You cannot Evolve a Pok`mon\n"
	db   "in the same turn it was placed."
	done

Text00b5: ; 37583 (d:7583)
	text "Not affected by Poison,\n"
	db   "Sleep, Paralysis, or Confusion."
	done

Text00b6: ; 375bc (d:75bc)
	text "Not enough cards in Hand."
	done

Text00b7: ; 375d7 (d:75d7)
	text "No Pok`mon on the Bench."
	done

Text00b8: ; 375f1 (d:75f1)
	text "There are no Pok`mon\n"
	db   "in the Discard Pile."
	done

Text00b9: ; 3761c (d:761c)
	text "Conditions for evolving to\n"
	db   "Stage 2 not fulfilled."
	done

Text00ba: ; 3764f (d:764f)
	text "There are no cards in Hand\n"
	db   "that you can change."
	done

Text00bb: ; 37680 (d:7680)
	text "There are no cards in the\n"
	db   "Discard Pile."
	done

Text00bc: ; 376a9 (d:76a9)
	text "There are no Stage 1 Pok`mon\n"
	db   "in the Play Area."
	done

Text00bd: ; 376d9 (d:76d9)
	text "No Energy cards are attached to\n"
	db   "Pok`mon in your Play Area."
	done

Text00be: ; 37715 (d:7715)
	text "No Energy cards attached to Pok`mon\n"
	db   "in your opponent's Play Area."
	done

Text00bf: ; 37758 (d:7758)
	text ""
	db   TX_RAM3," Energy cards\n"
	db   "are required to Retreat."
	done

NotEnoughEnergyCardsText: ; 37781 (d:7781)
	text "Not enough Energy cards."
	done

Text00c1: ; 3779b (d:779b)
	text "Not enough Fire Energy."
	done

Text00c2: ; 377b4 (d:77b4)
	text "Not enough Psychic Energy."
	done

Text00c3: ; 377d0 (d:77d0)
	text "Not enough Water Energy."
	done

Text00c4: ; 377ea (d:77ea)
	text "There are no Trainer Cards\n"
	db   "in the Discard Pile."
	done

Text00c5: ; 3781b (d:781b)
	text "No Attacks may be choosen."
	done

Text00c6: ; 37837 (d:7837)
	text "You did not receive an Attack\n"
	db   "to Mirror Move."
	done

Text00c7: ; 37866 (d:7866)
	text "This attack cannot\n"
	db   "be used twice."
	done

Text00c8: ; 37889 (d:7889)
	text "No Weakness."
	done

Text00c9: ; 37897 (d:7897)
	text "No Resistance."
	done

Text00ca: ; 378a7 (d:78a7)
	text "Only once per turn."
	done

CannotUseDueToStatusText: ; 378bc (d:78bc)
	text "Cannot use due to Sleep, Paralysis,\n"
	db   "or Confusion."
	done

Text00cc: ; 378ef (d:78ef)
	text "Cannot be used in the turn in\n"
	db   "which it was played."
	done

Text00cd: ; 37923 (d:7923)
	text "There is no Energy card attached."
	done

Text00ce: ; 37946 (d:7946)
	text "No Grass Energy."
	done

Text00cf: ; 37958 (d:7958)
	text "Cannot use since there's only\n"
	db   "1 Pok`mon."
	done

Text00d0: ; 37982 (d:7982)
	text "Cannot use because\n"
	db   "it will be Knocked Out."
	done

Text00d1: ; 379ae (d:79ae)
	text "Can only be used on the Bench."
	done

Text00d2: ; 379ce (d:79ce)
	text "There are no Pok`mon on the Bench."
	done

Text00d3: ; 379f2 (d:79f2)
	text "Opponent is not Asleep"
	done

UnableDueToToxicGasText: ; 37a0a (d:7a0a)
	text "Unable to use due to the\n"
	db   "effects of Toxic Gas."
	done

Text00d5: ; 37a3a (d:7a3a)
	text "A Transmission Error occured."
	done

Text00d6: ; 37a59 (d:7a59)
	text "Back Up is broken."
	done

Text00d7: ; 37a6d (d:7a6d)
	text "Error No. 02:\n"
	db   "Printer is not connected."
	done

Text00d8: ; 37a96 (d:7a96)
	text "Error No. 01:\n"
	db   "Batteries have lost their charge."
	done

Text00d9: ; 37ac7 (d:7ac7)
	text "Error No. 03:\n"
	db   "Printer paper is jammed."
	done

Text00da: ; 37aef (d:7aef)
	text "Error No. 02:\n"
	db   "Check cable or printer switch."
	done

Text00db: ; 37b1d (d:7b1d)
	text "Error No. 04:\n"
	db   "Printer Packet Error."
	done

Text00dc: ; 37b42 (d:7b42)
	text "Printing was interrupted."
	done

Text00dd: ; 37b5d (d:7b5d)
	text "Card Pop! cannot be played\n"
	db   "with the Game Boy.\n"
	db   "Please use a\n"
	db   "Game Boy Color."
	done

SandAttackCheckText: ; 37ba9 (d:7ba9)
	text "Sand-attack check!\n"
	db   "If Tails, Attack is unsuccessful."
	done

SmokescreenCheckText: ; 37bdf (d:7bdf)
	text "Smokescreen check!\n"
	db   "If Tails, Attack is unsuccessful."
	done

ParalysisCheckText: ; 37c15 (d:7c15)
	text "Paralysis check!\n"
	db   "If Heads, opponent is Paralyzed."
	done

SleepCheckText: ; 37c48 (d:7c48)
	text "Sleep check!\n"
	db   "If Heads, opponent becomes Asleep."
	done

PoisonCheckText: ; 37c79 (d:7c79)
	text "Poison check!\n"
	db   "If Heads, opponent is Poisoned."
	done

ConfusionCheckText: ; 37ca8 (d:7ca8)
	text "Confusion check! If Heads,\n"
	db   "opponent becomes Confused."
	done

VenomPowderCheckText: ; 37cdf (d:7cdf)
	text "Venom Powder check! If Heads,\n"
	db   "opponent is Poisoned & Confused."
	done

Text00e5: ; 37d1f (d:7d1f)
	text "If Tails,  your Pok`mon\n"
	db   "becomes Confused."
	done

Text00e6: ; 37d4a (d:7d4a)
	text "Damage check!\n"
	db   "If Tails, no damage!!!"
	done

Text00e7: ; 37d70 (d:7d70)
	text "If Heads,\n"
	db   "Draw 1 card from Deck!"
	done

Text00e8: ; 37d92 (d:7d92)
	text "Flip until Tails appears.\n"
	db   "10 damage for each Heads!!!"
	done

Text00e9: ; 37dc9 (d:7dc9)
	text "If Heads, + 10 damage!\n"
	db   "If Tails, +10 damage to yourself!"
	done

Text00ea: ; 37e03 (d:7e03)
	text "10 damage to opponent's Bench if\n"
	db   "Heads, damage to yours if Tails."
	done

Text00eb: ; 37e46 (d:7e46)
	text "If Heads, change opponent's\n"
	db   "Active Pok`mon."
	done

Text00ec: ; 37e73 (d:7e73)
	text "If Heads,\n"
	db   "Heal is successful."
	done

Text00ed: ; 37e92 (d:7e92)
	text "If Tails, ",TX_RAM3," damage\n"
	db   "to yourself, too."
	done

Text00ee: ; 37eb8 (d:7eb8)
	text "Success check!!!\n"
	db   "If Heads, Attack is successful!"
	done

Text00ef: ; 37eea (d:7eea)
	text "Trainer card success check!\n"
	db   "If Heads, you're successful!"
	done

Text00f0: ; 37f24 (d:7f24)
	text "Card check!\n"
	db   "If Heads, 8 cards! If Tails, 1 card!"
	done

Text00f1: ; 37f56 (d:7f56)
	text "If Heads, you will not receive\n"
	db   "damage during opponent's next turn!"
	done

Text00f2: ; 37f9a (d:7f9a)
	text "Damage check"
	done

Text00f3: ; 37fa8 (d:7fa8)
	text "Damage check!\n"
	db   "If Heads, +",TX_RAM3," damage!!"
	done

Text00f4: ; 37fcd (d:7fcd)
	text "Damage check!\n"
	db   "If Heads, x ",TX_RAM3," damage!!"
	done
