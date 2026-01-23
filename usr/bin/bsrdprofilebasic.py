#!/usr/bin/env python3
import argparse
import json
from html import escape
from bscon import connect

def get_posts(client, handle, limit=100):
    """Download all public posts of a profile with images."""
    posts = []
    cursor = None

    while True:
        resp = client.app.bsky.feed.get_author_feed({
            "actor": handle,
            "limit": limit,
            "cursor": cursor,
        })

        for item in resp.feed:
            post = item.post
            record = post.record

            # Extract images if any
            images = []
            embed = getattr(record, "embed", None)
            if embed and hasattr(embed, "images"):
                images = [{"thumb": i.thumb, "full": i.fullsize} for i in embed.images]

            posts.append({
                "uri": post.uri,
                "cid": post.cid,
                "createdAt": getattr(record, "createdAt", None) or getattr(record, "created_at", None),
                "text": getattr(record, "text", ""),
                "images": images
            })

        cursor = getattr(resp, "cursor", None)
        if not cursor:
            break

    return posts

def save_posts(posts, handle):
    """Save posts to JSON."""
    out_file = f"{handle.replace('.', '_')}_posts.json"
    with open(out_file, "w", encoding="utf-8") as f:
        json.dump(posts, f, indent=2, ensure_ascii=False)
    print(f"Saved {len(posts)} posts to {out_file}")

def uri_to_url(uri):
    """Convert at://did/... URIs to clickable Bluesky URLs."""
    parts = uri.split("/")
    if len(parts) >= 5 and parts[3] == "app.bsky.feed.post":
        did = parts[2]
        rkey = parts[4]
        return f"https://bsky.app/profile/{did}/post/{rkey}"
    return uri

def posts_to_html(posts, out_html):
    """Generate HTML with text and image thumbnails."""
    with open(out_html, "w", encoding="utf-8") as f:
        f.write("<html><body>\n")
        for post in posts:
            text = escape(post.get("text", ""))
            url = uri_to_url(post.get("uri", ""))
            imgs_html = "".join(
                f'<a href="{escape(img["full"])}"><img src="{escape(img["thumb"])}" '
                f'style="width:120px;height:auto;margin:2px;"></a>'
                for img in post.get("images", [])
            )
            f.write(f"<div style='margin-bottom:20px;'><p>{text}</p>{imgs_html}<br>"
                    f"<a href='{url}'>View post</a></div>\n")
        f.write("</body></html>\n")
    print(f"HTML saved to {out_html}")

def main():
    parser = argparse.ArgumentParser(description="Download Bluesky profile posts and generate HTML.")
    parser.add_argument("handle", help="Bluesky handle (example: alice.bsky.social)")
    parser.add_argument("--limit", type=int, default=100, help="Posts per request")
    args = parser.parse_args()

    client = connect()
    posts = get_posts(client, args.handle, args.limit)
    save_posts(posts, args.handle)

    out_html = f"{args.handle.replace('.', '_')}_posts.html"
    posts_to_html(posts, out_html)

if __name__ == "__main__":
    main()

