#!/usr/bin/env python3
import argparse
from atproto import Client

DEFAULT_DOMAIN = "bsky.social"
DEFAULT_TOKEN_FILE = "/tmp/bs/last_token"

def load_token(token_file=DEFAULT_TOKEN_FILE):
    try:
        with open(token_file, "r") as f:
            return f.read().strip()
    except FileNotFoundError:
        return None

def fetch_post_uris(handle, token=None):
    client = Client()
    if token:
        client.login_with_access_token(token)

    # Resolve handle to DID
    did = client.resolve_handle(handle).did

    uris = []
    limit = 50
    cursor = None

    while True:
        resp = client.app.bsky.feed.get_author_feed(
            actor=did, limit=limit, cursor=cursor
        )
        for post in resp.data.feed:
            uris.append(post.post.uri)

        if not resp.data.cursor:
            break
        cursor = resp.data.cursor

    return uris

def main():
    parser = argparse.ArgumentParser(description="Fetch all post URIs of a Bluesky profile")
    parser.add_argument("handle", help="Bluesky handle (ex: alice.bsky.social)")
    parser.add_argument("--token-file", default=DEFAULT_TOKEN_FILE, help="File storing access token")
    args = parser.parse_args()

    token = load_token(args.token_file)
    uris = fetch_post_uris(args.handle, token)

    for uri in uris:
        print(uri)

if __name__ == "__main__":
    main()

