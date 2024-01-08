(** This initializes the chat screen for the instant messaging system.*)

(** [user_login] takes in the username and password to allow an existing user to 
log in to their account *)
let user_login () =
  print_endline
  "\nWhat is your username?\n";
  match read_line () with 
  | _ -> ()

(** [create_account] takes in a username and password to create an account
for a new user *)
let create_account () =
    print_endline
    "\nPlease create a username\n";
    match read_line () with 
  | _ -> ()

(** [login] either creates a new user or allows an existing user to log in
based on their status in the application *)
let rec login () = 
  print_endline
  "\nAre you already a user of Camelgram? Y/N\n";
  match read_line () with
  | "Y" | "y" -> user_login ()
  | "N" | "n" -> create_account ()
  | _ -> print_endline "Invalid entry :( Try again!"; login ()

(* [menu] is a string representation of the possible commands *)
  let menu = "
  Create a new chat with another user : createchat 
  Open an an existing chat : openchat
  Quit current chat : quitchat
  Leave Camelgram : leave
  Get chat history : history
  Get list of all chats : allchats
  Update Profile Information : update
  \n\n"

(** [print_handle] is a string representation of the user's 
selected command. (TODO) *)
let print_handle item = 
  print_endline ("You have selected: " ^ item)

(** [handle_menu] is the response to the user's selected command *)
let rec handle_menu () =
  ANSITerminal.print_string [ ANSITerminal.green] menu;
  match read_line () with
  | x -> match x with 
    | "createchat" | "openchat" | "quitchat" | "history" | "allchats" | "update" -> print_handle x
    | "leave" -> Stdlib.exit 0
    | _ -> ANSITerminal.print_string [ ANSITerminal.red]
     "\nInvalid entry :( Try again!\n"; handle_menu ()

let welc_message () = 
  ANSITerminal.print_string [ ANSITerminal.cyan ]
  "\n\nWelcome to the Camelgram!\n";
  ANSITerminal.print_string [ ANSITerminal.yellow]
  "\nCamelgram is an instant messaging system where you can talk to your \
  friends! \n";
  login ();
  handle_menu ()
  

  
  