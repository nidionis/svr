#!/usr/bin/env python3
import json

def generate_html(posts_file, out_file="profile.html"):
    with open(posts_file, "r", encoding="utf-8") as f:
        posts = json.load(f)

    html = ['<html><body>']
    for post in posts:
        html.append(f"<p>{post.get('text','')}</p>")

        # Handle embedded images if present
        media = post.get("media", [])
        for m in media:
            # Convert CID to IPFS URL
            cid = m.get("cid")
            if cid:
                url = f"https://bsky.social/ipfs/{cid}"
                html.append(f'<img src="{url}" style="width:100px;height:100px;">')

    html.append('</body></html>')

    with open(out_file, "w", encoding="utf-8") as f:
        f.write("\n".join(html))

generate_html("post.json")

