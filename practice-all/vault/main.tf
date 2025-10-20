# provider "aws" {
#     region = "eu-west-1"
# }

# provider "vault" {
#     address = "http://34.247.187.132:8000/"
#     skip_child_token = true

#     auth_login {
#       path = "auth/approle/login"

#       parameters = {
#         role_id   = "e198d518-d255-c127-c4dd-630bb8cc5949"
#         secret_id = "8325a926-9dbc-5854-e53d-57839394b47e"   
#       }
#     }  
# }

# # data "vault_kv_secret_v2" "example" {
# #   mount = "kv" 
# #   name  = "kv"
# # }

# data "vault_generic_secret" "example" {
#   path = "kv/data/kv"
# }