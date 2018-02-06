#!/usr/bin/env python2

import keyring

def get_client_id(username):
    return keyring.get_password("Login", "{0}_client_id".format(username))
def get_client_secret(username):
    return keyring.get_password("Login", "{0}_client_secret".format(username))
def get_refresh_token(username):
    return keyring.get_password("Login", "{0}_refresh_token".format(username))

