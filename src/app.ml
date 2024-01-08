(** This initializes the chat screen for the instant messaging system.*)

(** [choosecolor] is the [color] that the user inputs *)
let choosecolor color = 
  match color with
  | "red" -> ANSITerminal.red
  | "blue" -> ANSITerminal.blue
  | "cyan" -> ANSITerminal.cyan
  | "green" -> ANSITerminal.green
  | "magenta" -> ANSITerminal.magenta
  | "white" -> ANSITerminal.white
  | "black" -> ANSITerminal.black
  | "yellow" -> ANSITerminal.yellow
  | _ -> ANSITerminal.white

(** [print_color] is the [text] printed in the specified [color] *)
let print_color text color = 
  ANSITerminal.print_string [ choosecolor color ] text

(** Checks if [input] is #quit and exits the program accordingly *)
let parse_input input () =
  match input with
  | "#quit" -> Stdlib.exit 0
  | _ -> ()

(** [menu] is a string representation of the possible commands *)
let menu = "
MENU
Create a new chat with another user : #createchat 
Open an an existing chat : #openchat
Quit current chat : #leavechat
Leave Camelgram : #quit
Get chat history : #history
Get list of all chats : #allchats
Get list of text color options : #color
Update Profile Information : #update
Log out : #logout
Call the menu again : #menu
\n"

(** [color_options] is the list of color options that a user can type in *)
let color_options () = 
  print_string "\n";
  print_color "red\n" "red";
  print_color "blue\n" "blue";
  print_color "cyan\n" "cyan";
  print_color "green\n" "green";
  print_color "magenta\n" "magenta";
  print_color "white\n" "white";
  print_color "yellow\n" "yellow";
  print_color "black\n" "black"

(** [print_handle] is a string representation of the user's 
selected command. *)
let print_handle item = 
  print_color ("You have selected: " ^ item ^ "\n") "cyan"

(** [handle_menu] is the response to the user's selected command *)
let rec handle_menu (users : State.users) (user_info : Client.user_info) () =
  print_color menu "yellow";
  match read_line () with
  | x -> match x with 
    | "#createchat" | "#openchat" | "#leavechat" | "#history" | "#allchats" | "#update" -> print_handle x
    | "#color" -> color_options (); handle_menu users user_info ()
    | "#quit" -> Stdlib.exit 0
    | "#logout" -> welcome_screen users ()
    | "#menu" -> handle_menu users user_info ()
    | _ -> print_color "\nInvalid command. Please try again.\n>>\n" "red"; 
      handle_menu users user_info ()


(** [create_account] prompts the user to create an account *)
and create_account (users : State.users) () =
    print_color "\nPlease create a username\n>>\n" "cyan";
    let input_username = read_line () in
    parse_input input_username ();
    match State.taken_username input_username users with 
    | true -> print_color "\nThis username is already exists. \
        Please enter a different username.\n>>\n" "red"; 
        create_account users ()
    | false -> print_color "\nPlease create a password\n>>\n" "cyan"; 
        let input_password = read_line() in 
          parse_input input_password ();
          let updated_users = (State.add_new_user input_username input_password users) in 
          handle_menu updated_users (State.get_user_info input_username updated_users)

(** [user_login] prompts the user to log in to their account and checks that
they have entered valid credentials *)
and user_login (users : State.users) () =
  print_color "\nWhat is your username?\n>>\n" "cyan";
  let input_username = read_line () in
  parse_input input_username ();
  match State.taken_username input_username users with
  | false -> print_color "\nYour username was not found. \
      Please try again.\n" "red"; 
      login users ()
  | true -> print_color "\nWhat is your password?\n>>\n" "cyan";
  let input_password = read_line () in
    parse_input input_password ();
    match (State.check_existing_user input_username input_password users) with
      | true -> handle_menu users (State.get_user_info input_username users) ()
      | false -> print_color "\nYour password is incorrect. \
          Please try again.\n" "red"; 
          user_login users ()

(** [login] either creates a new user or allows an existing user to log in
based on their status in the application *)
and login (users : State.users) () : unit = 
  print_color
  "\nWould you like to create an account? If you have an existing account, select N. Y/N\n>>\n" 
  "cyan";
  match read_line () with
  | "Y" | "y" -> create_account users () ()
  | "N" | "n" -> user_login users ()
  | "#quit" -> Stdlib.exit 0
  | _ -> print_color "\nInvalid entry. Please try again.\n" "red"; 
      login users ()

(** [welcome_screen] is the welcome screen that appears when the user first 
opens the application *)
and welcome_screen users () = 
  print_color "\n🐪🐪 Welcome to the Camlgram! 🐪🐪" "cyan"; 
  print_color "\nCamlgram is an instant messaging system where you can talk to your \
  friends!" "Yellow";
  print_color "\nYou may type #quit if you want to exit at any time, but we'll be sad to see you leave! \n" "Yellow";
  login users ()

let start () =
  let users = State.init in
  welcome_screen users ()