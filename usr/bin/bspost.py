#!/usr/bin/env python3

from bscon import DEFAULT_DOMAIN, DEFAULT_DIR, connect
import argparse

def main():
    p = argparse.ArgumentParser(description="Connect to Bluesky and store session.")
    p.add_argument("name", nargs="?", help="Bluesky handle (username)")
    p.add_argument("--domain", default=DEFAULT_DOMAIN)
    p.add_argument("--tokendir", default=DEFAULT_DIR)
    p.add_argument("--text", "-t", )
    p.add_argument("--passwd", "-p", help="passwd", default=None)
    args = p.parse_args()

    client = connect(args.name, args.domain, args.passwd, args.tokendir)
    print(f"connected")
    client.send_post(text=args.text)

if __name__ == "__main__":
    main()
