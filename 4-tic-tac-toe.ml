module IntSet = Set.Make(Int)

(* All available positions in the grid *)
let all_positions =
  [1; 2; 3; 4;
   5; 6; 7; 8;
   9; 10; 11; 12;
   13; 14; 15; 16] 

(* Every winning combinations: List of sets. Transform every List inside the bigger list into Sets *)
let winning_sets = List.map IntSet.of_list [
    [1; 2; 3; 4];
    [5; 6; 7; 8];
    [9; 10; 11; 12];
    [13; 14; 15; 16];
    [1; 5; 9; 13];
    [2; 6; 10; 14];
    [3; 7; 11; 15];
    [4; 8; 12; 16];
    [1; 6; 11; 16];
    [4; 7; 10; 13]
  ] 

(* 
Specification: check
Signature: IntSet.t -> bool = <fun>
Checks if a given list contains the correct postions for a player to win.
w is the length of the intersection between each element from winning_sets and the list of the player's pawns.
Thus if the length of w is 4, the player has won.
*)
let check l = (
  let verify w =
    List.length (IntSet.elements (IntSet.inter l w)) in

  let res = List.map verify winning_sets in

  List.mem 4 res
);;

(*
Specification: display_pos
Signature: unit list -> [(); (); (); (); (); (); (); (); (); (); (); (); (); (); (); ()]= <fun>
Displays the coordinates of the board at the start of the game.
*)
let display_pos = (
  let display_positions i position = (
    (* For each position we check if the value is < to 10 to correctly format the grid *)
    if position < 10 then Printf.printf " ";
    Printf.printf "%d" position;
    (* We break line whenever we reach the end of each line at 4 elements *)
    if i mod 4 = 3 then Printf.printf "\n"
    else Printf.printf " "
  ) in
  List.mapi display_positions all_positions;
)

(*
Specification: display
Signature: IntSet.t -> IntSet.t -> unit list = <fun>
Displays the current state of the board.   
*)
let display player1_set player2_set = (
  let display_board i position = (
    (* For each position we check if the given position is contained in the player1's set. In that case we print 1 *)
    if IntSet.mem position player1_set then Printf.printf "1"
    (* For each position we check if the given position is contained in the player2's set. In that case we print 2 *)
    else if IntSet.mem position player2_set then Printf.printf "2"
    (* Else that means the given position is free. In that case we print a point . *)
    else Printf.printf ".";
    (* We break line whenever we reach the end of each line at 4 elements *)
    if i mod 4 = 3 then Printf.printf "\n"
    else Printf.printf " "
  ) in
  List.mapi display_board all_positions;
)

(*
Specification: game
Signature: IntSet.t -> IntSet.t -> unit list = <fun>
Main game loop, while no player has won, asks each player for their input and checks if the input is correct, otherwise they have to try again until the input is correct.
*)
let rec game player1_set player2_set turn =
  (* Before asking for input we check if a player already won. If a player won then the game ends. *)
  (* Check if player 1 won *)
  if check player1_set then Printf.printf "Player 1 won!\n"
  (* Else check if player 2 won *)
  else if check player2_set then Printf.printf "Player 2 won!\n"
  else(
    (* Display every positions *)
    display_pos;
    Printf.printf "___________\n"
    (* Display current state of board with users' inputs *)
    display player1_set player2_set;
    Printf.printf "Player %d, select where to play: " turn;
    (* Ask for user to enter position *)
    let player_input = read_int() in
    (* Check if player's input is contained in the available positions for the game. If not contained call game without changing the turn. *)
    if not (List.mem player_input all_positions) then (Printf.printf "Invalid position.\n"; game player1_set player2_set turn)
    (* Check if player's input is not already taken by checking if it is inside the 2 players' inputs lists. If already taken call game without changing the turn. *)
    else if (IntSet.mem player_input player1_set || IntSet.mem player_input player2_set) then (Printf.printf "Already taken.\n"; game player1_set player2_set turn)
    else(
      (* Check if turn equals 1. If that is the case we call game and we add the player's input inside the player's 1 set and we set the turn to 2. *)
      if turn = 1 then (game (IntSet.add player_input player1_set) player2_set 2)
      (* Check if turn equals 2. If that is the case we call game and we add the player's input inside the player's 2 set and we set the turn to 1. *)
      else if turn = 2 then (game player1_set (IntSet.add player_input player2_set) 1);
    ));;

(* We create and initialise an empty Set for the player 1 *)
let player1_set = IntSet.of_list []

(* We create and initialise an empty Set for the player 2 *)
let player2_set = IntSet.of_list []

(* We create and initialise an integer for the current state of turn. If 1 player1's turn, if 2 player2's turn. *)
let turn = 1;;

game player1_set player2_set turn
