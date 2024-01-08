
type username = string
type password = string
exception UserNotFound
exception UserAlreadyExists
type users = (username * Client.user_info) list

let init = []

let add_new_user (user) (pass) (users : users) = 
match List.assoc_opt user users with 
  | None -> (user, Client.create_user user pass) :: users
  | Some _ -> raise UserAlreadyExists

let check_existing_user (user) (pass) (users : users) = 
  match List.assoc_opt user users with 
    | None -> raise UserNotFound
    | Some v -> if (Client.get_password v = pass) then true else false

let get_user_info user users =
  match List.assoc_opt user users with 
    | None -> raise UserNotFound
    | Some v -> v

let taken_username username users = 
  match List.assoc_opt username users with
    | Some _ -> true
    | None -> false