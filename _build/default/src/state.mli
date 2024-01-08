(** Representation of the state of the system.

    This module represents the data for all the users and chats
    registered in the system including usernames, passwords, and
    chat history. *)

exception UserNotFound
exception UserAlreadyExists


type username = string
(** [username] is the username for the user *)

type password = string
(** [password] is the password for the user *)

type users
(** [users] is the list of users and their information *)

val init : users
(** [init] initializes an empty list of [users] *)

val add_new_user : username -> password -> users -> users
(** [add_new_user] adds a new user with a [user] and
[pass] to the list of [users] registered in the system *)

val check_existing_user : username -> password -> users -> bool
(** [check_existing_user] checks whether a user exists in [users]
with the given [user] and [pass] *)

val get_user_info : username -> users -> Client.user_info
(** [get_user_info] is the information associated with the profile of a user
with [user] and [pass] in the list of registered [users] *)

val taken_username : username -> users -> bool
(** [taken_username] checks if the [user] entered already exists in
    the list of [users] *)