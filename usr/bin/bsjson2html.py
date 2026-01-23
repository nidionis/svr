#!/usr/bin/env python3
import json
import argparse
import html

def extract_post(post):
    """Extract only the desired fields and return HTML string."""
    record = post.get("record", {})
    author = post.get("author", {})

    text = html.escape(str(record.get("text") or ""))
    date = record.get("created_at") or post.get("created_at") or ""
    name = html.escape(str(author.get("display_name") or author.get("handle") or ""))
    avatar = author.get("avatar") or ""
    likes = post.get("like_count") or 0
    shares = post.get("repost_count") or 0

    html_parts = ['<div class="post">']
    if avatar:
        html_parts.append(f'  <img src="{avatar}" style="width:50px;height:50px">')
    html_parts.append(f'  <span class="author">{name}</span>')
    html_parts.append(f'  <span class="date">{date}</span>')
    html_parts.append(f'  <p class="text">{text}</p>')
    html_parts.append(f'  <span class="likes">Likes: {likes}</span>')
    html_parts.append(f'  <span class="shares">Shares: {shares}</span>')
    html_parts.append('</div>\n')

    return "\n".join(html_parts)

def main():
    parser = argparse.ArgumentParser(description="Convert Bluesky JSON posts to minimal HTML")
    parser.add_argument("file", help="JSON input file")
    args = parser.parse_args()

    with open(args.file) as f:
        data = json.load(f)

    thread = data.get("thread", [])
    for item in thread:
        post = item.get("thread", {}).get("post", {})
        if post:
            print(extract_post(post))

if __name__ == "__main__":
    main()

