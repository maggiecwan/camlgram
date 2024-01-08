
type username = string
type password = string
type user_info = {
    username : username;
    password : password
}

let create_user user pass = {username = user; password = pass}

let get_username user = user.username

let get_password user = user.password