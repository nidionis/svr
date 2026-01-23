#!/usr/bin/env python3
import argparse
import json
from bscon import connect

def fetch_thread(client, uri, seen=None):
    """Recursively fetch a post thread including replies."""
    if seen is None:
        seen = set()
    if uri in seen:
        return []
    seen.add(uri)

    resp = client.app.bsky.feed.get_post_thread({"uri": uri})
    data = resp.model_dump()  # convert Pydantic Response to dict
    out = [data]

    post = data.get("thread")
    if post and "replies" in post:
        for reply in post["replies"]:
            child_uri = reply.get("post", {}).get("uri")
            if child_uri:
                out += fetch_thread(client, child_uri, seen)
    return out

def fetch_all_pages(fetch_fn, client, uri, key):
    """Generic paginated fetch (likes, reposts)."""
    results = []
    cursor = None
    while True:
        resp = fetch_fn(client, uri, cursor)
        data = resp.model_dump()  # <-- convert to dict
        results.extend(data.get(key, []))
        cursor = data.get("cursor")
        if not cursor:
            break
    return results

def fetch_likes(client, uri, cursor=None):
    return client.app.bsky.feed.get_likes({"uri": uri, "cursor": cursor})

def fetch_reposts(client, uri, cursor=None):
    return client.app.bsky.feed.get_reposted_by({"uri": uri, "cursor": cursor})

def main():
    parser = argparse.ArgumentParser(description="Load a Bluesky post recursively with interactions.")
    parser.add_argument("uri", help="Post URI (at://did:.../app.bsky.feed.post/...)")
    parser.add_argument("-o", "--output", default="post.json", help="Output file name")
    parser.add_argument("--likes", action="store_true", help="Include likes")
    parser.add_argument("--reposts", action="store_true", help="Include reposts")
    args = parser.parse_args()

    client = connect()
    data = {"thread": fetch_thread(client, args.uri)}

    if args.likes:
        data["likes"] = fetch_all_pages(fetch_likes, client, args.uri, "likes")
    if args.reposts:
        data["reposts"] = fetch_all_pages(fetch_reposts, client, args.uri, "repostedBy")

    with open(args.output, "w") as f:
        json.dump(data, f, indent=2)

    print(f"Saved to {args.output}")

if __name__ == "__main__":
    main()

