(** Representation of the data for a particular client or user.
        
    This module represents all the data associated with a particular 
    user incuding their username, password, profile details, and chats. *)

type username = string
(** [username] is the username for the user *)

type password = string
(** [password] is the password for the user *)

type user_info
(** [user_info] is the abstract type of values representing the values associated 
with a particular user*)

val create_user : username -> password -> user_info
(** [create_user] creates a new user with a given [user] and [pass] *)

val get_username : user_info -> username
(** [get_username] is the username of the person *)

val get_password : user_info -> password
(** [get_username] is the password of the person with the registered [user] *)