INCLUDE "macros.asm"
INCLUDE "constants.asm"

INCLUDE "vram.asm"

SECTION "WRAM0", WRAM0

UNION

wTempCardCollection:: ; c000
	ds $100

NEXTU

wc000:: ; c000
	ds $100

NEXTU

; aside from wDecompressionBuffer, which stores the
; de facto final decompressed data after decompression,
; this buffer stores a secondary buffer that is used
; for "lookbacks" when repeating byte sequences.
; actually starts in the middle of the buffer,
; at wDecompressionSecondaryBufferStart, then wraps back up
; to wDecompressionSecondaryBuffer.
; this is used so that $00 can be "looked back", since anything
; before $ef is initialized to 0 when starting decompression.
wDecompressionSecondaryBuffer:: ; c000
	ds $ef
wDecompressionSecondaryBufferStart:: ; c0ef
	ds $11

NEXTU

; names of the last players who have done
; Card Pop! with current save file
wCardPopNameList:: ; c000
	ds CARDPOP_NAME_LIST_SIZE

NEXTU

; buffer used to store a deck that will be built
wDeckToBuild:: ; c000
	ds DECK_STRUCT_SIZE

ENDU

	ds $100

SECTION "WRAM0 Duels 1", WRAM0

; this union spans from c200 to c3ff
UNION

; In order to be identified during a duel, the 60 cards of each duelist are given an index between 0 and 59.
; These indexes are assigned following the order of the card list in wPlayerDeck or wOpponentDeck,
; which, in turn, follows the internal order of the cards.
; This temporary index of a card identifies the card within the duelist's deck during an ongoing duel.

; Terminology used in labels and comments:
; - The deck index, or the index within the deck of a card refers to the identifier mentioned just above,
;   that is, its temporary position in the wPlayerDeck or wOpponentDeck card list during the current duel.
; - The card ID is its actual internal identifier, that is, its number from card_constants.asm.
; check macros/wram.asm for information on each variable
wPlayerDuelVariables::   duel_vars wPlayer   ; c200
wOpponentDuelVariables:: duel_vars wOpponent ; c300

NEXTU

; buffer used to store the Card Pop! name list
; that is received from the other player
wOtherPlayerCardPopNameList:: ; c200
	ds CARDPOP_NAME_LIST_SIZE

ENDU

UNION

; temporary list of the cards drawn from a booster pack
wBoosterCardsDrawn:: ; c400
wBoosterTempNonEnergiesDrawn:: ; c400
	ds $b
wBoosterTempEnergiesDrawn:: ; c40b
	ds $b
wBoosterCardsDrawnEnd:: ; c416
	ds $6a

NEXTU

wPlayerDeck:: ; c400
	ds $80

NEXTU

; lists all the possible candidates of cards
; that can be received through Card Pop!
wCardPopCardCandidates:: ; c400
	ds $80

ENDU

wOpponentDeck:: ; c480
	ds $80

; this holds names like player's or opponent's.
wNameBuffer:: ; c500
	ds NAME_BUFFER_LENGTH

; this holds an $ff-terminated list of card deck indexes (e.g. cards in hand or in bench)
; or (less often) the attack list of a Pokemon card
wDuelTempList:: ; c510
	ds $80

UNION

; this is kept updated with some default text that is used
; when the text printing functions are called with text id $0000
wDefaultText:: ; c590
	ds $3c

NEXTU

; used in CheckIfCurrentDeckWasChanged to determine whether
; wCurDeckCards was changed from the original
; deck it was based on
wCurDeckCardChanges:: ; c590
	ds DECK_SIZE + 1

ENDU

	ds $1d

; signals what error, if any, occurred
; during IR communications
; 0 means there was no error
wIRCommunicationErrorCode:: ; c5ea
	ds $1

; parameters set for IR communications on own device
; and received from the other device respectively
; these must match for successful communication
wOwnIRCommunicationParams:: ; c5eb
	ds $4
wOtherIRCommunicationParams:: ; c5ef
	ds $4

; stores the result from LookUpNameInCardPopNameList
; is $ff if name was found in the Card Pop! list
; is $00 otherwise
wCardPopNameSearchResult:: ; c5f3
	ds $1

	ds $c

SECTION "WRAM0 Text Engine", WRAM0

wc600:: ; c600
	ds $100

wc700:: ; c700
	ds $100

wc800:: ; c800
	ds $100

wc900:: ; c900
	ds $100

SECTION "WRAM0 1", WRAM0

wOAM:: ; ca00
	ds $a0

; 16-byte buffer to store text, usually a name or a number
; used by TX_RAM1 but not exclusively
wStringBuffer:: ; caa0
	ds $10

wcab0:: ; cab0
	ds $1

wcab1:: ; cab1
	ds $1

wcab2:: ; cab2
	ds $1

; initial value of the A register. used to tell the console when reset
wInitialA:: ; cab3
	ds $1

; what console we are playing on, either 0 (DMG), 1 (SGB) or 2 (CGB)
; use constants CONSOLE_DMG, CONSOLE_SGB and CONSOLE_CGB for checks
wConsole:: ; cab4
	ds $1

; used to select a sprite or a starting sprite from wOAM
wOAMOffset:: ; cab5
	ds $1

; FillTileMap fills VRAM0 BG Maps with the tile stored here
wTileMapFill:: ; cab6
	ds $1

wIE:: ; cab7
	ds $1

; incremented whenever the vblank handler ends. used to wait for it to end,
; or to delay a specific amount of frames
wVBlankCounter:: ; cab8
	ds $1

	ds $1

; bit0: is in vblank interrupt?
; bit1: is in timer interrupt?
wReentrancyFlag:: ; caba
	ds $1

wLCDC:: ; cabb
	ds $1

wBGP:: ; cabc
	ds $1

wOBP0:: ; cabd
	ds $1

wOBP1:: ; cabe
	ds $1

; used to request palette(s) to be flushed by FlushPalettes from wBGP, wOBP0, wOBP1,
; wBackgroundPalettesCGB, and/or wBackgroundPalettesCGB to the corresponding hw registers
wFlushPaletteFlags:: ; cabf
	ds $1

; set to non-0 to request OAM copy during vblank
wVBlankOAMCopyToggle:: ; cac0
	ds $1

; used by HblankWriteByteToBGMap0
wTempByte:: ; cac1
	ds $1

; which screen or interface is currently displayed in the screen during a duel
; used to prevent loading graphics or drawing stuff more times than necessary
wDuelDisplayedScreen:: ; cac2
	ds $1

; used to increase the play time counter every four timer interrupts (60.24 Hz)
wTimerCounter:: ; cac3
	ds $1

wPlayTimeCounterEnable:: ; cac4
	ds $1

; byte0: 1/60ths of a second
; byte1: seconds
; byte2: minutes
; byte3: hours (lower byte)
; byte4: hours (upper byte)
wPlayTimeCounter:: ; cac5
	ds $5

wRNG1:: ; caca
	ds $1

wRNG2:: ; cacb
	ds $1

wRNGCounter:: ; cacc
	ds $1

; the LCDC status interrupt is always disabled and this always reads as jp $0000
wLCDCFunctionTrampoline:: ; cacd
	ds $3

; a jp $nnnn instruction called by the vblank handler. calls a single ret by default
wVBlankFunctionTrampoline:: ; cad0
	ds $3

; pointer to a function to be called by DoFrame
wDoFrameFunction:: ; cad3
	ds $2

; if non-zero, the game screen can be paused at any time with the select button
wDebugPauseAllowed:: ; cad5
	ds $1

; pointer to keep track of where
; in the source data we are while
; running the decompression algorithm
wDecompSourcePosPtr:: ; cad6
	ds $2

; number of bits that are still left
; to read from the current command byte
wDecompNumCommandBitsLeft:: ; cad8
	ds $1

; command byte from which to read the bits
; to decompress source data
wDecompCommandByte:: ; cad9
	ds $1

; if bit 7 is changed from off to on, then
; decompression routine will read next two bytes
; for repeating previous sequence (length, offset)
; if it changes from on to off, then the routine
; will only read one byte, and reuse previous length byte
wDecompRepeatModeToggle:: ; cada
	ds $1

; stores in both nybbles the length of the
; sequences to copy in decompression
; the high nybble is used first, then the low nybble
; for a subsequent sequence repetition
wDecompRepeatLengths:: ; cadb
	ds $1

wDecompNumBytesToRepeat:: ; cadc
	ds $1

wDecompSecondaryBufferPtrHigh:: ; cadd
	ds $1

; offset to repeat byte from decompressed data
wDecompRepeatSeqOffset:: ; cade
	ds $1

wDecompSecondaryBufferPtrLow:: ; cadf
	ds $1

wTempSGBPacket:: ; cae0
	ds $10

; temporary CGB palette data buffer to eventually save into BGPD registers.
wBackgroundPalettesCGB:: ; caf0
	ds NUM_BACKGROUND_PALETTES palettes

; temporary CGB palette data buffer to eventually save into OBPD registers.
wObjectPalettesCGB:: ; cb30
	ds NUM_OBJECT_PALETTES palettes

	ds $2

; stores a pointer to a temporary list of elements (e.g. pointer to wDuelTempList)
; to be read or written sequentially
wListPointer:: ; cb72
	ds $2

SECTION "WRAM0 Serial Transfer", WRAM0

wSerialOp:: ; cb74
	ds $1

wSerialFlags:: ; cb75
	ds $1

wSerialCounter:: ; cb76
	ds $1

wSerialCounter2:: ; cb77
	ds $1

wSerialTimeoutCounter:: ; cb78
	ds $1

wcb79:: ; cb79
	ds $2

wcb7b:: ; cb7b
	ds $2

wSerialSendSave:: ; cb7d
	ds $1

wSerialSendBufToggle:: ; cb7e
	ds $1

wSerialSendBufIndex:: ; cb7f
	ds $1

wcb80:: ; cb80
	ds $1

wSerialSendBuf:: ; cb81
	ds $20

wSerialLastReadCA:: ; cba1
	ds $1

wSerialRecvCounter:: ; cba2
	ds $1

wcba3:: ; cba3
	ds $1

wSerialRecvIndex:: ; cba4
	ds $1

wSerialRecvBuf:: ; cba5
	ds $20

wSerialEnd:: ; cbc5

SECTION "WRAM0 Duels 2", WRAM0

	ds $1

; In a duel, the main menu current or last selected menu item
; From 0 to 5: Hand, Attack, Check, Pkmn Power, Retreat, Done
wCurrentDuelMenuItem:: ; cbc6
	ds $1

; When we're viewing a card's information, the page we are currently at.
; For Pokemon cards, values from $1 to $6 (two pages for attack descriptions)
; For Energy cards, it's always $9
; For Trainer cards, $d or $e (two pages for trainer card descriptions)
; see CARDPAGE_* constants
wCardPageNumber:: ; cbc7
	ds $1

; how many selectable items are in a play area screen. used to set wNumMenuItems
; in order to navigate through a play area screen. this becomes the number of bench
; Pokemon cards if wExcludeArenaPokemon is 1, and that number plus 1 if it's 0.
wNumPlayAreaItems:: ; cbc8
	ds $1

; selects a PLAY_AREA_* slot in order to display information related to it. used by functions
; such as PrintPlayAreaCardLocation, PrintPlayAreaCardInformation and PrintPlayAreaCardHeader
wCurPlayAreaSlot:: ; cbc9

; X position to display the attached energies, HP bar, and Pluspower/Defender icons
; obviously different for player and opponent side. used by DrawDuelHUD.
wHUDEnergyAndHPBarsX:: ; cbc9
	ds $1

; current Y coordinate where some play area information is being printed at. used by functions
; such as PrintPlayAreaCardLocation, PrintPlayAreaCardInformation and PrintPlayAreaCardHeader
wCurPlayAreaY:: ; cbca

; Y position to display the attached energies, HP bar, and Pluspower/Defender icons
; obviously different for player and opponent side. used by DrawDuelHUD.
wHUDEnergyAndHPBarsY:: ; cbca

wPracticeDuelTextY:: ; cbca
	ds $1

; selected bench slot (1-5, that is, a PLAY_AREA_BENCH_* constant)
wBenchSelectedPokemon:: ; cbcb
	ds $1

; used by CheckIfEnoughEnergiesToRetreat and DisplayRetreatScreen
wEnergyCardsRequiredToRetreat:: ; cbcc
	ds $1

wNumRetreatEnergiesSelected:: ; cbcd
	ds $1

; used in CheckIfEnoughEnergiesToAttack for the calculation
wAttachedEnergiesAccum:: ; cbce
	ds $1

; when you're in a duel submenu like the cards in your hand and you press A,
; the following two addresses keep track of which item was selected by the cursor
wSelectedDuelSubMenuItem:: ; cbcf
	ds $1

wSelectedDuelSubMenuScrollOffset:: ; cbd0
	ds $1

; CARDPAGETYPE_PLAY_AREA or CARDPAGETYPE_NOT_PLAY_AREA
; some of the elements displayed in a card page change depending on which value
wCardPageType:: ; cbd1
	ds $1

; when processing or displaying the play area Pokemon cards of a duelist,
; whether to account for only the benched Pokemon ($01) or also the arena Pokemon ($00).
wExcludeArenaPokemon:: ; cbd2
	ds $1

wPlayAreaScreenLoaded:: ; cbd3
	ds $1

; determines what to do when player presses the Select button
; while viewing the Play Area:
; - if $0 or $2: no action
; - if $1: menu is accessible where player can examine Hand or other screens
; $2 is reserved for OpenVariousPlayAreaScreens_FromSelectPresses
wPlayAreaSelectAction:: ; cbd4
	ds $1

; low byte of the address of the next slot in the hTempRetreatCostCards array to be used
wTempRetreatCostCardsPos:: ; cbd5
	ds $1

; in a card list, which keys (among START and A_BUTTON) do not open the item selection
; menu when a card is selected, directly "submitting" the selected card instead.
wNoItemSelectionMenuKeys:: ; cbd6
	ds $1

; when viewing a card page, which keys (among B_BUTTON, D_UP, and D_DOWN) will exit the page,
; either to go back to the previous menu or list, or to load the card page of the card above/below it
wCardPageExitKeys:: ; cbd7
	ds $1

; used to store function pointer for printing card order
; in card list reordering screen.
wPrintSortNumberInCardListPtr:: ; cbd8
	ds $2

; in the hand or discard pile card screen, id of the text printed in the bottom-left box
wCardListInfoBoxText:: ; cbda
	ds $2

; in the hand or discard pile card screen, id of the text printed as the header title
wCardListHeaderText:: ; cbdc
	ds $2

; when selecting an item of a list of cards which type of menu shows up.
; PLAY_CHECK, SELECT_CHECK, or $00 for none.
wCardListItemSelectionMenuType:: ; cbde
	ds $1

; flag indicating whether a list of cards should be sorted by ID
wSortCardListByID:: ; cbdf
	ds $1

wEnergyDiscardPlayAreaLocation:: ; cbe0
	ds $1

wOpponentTurnEnded:: ; cbe1
	ds $1

wOppRNG1:: ; cbe2
	ds $1

wOppRNG2:: ; cbe3
	ds $1

wOppRNGCounter:: ; cbe4
	ds $1

; sp is saved here when starting a duel, in order to save the return address
; however, it only seems to be read after a transmission error in a link duel
wDuelReturnAddress:: ; cbe5
	ds $2

; if non-zero, duel menu input is not checked
wDebugSkipDuelMenuInput:: ; cbe7
	ds $1

wNumCardsTryingToDraw:: ; cbe8
	ds $1

; number of cards being drawn in order to animate the number of cards in
; the hand and in the deck in the draw card screen
wNumCardsBeingDrawn:: ; cbe9
	ds $1

	ds $3

; temporarily stores 8 bytes for serial send/recv.
; used by SerialSend8Bytes and SerialRecv8Bytes
wTempSerialBuf:: ; cbed
	ds $8

	ds $2

; return address for when the Link Opponent has
; made a decision on his turn, so that the duel continues
wLinkOpponentTurnReturnAddress:: ; cbf7
	ds $2

; when non-0, AIMakeDecision doesn't wait 60 frames and print DuelistIsThinkingText
wSkipDuelistIsThinkingDelay:: ; cbf9
	ds $1

wEnergyDiscardMenuDenominator:: ; cbfa
	ds $1

wEnergyDiscardMenuNumerator:: ; cbfb
	ds $1

; used by TurnDuelistTakePrizes to store the remaining Prizes, so that if more than that
; amount would be taken, only the remaining amount is taken
wTempNumRemainingPrizeCards:: ; cbfc
	ds $1

; if FALSE, player is placing initial arena pokemon
; if TRUE, player is placing initial bench pokemon
wPlacingInitialBenchPokemon:: ; cbfd
	ds $1

; during a practice duel, identifies an entry of PracticeDuelActionTable
wPracticeDuelAction:: ; cbfe
	ds $1

wDuelMainSceneSelectHotkeyAction:: ; cbff
	ds $1

wPracticeDuelTurn:: ; cc00
	ds $1

; pointer from PracticeDuelTextPointerTable
wPracticeDuelTextPointer:: ; cc01
	ds $2

; used to print a Pokemon card's length in feet and inches
wPokemonLengthPrintOffset:: ; cc03
	ds $1

; used when opening the card page of an attack when attacking,
; serving as an index for AttackPageDisplayPointerTable.
; see ATTACKPAGE_* constants
wAttackPageNumber:: ; cc04
	ds $1

; the value of hWhoseTurn gets loaded here at the beginning of each duelist's turn.
; more reliable than hWhoseTurn, as hWhoseTurn may change temporarily in order to handle status
; conditions or other events of the non-turn duelist. used mostly between turns (to check which
; duelist's turn just finished), or to restore the value of hWhoseTurn at some point.
wWhoseTurn:: ; cc05
	ds $1

; number of turns taken by both players
wDuelTurns:: ; cc06
	ds $1

; used to signal that the current duel has finished, not to be mistaken with wDuelResult
; 0 = no one has won duel yet
; 1 = player whose turn it is has won the duel
; 2 = player whose turn it is has lost the duel
; 3 = duel ended in a draw (start sudden death match)
wDuelFinished:: ; cc07
	ds $1

; current duel is a [wDuelInitialPrizes]-prize match
wDuelInitialPrizes:: ; cc08
	ds $1

; a DUELTYPE_* constant. note that for a practice duel, wIsPracticeDuel must also be set to $1
wDuelType:: ; cc09
	ds $1

; set to 1 if the coin toss during the CheckSandAttackOrSmokescreenSubstatus check is heads
wGotHeadsFromSandAttackOrSmokescreenCheck:: ; cc0a
	ds $1

wAlreadyPlayedEnergy:: ; cc0b
	ds $1

; set to TRUE if the confusion check coin toss in AttemptRetreat is tails
wConfusionRetreatCheckWasUnsuccessful:: ; cc0c
	ds $1

; DUELIST_TYPE_* of the turn holder
wDuelistType:: ; cc0d
	ds $1

; this holds the current opponent's deck minus 2 (that is, a *_DECK_ID constant),
; in order to account for the two unused pointers at the beginning of DeckPointers.
wOpponentDeckID:: ; cc0e
	ds $1

wcc0f:: ; cc0f
	ds $1

; index (0-1) of the attack or Pokemon Power being used by the player's arena card
; set to $ff when the duel starts and at the end of the opponent's turn
wPlayerAttackingAttackIndex:: ; cc10
	ds $1

; deck index of the player's arena card that is attacking or using a Pokemon Power
; set to $ff when the duel starts and at the end of the opponent's turn
wPlayerAttackingCardIndex:: ; cc11
	ds $1

; ID of the player's arena card that is attacking or using a Pokemon Power
wPlayerAttackingCardID:: ; cc12
	ds $1

wIsPracticeDuel:: ; cc13
	ds $1

wNPCDuelistCopy:: ; cc14
	ds $1

wOpponentPortrait:: ; cc15
	ds $1

; text id of the opponent's name
wOpponentName:: ; cc16
	ds $2

; an overworld script starting a duel sets this address to the value to be written into wDuelInitialPrizes
wNPCDuelPrizes:: ; cc18
	ds $1

; an overworld script starting a duel sets this address to the value to be written into wOpponentDeckID
wNPCDuelDeckID:: ; cc19
	ds $1

; song played during a duel
wDuelTheme:: ; cc1a
	ds $1

; holds the energies attached to a given pokemon card. 1 byte for each of the
; 8 energy types (includes the unused one that shares byte with the colorless energy)
wAttachedEnergies:: ; cc1b
	ds NUM_TYPES

; holds the total amount of energies attached to a given pokemon card
wTotalAttachedEnergies:: ; cc23
	ds $1

; Used as temporary storage for a card's data
wLoadedCard1:: ; cc24
	card_data_struct wLoadedCard1
wLoadedCard2:: ; cc65
	card_data_struct wLoadedCard2
wLoadedAttack:: ; cca6
	atk_data_struct wLoadedAttack

; the damage field of a used attack is loaded here
; doubles as "wAIAverageDamage" when complementing wAIMinDamage and wAIMaxDamage
; little-endian
; second byte may have UNAFFECTED_BY_WEAKNESS_RESISTANCE_F set/unset
wDamage:: ; ccb9
	ds $2

; wAIMinDamage and wAIMaxDamage appear to be used for AI scoring
; they are updated with the minimum (or floor) damage of the current attack
; and with the maximum (or ceiling) damage of the current attack
wAIMinDamage:: ; ccbb
	ds $1

wAIMaxDamage:: ; ccbc
	ds $1

wccbd:: ; ccbd
	ds $2

; damage dealt by an attack to a target
wDealtDamage:: ; ccbf
	ds $2

; WEAKNESS and RESISTANCE flags for a damaging attack
wDamageEffectiveness:: ; ccc1
	ds $1

; used in damage related functions
wTempCardID_ccc2:: ; ccc2
	ds $1

wTempTurnDuelistCardID:: ; ccc3
	ds $1

wTempNonTurnDuelistCardID:: ; ccc4
	ds $1

; the status condition of the defending Pokemon is loaded here after an attack
wccc5:: ; ccc5
	ds $1

; *_ATTACK constants for selected attack
; 0 for the first attack (or PKMN Power)
; 1 for the second attack
wSelectedAttack:: ; ccc6
	ds $1

; if affected by a no damage or effect substatus, this flag indicates what the cause was
wNoDamageOrEffect:: ; ccc7
	ds $1

; used by CountKnockedOutPokemon and TurnDuelistTakePrizes to store the amount
; of prizes to take (equal to the number of Pokemon knocked out)
wNumberPrizeCardsToTake:: ; ccc8
	ds $1

; set to TRUE if the coin toss in the confusion check is tails (CheckSelfConfusionDamage)
wConfusionAttackCheckWasUnsuccessful:: ; ccc9
	ds $1

; used to store card indices of all stages, in order, of a Play Area Pokémon
wAllStagesIndices:: ; ccca
	ds $3

wStatusConditionQueueIndex:: ; cccd
	ds $1

; 3-byte array used in effect functions with wStatusConditionQueueIndex as the index,
; used to inflict a variable number of status conditions to Arena Pokemon (max 8)
; byte 1: which duelist side
; byte 2: conditions to remove (e.g. paralysis removes poison condition)
; byte 3: conditions to inflict
wStatusConditionQueue:: ; ccce
	ds 3 * 8

; this is 1 (non-0) if dealing damage to self due to confusion
; or a self-destruct type attack
wIsDamageToSelf:: ; cce6
	ds $1

wcce7:: ; cce7
	ds $1

wDuelFinishParam:: ; cce8
	ds $1

; text ID of the name of the deck loaded by CopyDeckData
wDeckName:: ; cce9
	ds $2

; a PLAY_AREA_* constant (0: arena card, 1-5: bench card)
wTempPlayAreaLocation_cceb:: ; cceb
	ds $1

wccec:: ; ccec
	ds $1

; used by the effect functions to return the cause of an effect to fail
; in order print the appropriate text
wEffectFailed:: ; cced
	ds $1

wPreEvolutionPokemonCard:: ; ccee
	ds $1

; whether Defending Pokemon was forced to switch due to an attack
; determines whether DUELVARS_ARENA_CARD_LAST_TURN_DAMAGE
; gets zeroed or gets updated with wDealtDamage
wDefendingWasForcedToSwitch:: ; ccef
	ds $1

; stores the energy cost of the Metronome attack being used.
; it's used to know how many attached Energy cards are being used
; to pay for the attack for damage calculation.
; if equal to 0, then the attack wasn't invoked by Metronome.
wMetronomeEnergyCost:: ; ccf0
	ds $1

; effect functions return a status condition constant here when it had no effect
; on the target, in order to print one of the ThereWasNoEffectFrom* texts
wNoEffectFromWhichStatus:: ; ccf1
	ds $1

; when non-0, allows the player to skip some delays during a duel by pressing B.
; value read from sSkipDelayAllowed. probably only used for debugging.
wSkipDelayAllowed:: ; ccf2
	ds $1

SECTION "WRAM0 2", WRAM0

; on CGB, attributes of the text box borders. (values 0-7 seem to be used, which only affect palette)
; on SGB, colorize text box border with SGB1 if non-0
wTextBoxFrameType:: ; ccf3
	ds $1

; pixel data of a tile used for text
; either a combination of two half-width characters or a full-width character
wTextTileBuffer:: ; ccf4
	ds TILE_SIZE

wcd04:: ; cd04
	ds $1

; used by PlaceNextTextTile
wCurTextTile:: ; cd05
	ds $1

; VRAM tile patterns selector for text tiles
; if wTilePatternSelector == $80 and wTilePatternSelectorCorrection == $00 -> select tiles at $8000-$8FFF
; if wTilePatternSelector == $88 and wTilePatternSelectorCorrection == $80 -> select tiles at $8800-$97FF
wTilePatternSelector:: ; cd06
	ds $1

; complements wTilePatternSelector by correcting the VRAM tile order when $8800-$97FF is selected
; a value of $80 in wTilePatternSelectorCorrection reflects tiles $00-$7f being located after tiles $80-$ff
wTilePatternSelectorCorrection:: ; cd07
	ds $1

; if 0 (DOUBLE_SPACED), text lines are separated by a blank line
; uses constants DOUBLE_SPACED and SINGLE_SPACED
wLineSeparation:: ; cd08
	ds $1

; line number in which text is being printed as an offset to
; the topmost line, including separator lines
wCurTextLine:: ; cd09
	ds $1

; how to process the current text tile
; 0: full-width font | non-0: half-width font
wFontWidth:: ; cd0a
	ds $1

; when printing half-width text, this variable alternates between 0 and the value
; of the first character. 0 signals that no text should be printed in the current
; iteration of Func_235e, while non-0 means to print the character pair
; made of [wHalfWidthPrintState] (first char) and register e (second char).
wHalfWidthPrintState:: ; cd0b
	ds $1

; used by CopyTextData
wTextMaxLength:: ; cd0c
	ds $1

; half-width font letters become uppercase if non-0, lowercase if 0
wUppercaseHalfWidthLetters:: ; cd0d
	ds $1

	ds $1

; handles timing of (horizontal or vertical) arrow blinking while waiting for user input.
wCursorBlinkCounter:: ; cd0f
	ds $1

wCurMenuItem:: ; cd10
	ds $1

wMenuParams:: ; cd11

wMenuCursorXOffset:: ; cd11
	ds $1

wMenuCursorYOffset:: ; cd12
	ds $1

wMenuYSeparation:: ; cd13
	ds $1

wNumMenuItems:: ; cd14
	ds $1

wMenuVisibleCursorTile:: ; cd15
	ds $1

wMenuInvisibleCursorTile:: ; cd16
	ds $1

; if non-NULL, the function loaded here is called once per frame by HandleMenuInput
wMenuUpdateFunc:: ; cd17
	ds $2

wMenuParamsEnd::

wListScrollOffset:: ; cd19
	ds $1

wListItemXPosition:: ; cd1a
	ds $1

wNumListItems:: ; cd1b
	ds $1

wListItemNameMaxLength:: ; cd1c
	ds $1

; if not NULL, the function loaded here is called once per frame by CardListMenuFunction,
; which is the function loaded to wMenuUpdateFunc for card lists
wListFunctionPointer:: ; cd1d
	ds $2

	ds $78

; in a card list, the Y position where the <sel_item>/<num_items> indicator is placed
; if wCardListIndicatorYPosition == $ff, no indicator is displayed
wCardListIndicatorYPosition:: ; cd97
	ds $1

; x coord of the leftmost item in a horizontal menu
wLeftmostItemCursorX:: ; cd98
	ds $1

; used in RefreshMenuCursor_CheckPlaySFX to play a sound during any frame when this address is non-0
wRefreshMenuCursorSFX:: ; cd99
	ds $1

; when printing a YES/NO menu, whether the cursor is
; initialized to the YES ($01) or to the NO ($00) item
wDefaultYesOrNo:: ; cd9a
	ds $1

; used in _CopyCardNameAndLevel to keep track of the remaining space to copy the text
wCardNameLength:: ; cd9b
	ds $1

; stores the total number of coins to flip
wCoinTossTotalNum:: ; cd9c
	ds $1

; this stores the result from a coin toss (number of heads)
wCoinTossNumHeads:: ; cd9d
	ds $1

; stores type of the duelist that is tossing coins
wCoinTossDuelistType:: ; cd9e
	ds $1

; holds the number of coins that have already been tossed
wCoinTossNumTossed:: ; cd9f
	ds $1

	ds $5

wAIDuelVars::
; saves the prizes that the AI already used Peek on
; each bit corresponds to a Prize card
wAIPeekedPrizes:: ; cda5
	ds $1

; this is used by AI in order to determine whether
; it should use Pokedex Trainer card.
; starts with 5 when Duel starts and counts up by 1 every turn.
; only when it's higher than 5 is AI allowed to use Pokedex,
; in which case it sets the counter to 0.
; this stops the AI from using Pokedex right after using another one
; while still drawing cards that were ordered.
wAIPokedexCounter:: ; cda6
	ds $1

; variable to keep track of MewtwoLv53's Barrier usage during Player' turn.
; AI_MEWTWO_MILL set means Player is running MewtwoLv53 mill deck.
; 	- when flag is not set, this counts how many turns in a row
;	  Player used MewtwoLv53's Barrier attack;
;	- when flag is set, this counts how many turns in a row
;	  Player has NOT used Barrier attack.
wAIBarrierFlagCounter:: ; cda7
	ds $1

; pointer to $00-terminated list of card IDs
; to avoid being placed as prize cards
; when setting up AI duelist's cards at duel start.
; (see SetUpBossStartingHandAndDeck)
wAICardListAvoidPrize:: ; cda8
	ds $2

; pointer to $00-terminated list of card IDs
; sorted by priority of AI placing in the Arena
; at duel start (see TrySetUpBossStartingPlayArea)
wAICardListArenaPriority:: ; cdaa
	ds $2

; pointer to $00-terminated list of card IDs
; sorted by priority of AI placing in the Bench
; at duel start (see TrySetUpBossStartingPlayArea)
wAICardListBenchPriority:: ; cdac
	ds $2

; pointer to $00-terminated list of card IDs
; sorted by priority of AI playing it from Hand
; to the Bench (see AIDecidePlayPokemonCard)
wAICardListPlayFromHandPriority:: ; cdae
	ds $2

; pointer to $00-terminated list of card IDs and AI scores.
; these are for giving certain cards more or less
; likelihood of being picked by AI to switch to.
; (see AIDecideBenchPokemonToSwitchTo)
wAICardListRetreatBonus:: ; cdb0
	ds $2

; pointer to $00-terminated list of card IDs,
; number of energy cards and AI score.
; these are for giving certain cards more or less
; likelihood of being picked for AI to attach energy.
; also has the maximum number of energy cards that
; the AI is willing to provide for it.
; (see AIProcessEnergyCards)
wAICardListEnergyBonus:: ; cdb2
	ds $2

; used by the AI to track how viable
; retreating the current Active card is
wAIRetreatScore:: ; cdb4
	ds $1

wAIDuelVarsEnd::

; information about various properties of
; loaded attack for AI calculations
wTempLoadedAttackEnergyCost:: ; cdb5
	ds $1
wTempLoadedAttackEnergyNeededType:: ; cdb6
	ds $1
wTempLoadedAttackEnergyNeededAmount:: ; cdb7
	ds $1

; used for the AI to store various
; details about a given card
wTempCardRetreatCost:: ; cdb8
	ds $1
wTempCardID:: ; cdb9
	ds $1
wTempCardType:: ; cdba
	ds $1

	ds $3

; used for AI to score decisions for actions
wAIScore:: ; cdbe
	ds $1

UNION

; used for AI decisions that involve
; each card in the Play Area.
wPlayAreaAIScore:: ; cdbf
	ds MAX_PLAY_AREA_POKEMON

NEXTU

; stores the score determined by AI for first attack
wFirstAttackAIScore:: ; cdbf
	ds $1

ENDU

	ds $a

; information about the defending Pokémon and
; the prize card count on both sides for AI:
; player's active Pokémon color
wAIPlayerColor:: ; cdcf
	ds $1
; player's active Pokémon weakness
wAIPlayerWeakness:: ; cdd0
	ds $1
; player's active Pokémon resistance
wAIPlayerResistance:: ; cdd1
	ds $1
; player's prize count
wAIPlayerPrizeCount:: ; cdd2
	ds $1
; opponent's prize count
wAIOpponentPrizeCount:: ; cdd3
	ds $1

; AI stores the card ID to look for here
wTempCardIDToLook:: ; cdd4
	ds $1

; when AI decides which Bench Pokemon to switch to
; it stores it Play Area location here.
wAIPlayAreaCardToSwitch:: ; cdd5
	ds $1

; the index of attack chosen by AI
; to use with Pluspower.
wAIPluspowerAttack:: ; cdd6
	ds $1

; whether AI is allowed to play an energy card
; from the hand in order to retreat arena card
;	FALSE = not allowed
;	TRUE  = allowed
wAIPlayEnergyCardForRetreat:: ; cdd7
	ds $1

; flags defined by AI_ENERGY_FLAG_* constants
; used as input for AIProcessEnergyCards
; to determine what to check in the routine.
wAIEnergyAttachLogicFlags:: ; cdd8
	ds $1

; used as input to AIProcessAttacks.
; if 0, execute the attack chosen by the AI.
; if not 0, return without executing attack.
wAIExecuteProcessedAttack:: ; cdd9
	ds $1

; flags used by AI for retreat logic
; if bit 0 set, then it means the current Pokémon
; can KO the defending card with one of its attacks
; if bit 7 is set, then it means the switch is due
; to the effect of an attack (not Pkmn Power)
wAIRetreatFlags:: ; cdda
	ds $1

wAITriedAttack:: ; cddb
	ds $1

wcddc:: ; cddc
	ds $1

; used to temporarily backup wPlayAreaAIScore values.
wTempPlayAreaAIScore:: ; cddd
	ds MAX_PLAY_AREA_POKEMON

wTempAIScore:: ; cde3
	ds $1

; used for AI decisions that involve
; each card in the Play Area involving
; attaching Energy cards.
wPlayAreaEnergyAIScore:: ; cde4
	ds MAX_PLAY_AREA_POKEMON

wSamePokemonEnergyScore:: ; cdea
	ds MAX_PLAY_AREA_POKEMON

; whether AI cannot inflict damage on player's active Pokémon
; (due to No Damage or Effect substatus).
;	$00 = can damage
;	$01 = can't damage
wAICannotDamage:: ; cdf0
	ds $1

; used by AI to store variable information
wTempAI:: ; cdf1
	ds $1

; used for AI to store whether this card can use any attack
; $00 = can't attack
; $01 = can attack
wCurCardCanAttack:: ; cdf2
	ds $1

; used to temporarily store the card deck index
; while AI is deciding whether to evolve Pokémon
; or deciding whether to play Pokémon card from hand
wTempAIPokemonCard:: ; cdf3
	ds $1

; used for AI to store whether this card can KO defending Pokémon
; $00 = can't KO
; $01 = can KO
wCurCardCanKO:: ; cdf4
	ds $1

	ds $4

wSamePokemonCardID:: ; cdf9
	ds $1

wSamePokemonEnergyScoreHandled:: ; cdfa
	ds MAX_PLAY_AREA_POKEMON

wAIFirstAttackDamage:: ; ce00
	ds $1
wAISecondAttackDamage:: ; ce01
	ds $1

; whether AI's attack is damaging or not
; (attacks that only damages bench are treated as non-damaging)
; $00 = is a damaging attack
; $01 = is a non damaging attack
wAIAttackIsNonDamaging:: ; ce02
	ds $1

; whether AI already retreated this turn or not.
;	- $0 has not retreated;
;	- $1 has retreated.
wAIRetreatedThisTurn:: ; ce03
	ds $1

; used by AI to store information of VenusaurLv67
; while handling Energy Trans logic.
wAIVenusaurLv67DeckIndex:: ; ce04
	ds $1
wAIVenusaurLv67PlayAreaLocation:: ; ce05
	ds $1

wce06:: ; ce06
; number of cards to be transferred by AI using Energy Trans.
wAINumberOfEnergyTransCards:: ; ce06
; used for storing weakness of Player's Arena card
; in AI routine dealing with Shift Pkmn Power.
wAIDefendingPokemonWeakness:: ; ce06
; number of Basic Pokemon cards when
; setting up AI Boss deck
wAISetupBasicPokemonCount:: ; ce06
	ds $1

wce07:: ; ce07
	ds $1

wce08:: ; ce08
; number of Energy cards when
; setting up AI Boss deck
wAISetupEnergyCount:: ; ce08
	ds $7

wce0f:: ; ce0f
	ds $7

; stores the deck index (0-59) of the Trainer card
; the AI intends to play from hand.
wAITrainerCardToPlay:: ; ce16
	ds $1

; temporarily stores the card ID from AITrainerCardLogic
; to compare with the card in AI's hand
wAITrainerLogicCard:: ; ce17
	ds $1

wAITrainerCardPhase:: ; ce18
	ds $1

; parameters output by AI Trainer card logic routines
; (e.g. what Pokemon in Play Area to use card on, etc)
wAITrainerCardParameter:: ; ce19
	ds $1

wce1a:: ; ce1a
	ds $1

wce1b:: ; ce1b
	ds $1

wce1c:: ; ce1c
	ds $1

wce1d:: ; ce1d
	ds $1

wce1e:: ; ce1e
	ds $1

wce1f:: ; ce1f
	ds $1

; used to store previous/current flags of AI actions
; see AI_FLAG_* constants
wPreviousAIFlags:: ; ce20
	ds $1
wCurrentAIFlags:: ; ce21
	ds $1

; During a duel, this is always $b after the first attack.
; $b is the bank where the functions associated to card or effect commands are.
; Its only purpose seems to be store this value to be read by TryExecuteEffectCommandFunction.
; possibly used in other contexts too
wEffectFunctionsBank:: ; ce22
	ds $1

; LoadCardGfx loads the card's palette here
wCardPalette:: ; ce23
	ds CGB_PAL_SIZE

; information about the text being currently processed, including font width,
; the rom bank, and the memory address of the next character to be printed.
; supports up to four nested texts (used with TX_RAM).
wTextHeader1:: ; ce2b
	text_header wTextHeader1
wTextHeader2:: ; ce30
	text_header wTextHeader2
wTextHeader3:: ; ce35
	text_header wTextHeader3
wTextHeader4:: ; ce3a
	text_header wTextHeader4

; text id for the first TX_RAM2 of a text
; prints from wDefaultText if $0000
wTxRam2:: ; ce3f
	ds $2

; text id for the second TX_RAM2 of a text
wTxRam2_b:: ; ce41
	ds $2

; text id for the first TX_RAM3 of a text
; a number between 0 and 65535
wTxRam3:: ; ce43
	ds $2

; text id for the second TX_RAM3 of a text
; a number between 0 and 65535
wTxRam3_b:: ; ce45
	ds $2

; when printing text, number of frames to wait between each text tile
wTextSpeed:: ; ce47
	ds $1

; a number between 0 and 3 to select a wTextHeader to use for the current text
wWhichTextHeader:: ; ce48
	ds $1

; selects wTxRam2 or wTxRam2_b
wWhichTxRam2:: ; ce49
	ds $1

; selects wTxRam3 or wTxRam3_b
wWhichTxRam3:: ; ce4a
	ds $1

wIsTextBoxLabeled:: ; ce4b
	ds $1

; text id of a text box's label
wTextBoxLabel:: ; ce4c
	ds $2

wCoinTossScreenTextID:: ; ce4e
	ds $2

; set to PLAYER_TURN in the "Your Play Area" screen
; set to OPPONENT_TURN in the "Opp Play Area" screen
; alternates when drawing the "In Play Area" screen
wCheckMenuPlayAreaWhichDuelist:: ; ce50
	ds $1

; apparently complements wCheckMenuPlayAreaWhichDuelist to be able to combine
; the usual player or opponent layout with the opposite duelist information
; appears not to be relevant in the "In Play Area" screen
wCheckMenuPlayAreaWhichLayout:: ; ce51
	ds $1

; the position of cursor in the "In Play Area" screen
wInPlayAreaCurPosition:: ; ce52

; holds the position of the cursor when selecting
; in the "Your Play Area" or "Opp Play Area" screens
wYourOrOppPlayAreaCurPosition:: ; ce52
	ds $1

; pointer to the table which contains information for each key-press.
wMenuInputTablePointer:: ; ce53

; pointer to transition table data
wTransitionTablePtr:: ; ce53
	ds $2

; same as wDuelInitialPrizes but with upper 2 bits set
wDuelInitialPrizesUpperBitsSet:: ; ce55
	ds $1

; if TRUE, SwapTurn is called
; after some operations are concluded
wIsSwapTurnPending:: ; ce56
	ds $1

; it's used for restore the position of cursor
; when going into another view, and returning to
; the previous view.
wInPlayAreaPreservedPosition:: ; ce57
	ds $1

; it's used for checking if the player changed
; the cursor in the play area view.
wInPlayAreaTemporaryPosition:: ; ce58
	ds $1

; number of prize cards still to be
; picked by the player
wNumberOfPrizeCardsToSelect:: ; ce59
	ds $1

; pointer to a $ff-terminated list
; of the prize cards selected by the player
wSelectedPrizeCardListPtr:: ; ce5a
	ds $2

wce5c:: ; ce5c
	ds $1

; stores whether there are Pokemon in play area
; player arena Pokemon sets bit 0
; opponent arena Pokemon sets bit 1
wArenaCardsInPlayArea:: ; ce5d
	ds $1

wce5e:: ; ce5e
	ds $1

; this is used to store last cursor position
; in the "Your Play Area" and the "Opp. Play Area" screens
wYourOrOppPlayAreaLastCursorPosition:: ; ce5f
	ds $1

; $00 when the "In Play Area" screen has been opened from the Check menu
; $01 when the "In Play Area" screen has been opened by pressing the select button
wInPlayAreaFromSelectButton:: ; ce60
	ds $1

; it's used only in one function,
; which means that it's a kind of local variable, but defined in wram.
wPrizeCardCursorTemporaryPosition:: ; ce61
	ds $1

wGlossaryPageNo:: ; ce62
	ds $1

; which routine in ExecutePrinterPacketSequence to run
wPrinterPacketSequence:: ; ce63
	ds $1

wPrinterPacket:: ; ce64

wPrinterPacketPreamble::
	ds $2

wPrinterPacketInstructions:: ; ce66
	ds $2

wPrinterPacketDataSize:: ; ce68
	ds $2

; pointer to memory of data to send
; in the data packet to the printer
wPrinterPacketDataPtr:: ; ce6a
	ds $2

wPrinterPacketChecksum:: ; ce6c
	ds $2

wSerialTransferData:: ; ce6e
	ds $1

wPrinterStatus:: ; ce6f
	ds $1

; pointer to packet data that is
; being transmitted through serial
wSerialDataPtr:: ; ce70
	ds $2

; keeps track of which Bench Pokemon is pointed
; by the cursor during Gigashock selection screen
wCurGigashockItem:: ; ce72
	ds $1

; card index and its attack index chosen
; to be used by Metronome.
wMetronomeSelectedAttack:: ; ce73
	ds $2

; stores the amount of cards that are being ordered.
wNumberOfCardsToOrder:: ; ce75
	ds $1

wBackupPlayerAreaHP:: ; ce76
	ds MAX_PLAY_AREA_POKEMON

; used in CountPokemonIDInPlayArea
wTempPokemonID_ce7c:: ; ce7c
	ds $1

	ds $1

wce7e:: ; ce7e
	ds $1

wDamageAnimAmount:: ; ce7f
	ds $2

wDamageAnimEffectiveness:: ; ce81
	ds $1

wDamageAnimPlayAreaLocation:: ; ce82
	ds $1

; this value is never read
wDamageAnimPlayAreaSide:: ; ce83
	ds $1

wDamageAnimCardID:: ; ce84
	ds $1

; buffer to store data that will be sent/received through IR
wIRDataBuffer:: ; ce85
	ds $8

wVBlankFunctionTrampolineBackup:: ; ce8d
	ds $2

wTempPrinterSRAM:: ; ce8f
	ds $1

wPrinterHorizontalOffset:: ; ce90
	ds $1

; the count of some card ID in the deck to be printed
wPrinterCardCount:: ; ce91
	ds $1

; total card count of list to be printed
wPrinterTotalCardCount:: ; ce92
	ds $2

wCurPrinterCardType:: ; ce94
	ds $1

; total card count of the current card type
; in list to be printed
wPrinterCurCardTypeCount:: ; ce95
	ds $2

wPrinterNumCardTypes:: ; ce97
	ds $1

; related to printer functions
; only written to but never read
wce98:: ; ce98
	ds $1

wPrinterContrastLevel:: ; ce99
	ds $1

wPrizeCardSelectionFrameCounter:: ; ce9a
	ds $1

; related to printer serial stuff
wPrinterNumberLineFeeds:: ; ce9b
	ds $1

wPrintOnlyStarRarity:: ; ce9c
	ds $1

; only used in unreferenced function Func_1a14b
; otherwise unused
wce9d:: ; ce9d
	ds $1

wPrinterInitAttempts:: ; ce9e
	ds $1

wce9f:: ; ce9f
	ds $1

; which song to play when obtaining the card from Card Pop!
; the card's rarity determines which song to play
wCardPopCardObtainSong:: ; cea0
	ds $1

; first index in the current card list that is visible
; used to calculate which element to get based
; on the cursor position
wCardListVisibleOffset:: ; cea1
	ds $1

	ds $1

; it's used when the player enters check menu, and its sub-menus.
; increases from 0x00 to 0xff. the game makes its blinking cursor by this.
; note that the check menu also contains the pokemon glossary.
wCheckMenuCursorBlinkCounter:: ; cea3
	ds $1

; used to temporarily store wCurCardTypeFilter
; to check whether a new filter is to be applied
wTempCardTypeFilter:: ; cea4

wCardListCursorPos:: ; cea4

wNamingScreenCursorY:: ; cea4
	ds $1

wCardListCursorXPos:: ; cea5
	ds $1

wCardListCursorYPos:: ; cea6
	ds $1

wCardListYSpacing:: ; cea7
	ds $1

wCardListXSpacing:: ; cea8
	ds $1

wCardListNumCursorPositions:: ; cea9

wNamingScreenKeyboardHeight:: ; cea9
	ds $1

; tile to draw when cursor is blinking
wVisibleCursorTile:: ; ceaa
	ds $1

; tile to draw when cursor is visible
wInvisibleCursorTile:: ; ceab
	ds $1

; unknown handler function run in HandleDeckCardSelectionList
; is always NULL
wCardListHandlerFunction:: ; ceac
	ds $2

; number of cards that are listed
; in the current filtered list
wNumEntriesInCurFilter:: ; ceae
	ds $1

wCheckMenuCursorXPosition:: ; ceaf
	ds $1

wCheckMenuCursorYPosition:: ; ceb0
	ds $1

; deck selected by the player in the Decks screen
wCurDeck:: ; ceb1
	ds $1

; each of these are a boolean to
; represent whether a given deck
; that the player has is a valid deck
wDecksValid::
wDeck1Valid:: ds $1 ; ceb2
wDeck2Valid:: ds $1 ; ceb3
wDeck3Valid:: ds $1 ; ceb4
wDeck4Valid:: ds $1 ; ceb5

; holds symbols for representing a number in decimal
; goes up in magnitude (first byte is ones place,
; second byte is tens place, etc) up to 5 digits
wDecimalDigitsSymbols:: ; ceb6
	ds $5

; each of these stores the card count
; of each filter in the deck building screen
; the order follows CardTypeFilters
wCardFilterCounts:: ; cebb
	ds NUM_FILTERS

UNION

; buffer used to show which card IDs
; are visible in a given list
wVisibleListCardIDs:: ; cec4
	ds NUM_DECK_CONFIRMATION_VISIBLE_CARDS

NEXTU

; whether a given Card Set is unavailable in the Card Album screen
; used only for CARD_SET_PROMOTIONAL, in which case
; if it's unavailable, will print "----------" as the Card Set name
wUnavailableAlbumCardSets:: ; cec4
	ds NUM_CARD_SETS

ENDU

; number of visible entries
; when showing a list of cards
wNumVisibleCardListEntries:: ; cecb
	ds $1

wTotalCardCount:: ; cecc
	ds $1

; is TRUE if list cannot be scrolled down
; past the last visible entry
wUnableToScrollDown:: ; cecd
	ds $1

; pointer to a function that should be called
; to update the card list being shown
wCardListUpdateFunction:: ; cece
	ds $2

; holds y and x coordinates (in that order)
; of start of card list (top-left corner)
wCardListCoords:: ; ced0
	ds $2

wced2:: ; ced2
	ds $1

; the current filter being used
; from the CardTypeFilters list
wCurCardTypeFilter:: ; ced3
	ds $1

; temporarily stores wCardListNumCursorPositions value
wTempCardListCursorPos:: ; ced4
	ds $1

wTempFilteredCardListNumCursorPositions:: ; ced5
	ds $1

wced6:: ; ced6
	ds $1

; maybe unused, is written to but never read
wced7:: ; ced7
	ds $1

wCardListVisibleOffsetBackup:: ; ced8
	ds $1

; stores how many different cards there are in a deck
wNumUniqueCards:: ; ced9
	ds $1

; stores the list of all card IDs that filtered by its card type
; (Fire, Water, ..., Energy card, Trainer card)
wFilteredCardList:: ; ceda

; stores AI temporary hand card list
wHandTempList:: ; ceda
	ds DECK_SIZE + 1

; holds cards for the current deck
wCurDeckCards:: ; cf17
	ds DECK_CONFIG_BUFFER_SIZE + 1

wCurDeckCardsEnd::


; list of all the different cards in a deck configuration
wUniqueDeckCardList:: ; cf68

; stores the count number of cards owned
; can be 0 in the case that a card is not available
; i.e. already inside a built deck
wOwnedCardsCountList:: ; cf68

; used by _AIProcessHandTrainerCards, AI related
wTempHandCardList:: ; cf68
	ds DECK_SIZE

	ds $15

; name of the selected deck
wCurDeckName:: ; cfb9
	ds DECK_NAME_SIZE

; max number of cards that are allowed
; to include when building a deck configuration
wMaxNumCardsAllowed:: ; cfd1
	ds $1

; max number of cards with same name that are allowed
; to be included when building a deck configuration
wSameNameCardsLimit:: ; cfd2
	ds $1

; whether to include the cards in the selected deck
; to appear in the filtered lists
; is TRUE when building a deck (since the cards should be shown for removal)
; is FALSE when choosing a deck configuration to send through Gift Center
; (can't select cards that are included in already built decks)
wIncludeCardsInDeck:: ; cfd3
	ds $1

; pointer to a function that handles the menu
; when building a deck configuration
wDeckConfigurationMenuHandlerFunction:: ; cfd4
	ds $2

; pointer to a transition table for the
; function in wDeckConfigurationMenuHandlerFunction
wDeckConfigurationMenuTransitionTable:: ; cfd6
	ds $2

; pointer to a list of cards that
; is currently being shown/manipulated
wCurCardListPtr:: ; cfd8
	ds $2

; text ID to print in the card confirmation screen text box
wCardConfirmationText:: ; cfda
	ds $2

	ds $2

; the tile to draw in place of the cursor, in case
; the cursor is not to be drawn
wCursorAlternateTile:: ; cfde
	ds $1

; temporarily stores value of wCardListNumCursorPositions
wTempCardListNumCursorPositions:: ; cfdf
	ds $1

; which Card Set selected by the player to view
wSelectedCardSet:: ; cfe0
	ds $1

; number of cards the player owns from the given Card Set
wNumOwnedCardsInSet:: ; cfe1
	ds $1

; flags that corresponds to each Phantom Card owned by the player
; see src/constants/menu_constants.asm
wOwnedPhantomCardFlags:: ; cfe2
	ds $1

; value containing a SFX to play
; due to a menu input
wMenuInputSFX:: ; cfe3
	ds $1

wSelectedPrinterMenuItem:: ; cfe4
	ds $1

; collection index of the first owned card
wFirstOwnedCardIndex:: ; cfe5
	ds $1

wNumCardListEntries:: ; cfe6
	ds $1

; a name buffer in the naming screen.
wNamingScreenBuffer:: ; cfe7
	ds NAMING_SCREEN_BUFFER_LENGTH

; current name length in the naming screen.
wNamingScreenBufferLength:: ; cfff
	ds $1

SECTION "WRAM1", WRAMX
wNamingScreenDestPointer:: ; d000
	ds $2

wNamingScreenQuestionPointer:: ; d002
	ds $2

; max length of name buffer.
; it's given for limiting the player's input.
wNamingScreenBufferMaxLength:: ; d004
	ds $1

wNamingScreenNumColumns:: ; d005
	ds $1

wNamingScreenCursorX:: ; d006
	ds $1

; the position to display the input on.
wNamingScreenNamePosition:: ; d007
	ds $2

wd009:: ; d009
	ds $4

; pointers to all decks of current deck machine
wMachineDeckPtrs:: ; d00d
	ds 2 * NUM_DECK_SAVE_MACHINE_SLOTS

wNumSavedDecks:: ; d085
	ds $1

; temporarily holds value of wCardListCursorPos
wTempDeckMachineCursorPos:: ; d086
	ds $1

; temporarily holds value of wCardListVisibleOffset
wTempCardListVisibleOffset:: ; d087
	ds $1

; which list entry was selected in the Deck Machine screen
wSelectedDeckMachineEntry:: ; d088
	ds $1

wDismantledDeckName:: ; d089
	ds DECK_NAME_SIZE

; which deck slot to be used to
; build a new deck
wDeckSlotForNewDeck:: ; d0a1
	ds $1

wDeckMachineTitleText:: ; d0a2
	ds $2

wTempBankSRAM:: ; d0a4
	ds $1

wNumDeckMachineEntries:: ; d0a5
	ds $1

; DECK_* flags to be dismantled to build a given deck
wDecksToBeDismantled:: ; d0a6
	ds $1

; text ID to print in the text box when
; inside the Deck Machine menu
wDeckMachineText:: ; d0a7
	ds $2

; which deck machine is being used
wCurAutoDeckMachine:: ; d0a9
	ds $1

; text IDs for each deck descriptions of the
; Auto Deck Machine currently being shown
wAutoDeckMachineTextDescriptions:: ; d0aa
	ds 2 * NUM_DECK_MACHINE_SLOTS

; if bit 4 is set, transition to another map via a warp
; if bit 6 is set, transition to a special screen
;   (duel, challenge machine, battle center, gift center, credits)
; bit 7 may also be used for some unknown purpose
wOverworldTransition:: ; d0b4
	ds $1

; a GAME_EVENT_* constant corresponding to an entry in GameEventPointerTable
; overworld, duel, credits...
wGameEvent:: ; d0b5
	ds $1

wSCX:: ; d0b6
	ds $1

wSCY:: ; d0b7
	ds $1

wSelectedPauseMenuItem:: ; d0b8
	ds $1

wSelectedPCMenuItem:: ; d0b9
	ds $1

wSelectedGiftCenterMenuItem:: ; d0ba
	ds $1

wTempMap:: ; d0bb
	ds $1

wTempPlayerXCoord:: ; d0bc
	ds $1

wTempPlayerYCoord:: ; d0bd
	ds $1

wTempPlayerDirection:: ; d0be
	ds $1

; See constants/misc_constants.asm for OWMODE's
wOverworldMode:: ; d0bf
	ds $1

wOverworldModeBackup:: ; d0c0
	ds $1

; overworld npc flag options
; bit 0; auto-close textbox when finished talking to npc
; bit 1; restore npc facing direction when finished talking to npc
; bit 7; hide all npc sprites (for screens like pause menu, opening boosters, entering deck machine, etc.)
wOverworldNPCFlags:: ; d0c1
	ds $1

; only used with GAME_EVENT_DUEL, GAME_EVENT_BATTLE_CENTER, and GAME_EVENT_GIFT_CENTER
wActiveGameEvent:: ; d0c2
	ds $1

; stores the player's result in a duel (0: win, 1: loss, 2: ???, -1: transmission error?)
; to be read by the overworld caller
wDuelResult:: ; d0c3
	ds $1

wNPCDuelist:: ; d0c4
	ds $1

wNPCDuelistDirection:: ; d0c5
	ds $1

; used to store the location of an overworld script, which is jumped to later
wNextScript:: ; d0c6
	ds $2

wCurrentNPCNameTx:: ; d0c8
	ds $2

wDefaultObjectText:: ; d0ca
	ds $2

wObjectPalettesCGBBackup:: ; d0cc
	ds 8 palettes

wOBP0Backup:: ; d10c
	ds $1

wOBP1Backup:: ; d10d
	ds $1

wGiftCenterChoice:: ; d10e
	ds $1

wReloadOverworldCallbackPtr:: ; d10f
	ds $2

wDefaultSong:: ; d111
	ds $1

wSongOverride:: ; d112
	ds $1

wMatchStartTheme:: ; d113
	ds $1

wMedalScreenYOffset:: ; d114
	ds $1

wWhichMedal:: ; d115
	ds $1

wMedalDisplayTimer:: ; d116
	ds $1

; if FALSE, first booster being given
; if TRUE, additional booster being given
; used to control the text that is displayed when booster is opened
wAnotherBoosterPack:: ; d117
	ds $1

wConfigMessageSpeedCursorPos:: ; d118
	ds $1

wConfigDuelAnimationCursorPos:: ; d119
	ds $1

wConfigExitSettingsCursorPos:: ; d11a
	ds $1

wConfigCursorYPos:: ; d11b
	ds $1

; cursor is invisible if bit 4 is set (every $10 ticks)
wCursorBlinkTimer:: ; d11c
	ds $1

wPCPackSelection:: ; d11d
	ds $1

; 7th bit of each pack corresponds to whether or not it's been read
wPCPacks:: ; d11e
	ds NUM_PC_PACKS

wPCLastDirectionPressed:: ; d12d
	ds $1

wSelectedPCPack:: ; d12e
	ds $1

wBGMapWidth:: ; d12f
	ds $1

wBGMapHeight:: ; d130
	ds $1

; current tilemap to load
; TILEMAP_* constant
wCurTilemap:: ; d131
	ds $1

wCurMapSGBPals:: ; d132
	ds $1

UNION

; when opening a booster pack, list of cards available in the booster pack of a specific rarity
wBoosterViableCardList:: ; d133
	ds $100

NEXTU

; permission map of the current room with impassable objects (walls, NPCs, etc).
; $00: passable (floor)
; $10: text/menu box tile
; $40: impassable and talkable (NPC or talkable wall)
; $80: impassable and untalkable (wall)
wPermissionMap:: ; d133
	ds $100

ENDU

wd233:: ; d233
	ds $1

wd234:: ; d234
	ds $1

wSCXBuffer:: ; d235
	ds $1

wSCYBuffer:: ; d236
	ds $1

wd237:: ; d237
	ds $1

wd238:: ; d238
	ds $1

; current tileset to load to VRAM
; TILESET_* constant
wCurTileset:: ; d239
	ds $1

; pointer to compressed data
; of the current map's permission map
wBGMapPermissionDataPtr:: ; d23a
	ds $2

; whether the  BG Map is in CGB mode
; this means half of the width is for
; VRAM0 and the other half is for VRAM1
wBGMapCGBMode:: ; d23c
	ds $1

wBGMapBank:: ; d23d
	ds $1

UNION

; palette loaded from Palette* data
wLoadedPalData:: ; d23e
	ds $50

NEXTU

; where BG map data or other compressed data is decompressed
wDecompressionBuffer:: ; d23e
	ds $40

ENDU

wDecompressionRowWidth:: ; d28e
	ds $1

wCurMapInitialPalette:: ; d28f
	ds $1

wCurMapPalette:: ; d290
	ds $1

wd291:: ; d291
	ds $1

; determines where to copy BG Map data
; $0 = copies to VRAM
; $1 = copies to SRAM
wWriteBGMapToSRAM:: ; d292
	ds $1

; console-dependent palette data
; for BGP and OBP
wConsolePaletteData:: ; d293
	ds $1

wTempBGP:: ; d294
	ds $1

wTempOBP0:: ; d295
	ds $1

wTempOBP1:: ; d296
	ds $1

; temporarily holds the palettes from
; wBackgroundPalettesCGB
wTempBackgroundPalettesCGB:: ; d297
	ds NUM_BACKGROUND_PALETTES palettes

; temporarily holds the palettes from
; wObjectPalettesCGB
wTempObjectPalettesCGB:: ; d2d7
	ds NUM_OBJECT_PALETTES palettes

wd317:: ; d317
	ds $1

; pointer to the data of current map OW frameset
wCurMapOWFrameset:: ; d318
	ds $2

; stored data for each OW frameset subgroup
; has frame data offset and duration
wOWFramesetSubgroups:: ; d31a
	ds NUM_OW_FRAMESET_SUBGROUPS * $2

; address offset of current OW frame
; relative to wCurMapOWFrameset
wCurOWFrameDataOffset:: ; d320
	ds $1

; duration of the current map OW frame
wCurOWFrameDuration:: ; d321
	ds $1

; number of valid subgroups
; that are currently loaded in wOWFramesetSubgroups
wNumLoadedFramesetSubgroups:: ; d322
	ds $1

; holds the current state of each event
; each corresponding to a MAP_EVENT_* constant
; if $0, doors are closed / deck machines are deactivated
; if $1, doors are open / deck machines are activated
wOWMapEvents:: ; d323
	ds NUM_MAP_EVENTS

; the OWMAP_* value for the current overworld map selection
wOverworldMapSelection:: ; d32e
	ds $1

wCurMap:: ; d32f
	ds $1

wPlayerXCoord:: ; d330
	ds $1

wPlayerYCoord:: ; d331
	ds $1

wPlayerXCoordPixels:: ; d332
	ds $1

wPlayerYCoordPixels:: ; d333
	ds $1

wPlayerDirection:: ; d334
	ds $1

; seems to be 1 if moving 0 otherwise
wPlayerCurrentlyMoving:: ; d335
	ds $1

wPlayerSpriteIndex:: ; d336
	ds $1

wPlayerSpriteBaseAnimation:: ; d337
	ds $1

wd338:: ; d338
	ds $1

wd339:: ; d339
	ds $1

wd33a:: ; d33a
	ds $1

wOverworldMapCursorSprite:: ; d33b
	ds $1

wOverworldMapCursorAnimation:: ; d33c
	ds $1

wOverworldMapStartingPosition:: ; d33d
	ds $1

; 0: selection not made, controlling cursor
; 1: selection made, animating player across map
; 2: player arrived at new map
wOverworldMapPlayerAnimationState:: ; d33e
	ds $1

wOverworldMapPlayerMovementPtr:: ; d33f
	ds $2

wOverworldMapPlayerMovementCounter:: ; d341
	ds $1

	ds $1

; during setup, this holds a signed 16-bit integer
; representing the total horizontal distance between
; the current point and the next point
; afterward, this holds a signed fixed-point fractional number
; where the high byte represents the number of pixels
; to travel per frame and the low byte represents the
; fraction of a pixel to travel per frame
wOverworldMapPlayerPathHorizontalMovement:: ; d343
	ds $2

; works the same as above, but for vertical distance
wOverworldMapPlayerPathVerticalMovement:: ; d345
	ds $2

wOverworldMapPlayerHorizontalSubPixelPosition:: ; d347
	ds $1

wOverworldMapPlayerVerticalSubPixelPosition:: ; d348
	ds $1

; total number of NPCs that are currently loaded
wNumLoadedNPCs:: ; d349
	ds $1

wLoadedNPCs:: ; d34a
	loaded_npc_struct wLoadedNPC1
	loaded_npc_struct wLoadedNPC2
	loaded_npc_struct wLoadedNPC3
	loaded_npc_struct wLoadedNPC4
	loaded_npc_struct wLoadedNPC5
	loaded_npc_struct wLoadedNPC6
	loaded_npc_struct wLoadedNPC7
	loaded_npc_struct wLoadedNPC8

wLoadedNPCTempIndex:: ; d3aa
	ds $1

wTempNPC:: ; d3ab
	ds $1

wLoadNPCXPos:: ; d3ac
	ds $1

wLoadNPCYPos:: ; d3ad
	ds $1

wLoadNPCDirection:: ; d3ae
	ds $1

wLoadNPCFunction:: ; d3af
	ds $2

wNPCAnim:: ; d3b1
	ds $1

wNPCAnimFlags:: ; d3b2
	ds $1

; sprite ID of the NPC to load
wNPCSpriteID:: ; d3b3
	ds $1

	ds $2

; ID of the NPC being interacted with in Script
wScriptNPC:: ; d3b6
	ds $1

; bit 6 will be set if an NPC is currently moving
wIsAnNPCMoving:: ; d3b7
	ds $1

; whether Ronald is in the current map
; is used to load his theme whenever he is present
wRonaldIsInMap:: ; d3b8
	ds $1

wd3b9:: ; d3b9
	ds $2

wMastersBeatenList:: ; d3bb
	ds $a

wGeneralSaveDataCheckSum:: ; d3c5
	ds $2

wNumSRAMValidationErrors:: ; d3c7
	ds $1

; play time hours and minutes
; byte 0: minutes
; byte 1: hours (lower byte)
; byte 2: hours (higher byte)
wPlayTimeHourMinutes:: ; d3c8
	ds $3

wCurOverworldMap:: ; d3cb
	ds $1

wMedalCount:: ; d3cc
	ds $1

; total number of cards the player has collected
wTotalNumCardsCollected:: ; d3cd
	ds $1

; total number of cards to be collected
; doesn't count the Phantom cards (VenusaurLv64 and MewLv15)
; unless they have already been collected
wTotalNumCardsToCollect:: ; d3ce
	ds $1

wCardToAddToCollection:: ; d3cf
	ds $1

wd3d0:: ; d3d0
	ds $1

; the bits relevant to the currently worked on event, obtained from EventVarMasks
wLoadedEventBits:: ; d3d1
	ds $1

wEventVars:: ; d3d2
	ds $40

; 0 keeps looping, other values break the loop in RST20
wBreakScriptLoop:: ; d412
	ds $1

wScriptPointer:: ; d413
	ds $2

; generally set to ff when an event check passes, 0 otherwise
wScriptControlByte:: ; d415
	ds $1

wd416:: ; d416
	ds $1

wd417:: ; d417
	ds $1

wDebugMenuSelection:: ; d418
	ds $1

wDebugSGBBorder:: ; d419
	ds $1

wDebugBoosterSelection:: ; d41a
	ds $1

; used in unreferenced function Func_1c890
; otherwise unused
wd41b:: ; d41b
	ds $1

; used in unreferenced function Func_1c890
; otherwise unused
; is read like a sprite index
wd41c:: ; d41c
	ds $1

wd41d:: ; d41d
	ds $1

wd41e:: ; d41e
	ds $1

wd41f:: ; d41f
	ds $1

wd420:: ; d420
	ds $1

; store settings for animation enabled/disabled
; 0 means enabled, 1 means disabled
wAnimationsDisabled:: ; d421
	ds $1

; holds an animation to play
wTempAnimation:: ; d422
	ds $1

; holds a list of animations to play
; as long as any of the slot isn't $ff, there's something to play
; it may actually not be a queue
wAnimationQueue:: ; d423
	ds ANIMATION_QUEUE_LENGTH

wActiveScreenAnim:: ; d42a
	ds $1

wAnimFlags:: ; d42b
	ds $1

wDuelAnimBuffer:: ; d42c
	duel_anim_struct wDuelAnim1
	duel_anim_struct wDuelAnim2
	duel_anim_struct wDuelAnim3
	duel_anim_struct wDuelAnim4
	duel_anim_struct wDuelAnim5
	duel_anim_struct wDuelAnim6
	duel_anim_struct wDuelAnim7
	duel_anim_struct wDuelAnim8
	duel_anim_struct wDuelAnim9
	duel_anim_struct wDuelAnim10
	duel_anim_struct wDuelAnim11
	duel_anim_struct wDuelAnim12
	duel_anim_struct wDuelAnim13
	duel_anim_struct wDuelAnim14
	duel_anim_struct wDuelAnim15
	duel_anim_struct wDuelAnim16

wDuelAnimBufferCurPos:: ; d4ac
	ds $1

wDuelAnimBufferSize:: ; d4ad
	ds $1

; used to know what coordinate offsets to use to place animations
; for use in GetAnimCoordsAndFlags
; DUEL_ANIM_SCREEN_MAIN_SCENE       = main scene
; DUEL_ANIM_SCREEN_PLAYER_PLAY_AREA = Player's Play Area screen
; DUEL_ANIM_SCREEN_OPP_PLAY_AREA    = Opponent's Play Area screen
wDuelAnimationScreen:: ; d4ae
	ds $1

; which side to play animation
; uses PLAYER_TURN and OPPONENT_TURN constants
wDuelAnimDuelistSide:: ; d4af
	ds $1

; used in GetAnimCoordsAndFlags to determine
; what coordinates to draw the animation in.
; e.g. used to know what Play Area card
; to draw a hit animation in the Play Area screen.
wDuelAnimLocationParam:: ; d4b0
	ds $1

; damage value to display with animation
wDuelAnimDamage:: ; d4b1
	ds $2

wDuelAnimSetScreen:: ; d4b3
wDuelAnimEffectiveness:: ; d4b3
	ds $1

; stores the character symbols of some
; value that was converted to decimal
; through ConvertWordToNumericalDigits
wDecimalChars:: ; d4b4
	ds $3

wDamageCharIndex:: ; d4b7
	ds $1

wDamageCharAnimDelay:: ; d4b8
	ds $1

; pointer to a function to update
; the current screen animation
wScreenAnimUpdatePtr:: ; d4b9
	ds $2

; duration of the current screen animation
wScreenAnimDuration:: ; d4bb
	ds $1

wScreenShakeOffsetsPtr:: ; d4bc
wTempWhiteFlashBGP:: ; d4bc
	ds $2

; bank number to return to after processing animation
wDuelAnimReturnBank:: ; d4be
	ds $1

wd4bf:: ; d4bf
	ds $1

wd4c0:: ; d4c0
	ds $1

	ds $1

; pointer to address in VRAM
wVRAMPointer:: ; d4c2
	ds $2

; these next 3 seem to be an address (bank @ end) for copying bg data
wTempPointer:: ; d4c4
	ds $2

wTempPointerBank:: ; d4c6
	ds $1

; stores number of bytes per tile for current sprite
wCurSpriteTileSize:: ; d4c7
	ds $1

; stores number of tiles that current sprite/tileset has
wTotalNumTiles:: ; d4c8

; checksum?
wGeneralSaveDataByteCount:: ; d4c8
	ds $2

; stores tile offset in VRAM
wVRAMTileOffset:: ; d4ca

wd4ca:: ; d4ca
	ds $1

; bottom bit stores which VRAM bank to draw certain gfx
; $0 = VRAM0, $1 = VRAM1
wd4cb:: ; d4cb
	ds $1

	ds $3

; used as an index to manipulate a sprite from wSpriteAnimBuffer
wWhichSprite:: ; d4cf
	ds $1

; 16-byte data for up to 16 sprites
wSpriteAnimBuffer:: ; d4d0
	sprite_anim_struct wSprite1
	sprite_anim_struct wSprite2
	sprite_anim_struct wSprite3
	sprite_anim_struct wSprite4
	sprite_anim_struct wSprite5
	sprite_anim_struct wSprite6
	sprite_anim_struct wSprite7
	sprite_anim_struct wSprite8
	sprite_anim_struct wSprite9
	sprite_anim_struct wSprite10
	sprite_anim_struct wSprite11
	sprite_anim_struct wSprite12
	sprite_anim_struct wSprite13
	sprite_anim_struct wSprite14
	sprite_anim_struct wSprite15
	sprite_anim_struct wSprite16

wCurrSpriteAttributes:: ; d5d0
	ds $1

wCurrSpriteXPos:: ; d5d1
	ds $1

wCurrSpriteYPos:: ; d5d2
	ds $1

wCurrSpriteTileID:: ; d5d3
	ds $1

wCurrSpriteRightEdgeCheck:: ; d5d4
	ds $1

wCurrSpriteBottomEdgeCheck:: ; d5d5
	ds $1

wCurrSpriteFrameBank:: ; d5d6
	ds $1

; when non-0, skips all routines
; related to animating sprites
; (perhaps used during testing)
; it is always set to 0
wAllSpriteAnimationsDisabled:: ; d5d7
	ds $1

wSpriteVRAMBuffer:: ; d5d8
	sprite_vram_struct wSpriteVRAM1
	sprite_vram_struct wSpriteVRAM2
	sprite_vram_struct wSpriteVRAM3
	sprite_vram_struct wSpriteVRAM4
	sprite_vram_struct wSpriteVRAM5
	sprite_vram_struct wSpriteVRAM6
	sprite_vram_struct wSpriteVRAM7
	sprite_vram_struct wSpriteVRAM8
	sprite_vram_struct wSpriteVRAM9
	sprite_vram_struct wSpriteVRAM10
	sprite_vram_struct wSpriteVRAM11
	sprite_vram_struct wSpriteVRAM12
	sprite_vram_struct wSpriteVRAM13
	sprite_vram_struct wSpriteVRAM14
	sprite_vram_struct wSpriteVRAM15
	sprite_vram_struct wSpriteVRAM16

; seems to be the amount of entries in wSpriteVRAMBuffer
wSpriteVRAMBufferSize:: ; d618
	ds $1

wSceneSprite:: ; d619
	ds $1

wSceneSpriteAnimation:: ; d61a
	ds $1

wSceneSpriteIndex:: ; d61b
	ds $1

; base X position in pixels of loaded scene
wSceneBaseX:: ; d61c
	ds $1

; base Y position in pixels of loaded scene
wSceneBaseY:: ; d61d
	ds $1

wCurPortrait:: ; d61e
	ds $1

wd61f:: ; d61f
	ds $1

wSceneSGBPacketPtr:: ; d620
	ds $2

wSceneSGBRoutinePtr:: ; d622
	ds $2

; whether there exists valid save data
wHasSaveData:: ; d624
	ds $1

; whether has valid duel save data
wHasDuelSaveData:: ; d625
	ds $1

; keep track of which Start Menu item
; is currently highlighted
wCurHighlightedStartMenuItem:: ; d626

; used to keep track of the time
; in which the Title Screen ignores
; the player's input
wTitleScreenIgnoreInputCounter:: ; d626
	ds $1

wLastSelectedStartMenuItem:: ; d627
	ds $1

; START_MENU_* constant chosen
; by the player in the Start Menu
wStartMenuChoice:: ; d628
	ds $1

; list of sprites used in the Title Screen
wTitleScreenSprites:: ; d629
	ds $7

	ds $1

; pointer to commands used by opening and credits sequence
; (see IntroSequence and CreditsSequence)
wSequenceCmdPtr:: ; d631
	ds $2

; when non-zero, is decremented and only
; executes the next sequence command when it's 0
; when it's $ff, it is interpreted as end of sequence
wSequenceDelay:: ; d633
	ds $1

wIntroSequencePalsNeedUpdate:: ; d634
	ds $1

; counter that increments each frame in the Title screen
; if bottom 6 bits are 0, then spawn a new orb
wTitleScreenOrbCounter:: ; d635
	ds $1

; has parameters used for the Start Menu
; check SetStartMenuParams for what parameters are set
wStartMenuParams:: ; d636
	ds $11

wd647:: ; d647
	ds $1

wd648:: ; d648
	ds $1

wd649:: ; d649
	ds $1

wd64a:: ; d64a
	ds $1

; wd64b to wd665 used by Func_3e44
wd64b:: ; d64b
	ds $6

wd651:: ; d651
	ds $6

wd657:: ; d657
	ds $1

wd658:: ; d658
	ds $1

wd659:: ; d659
	ds $6

wd65f:: ; d65f
	ds $6

wd665:: ; d665
	ds $1

; used by GetNextBackgroundScroll
wBGScrollMod:: ; d666
	ds $1

; used by ApplyBackgroundScroll
wApplyBGScroll:: ; d667
	ds $1

; used by ApplyBackgroundScroll
wNextScrollLY:: ; d668
	ds $1

; which BoosterPack_* corresponds to the booster pack that the player is opening
wBoosterPackID:: ; d669
	ds $1

; card being currently processed by the booster pack engine functions
wBoosterCurrentCard:: ; d66a
	ds $1

; BOOSTER_CARD_TYPE_* of the card that has just been drawn from the pack
wBoosterJustDrawnCardType:: ; d66b
	ds $1

; rarity of the cards being currently generated (non-energy cards are generated ordered by rarity)
wBoosterCurrentRarity:: ; d66c
	ds $1

; the averaged value of all values in wBoosterData_TypeChances
; used to recalculate the chances of a booster card type when a card of said type is drawn from the pack
wBoosterAveragedTypeChances:: ; d66d
	ds $1

; data of the booster pack copied from the corresponding BoosterSetRarityAmountsTable entry
wBoosterData_CommonAmount:: ; d66e
	ds $1
wBoosterData_UncommonAmount:: ; d66f
	ds $1
wBoosterData_RareAmount:: ; d670
	ds $1

; how many cards of each type are available of a certain rarity in the booster pack's set
wBoosterAmountOfCardTypeTable:: ; d671
	ds NUM_BOOSTER_CARD_TYPES

; holds information similar to wBoosterData_TypeChances, except that it contains 00 on any type
; of which there are no cards remaining in the set for the current rarity
wBoosterTempTypeChancesTable:: ; d67a
	ds NUM_BOOSTER_CARD_TYPES

; properties of the card being currently processed by the booster pack engine functions
wBoosterCurrentCardType:: ; d683
	ds $1
wBoosterCurrentCardRarity:: ; d684
	ds $1
wBoosterCurrentCardSet:: ; d685
	ds $1

; data of the booster pack copied from the corresponding BoosterPack_* structure.
; wBoosterData_TypeChances is updated after each card is drawn, to re-balance the type chances.
wBoosterData_Set:: ; d686
	ds $1
wBoosterData_EnergyFunctionPointer:: ; d687
	ds $2
wBoosterData_TypeChances:: ; d689
	ds NUM_BOOSTER_CARD_TYPES

; index into ChallengeMachine_OpponentDeckIDs
; not the typical NPC duelist ID
wChallengeMachineOpponent:: ; d692
	ds $1

wStarterDeckChoice:: ; d693
	ds $1

wMultichoiceTextboxResult_Sam:: ; d694
	ds $1

wMultichoiceTextboxResult_ChooseDeckToDuelAgainst:: ; d695
	ds $1

wChallengeHallNPC:: ; d696
	ds $1

wCardReceived:: ; d697
	ds $1

wd698:: ; d698
	ds $4

	ds $6e4

SECTION "WRAM1 Audio", WRAMX

; bit 7 is set once the song has been started
wCurSongID:: ; dd80
	ds $1

wCurSongBank:: ; dd81
	ds $1

; bit 7 is set once the sfx has been started
wCurSfxID:: ; dd82
	ds $1

; priority value of current sfx (0 if nothing is playing)
wSfxPriority:: ; dd83
	ds $1

; 8-bit output enable mask for left/right output for each channel
wMusicStereoPanning:: ; dd84
	ds $1

wdd85:: ; dd85
	ds $1

wMusicDuty1:: ; dd86
	ds $1

wMusicDuty2:: ; dd87
	ds $1

	ds $2

wMusicWave:: ; dd8a
	ds $1

wMusicWaveChange:: ; dd8b
	ds $1

wdd8c:: ; dd8c
	ds $1

wMusicIsPlaying:: ; dd8d
	ds $4

wMusicTie:: ; dd91
	ds $4

; 4 pointers to the current music commands being executed
wMusicChannelPointers:: ; dd95
	ds $8

; 4 pointers to the addresses of the beginning of the main loop for each channel
wMusicMainLoopStart:: ; dd9d
	ds $8

wMusicCh1CurPitch:: ; dda5
	ds $1

wMusicCh1CurOctave:: ; dda6
	ds $1

wMusicCh2CurPitch:: ; dda7
	ds $1

wMusicCh2CurOctave:: ; dda8
	ds $1

wMusicCh3CurPitch:: ; dda9
	ds $1

wMusicCh3CurOctave:: ; ddaa
	ds $1

wddab:: ; ddab
	ds $1

wddac:: ; ddac
	ds $1

	ds $2

wMusicOctave:: ; ddaf
	ds $4

wddb3:: ; ddb3
	ds $4

wddb7:: ; ddb7
	ds $1

wddb8:: ; ddb8
	ds $1

wddb9:: ; ddb9
	ds $1

wddba:: ; ddba
	ds $1

wddbb:: ; ddbb
	ds $4

; the delay (1-8) before a note is cut off early (0 is disabled)
wMusicCutoff:: ; ddbf
	ds $4

wddc3:: ; ddc3
	ds $4

; the volume to apply after a cutoff
wMusicEcho:: ; ddc7
	ds $4

; the pitch offset to apply to each note (see Music1_Pitches)
wMusicPitchOffset:: ; ddcb
	ds $4

wMusicSpeed:: ; ddcf
	ds $4

wMusicVibratoType:: ; ddd3
	ds $4

wMusicVibratoType2:: ; ddd7
	ds $4

wdddb:: ; dddb
	ds $4

wMusicVibratoDelay:: ; dddf
	ds $4

wdde3:: ; dde3
	ds $4

wMusicVolume:: ; dde7
	ds $3

; the frequency offset to apply to each note
wMusicFrequencyOffset:: ; ddea
	ds $3

wdded:: ; dded
	ds $2

wddef:: ; ddef
	ds $1

wddf0:: ; ddf0
	ds $1

wMusicPanning:: ; ddf1
	ds $1

wddf2:: ; ddf2
	ds $1

; 4 pointers to the positions on the stack for each channel
wMusicChannelStackPointers:: ; ddf3
	ds $8

; these stacks contain the address of the command to return to at the end of a sub branch (2 bytes)
; and also contain the address of the command to return to at the end of a loop (2 bytes for address and
; 1 byte for loop count)
wMusicCh1Stack:: ; ddfb
	ds $c

wMusicCh2Stack:: ; de07
	ds $c

wMusicCh3Stack:: ; de13
	ds $c

wMusicCh4Stack:: ; de1f
	ds $c

wde2b:: ; de2b
	ds $3

wde2e:: ; de2e
	ds $1

wSFXPitchOffsets:: ; de2f
	ds $3

wde32:: ; de32
	ds $1

wde33:: ; de33
	ds $4

wde37:: ; de37
	ds $6

wde3d:: ; de3d
	ds $2

wde3f:: ; de3f
	ds $4

wde43:: ; de43
	ds $8

wSFXCommandPointers:: ; de4b
	ds $8

wSFXIsPlaying:: ; de53
	ds $1

wde54:: ; de54
	ds $1

wCurSongIDBackup:: ; de55
	ds $1

wCurSongBankBackup:: ; de56
	ds $1

wMusicStereoPanningBackup:: ; de57
	ds $1

wMusicDuty1Backup:: ; de58
	ds $4

wMusicWaveBackup:: ; de5c
	ds $1

wMusicWaveChangeBackup:: ; de5d
	ds $1

wMusicIsPlayingBackup:: ; de5e
	ds $4

wMusicTieBackup:: ; de62
	ds $4

wMusicChannelPointersBackup:: ; de66
	ds $8

wMusicMainLoopStartBackup:: ; de6e
	ds $8

wde76:: ; de76
	ds $1

wde77:: ; de77
	ds $1

wMusicOctaveBackup:: ; de78
	ds $4

wde7c:: ; de7c
	ds $4

wde80:: ; de80
	ds $4

wde84:: ; de84
	ds $4

wMusicCutoffBackup:: ; de88
	ds $4

wde8c:: ; de8c
	ds $4

wMusicEchoBackup:: ; de90
	ds $4

wMusicPitchOffsetBackup:: ; de94
	ds $4

wMusicSpeedBackup:: ; de98
	ds $4

wMusicVibratoType2Backup:: ; de9c
	ds $4

wMusicVibratoDelayBackup:: ; dea0
	ds $4

wMusicVolumeBackup:: ; dea4
	ds $3

wMusicFrequencyOffsetBackup:: ; dea7
	ds $3

wdeaa:: ; deaa
	ds $2

wdeac:: ; deac
	ds $1

wMusicChannelStackPointersBackup:: ; dead
	ds $8

wMusicCh1StackBackup:: ; deb5
	ds $c * 4

INCLUDE "sram.asm"
