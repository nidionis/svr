#!/usr/bin/env python3
import re
import sys
from bsgetdid import get_did

def get_post_uri(url):
    m = re.search(r'https://bsky\.app/profile/([^/]+)/post/([a-z0-9]+)', url)
    if not m:
        sys.exit("Invalid Bluesky post URL")
    handle, rkey = m.groups()
    did = get_did(handle)
    return f"at://{did}/app.bsky.feed.post/{rkey}"

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <bsky_post_url>")
        sys.exit(1)
    print(get_post_uri(sys.argv[1]))

