open OUnit2
open Chat
open State
open Client


 let user_1 = create_user "meera" "mr828"
 let user_2 = create_user "maggie" "mw695"
 let user_list = init

let user_list_1 = add_new_user "meera" "mr828" init 

(** add_new_test name user pass users expected_output] constructs an
    OUnit test named [name] that asserts the quality of
    [expected_output] with [add_new_test name input room_id ]. *)
    let add_new_test
    (name : string)
    (user : string)
    (pass : string)
    (users : users)
    (expected_output : users) : test =
  name >:: fun _ ->

  assert_equal expected_output
    (add_new_user user pass users)
   
    
(** check_user_test name user pass users expected_output] constructs an
    OUnit test named [name] that asserts the quality of
    [expected_output] with [check_user_test name user pass users ]. *)
    let check_user_test
    (name : string)
    (user : string)
    (pass : string)
    (users : users)
    (expected_output : bool) : test =
  name >:: fun _ ->

  assert_equal expected_output
    (check_existing_user user pass users)


    
(** user_info_test name user users expected_output] constructs an
    OUnit test named [name] that asserts the quality of
    [expected_output] with [user_info_test name user users ]. *)
    let user_info_test
    (name : string)
    (user : string)
    (users : users)
    (expected_output : user_info) : test =
  name >:: fun _ ->

  assert_equal expected_output
    (get_user_info user users)

(** taken_username_test name user users expected_output] constructs an
    OUnit test named [name] that asserts the quality of
    [expected_output] with [taken_username_test name user users ]. *)
    let taken_username_test
    (name : string)
    (user : string)
    (users : users)
    (expected_output : bool) : test =
  name >:: fun _ ->

  assert_equal expected_output
    (taken_username user users)

  (** get_username_test name user pass expected_output] constructs an
    OUnit test named [name] that asserts the quality of
    [expected_output] with [get_username_test name user pass]. *)
    let get_username_test
    (name : string)
    (user: user_info)
    (expected_output : string) : test =
  name >:: fun _ ->

  assert_equal expected_output
    (get_username user)

(** get_password_test name user pass expected_output] constructs an
    OUnit test named [name] that asserts the quality of
    [expected_output] with [get_password_test name user pass]. *)
    let get_password_test
    (name : string)
    (user: user_info)
    (expected_output : string) : test =
  name >:: fun _ ->

  assert_equal expected_output
    (get_password user)

let state_tests = [
  add_new_test "this is the test for adding user meera" "meera" "mr828" user_list user_list_1;
  ( "existing user" >:: fun _ ->
    assert_raises UserAlreadyExists (fun () -> add_new_user "meera" "mr828" user_list_1) );
  check_user_test "checking if meera is in user list" "meera" "mr828" user_list_1 true;
  check_user_test "checking meera in list but wrong password" "meera" "m828" user_list_1 false;
    ( "existing user" >:: fun _ ->
      assert_raises UserNotFound (fun () -> check_existing_user "maggie" "mw695" user_list_1) );
  user_info_test "getting meera's info" "meera" user_list_1 user_1 ;
  ( "trying to find non-existing user" >:: fun _ ->
    assert_raises UserNotFound (fun () -> get_user_info "maggie" user_list_1) );
  taken_username_test "checking if meera exists in list" "meera" user_list_1 true;
  taken_username_test " checking if maggie exists in list" "maggie" user_list_1 false;
  ]

  let client_tests = [
    get_username_test "getting meera's username" user_1 "meera";
    get_username_test "getting maggie's username" user_2 "maggie";
    get_password_test "getting meera's password" user_1 "mr828";
   get_password_test "getting maggie's password" user_2 "mw695";

  ]

let suite =
  "test suite"
  >::: List.flatten
         [ client_tests; state_tests ]

let _ = run_test_tt_main suite