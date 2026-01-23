#!/usr/bin/env python3

from atproto import Client
from bscon import connect, DEFAULT_DIR, DEFAULT_DOMAIN
import argparse


def get_did(item, client=None):
    if not client:
        client = Client()
    return client.resolve_handle(item).did

def main():
    p = argparse.ArgumentParser(description="Connect to Bluesky and store session.")
    p.add_argument("diditem", nargs="?", help="Bluesky handle (username)")
    p.add_argument("--domain", default=DEFAULT_DOMAIN)
    p.add_argument("--tokendir", default=DEFAULT_DIR)
    p.add_argument("--passwd", "-p", help="passwd", default=None)
    p.add_argument("--user", "-u", help="for authentified request", default=None)
    args = p.parse_args()

    client = None
    if args.user:
        client = connect(args.user, args.passwd)
    print(get_did(args.diditem, client))

if __name__ == "__main__":
    main()
