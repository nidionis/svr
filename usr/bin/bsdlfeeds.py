#!/usr/bin/env python3

import argparse
import json
from bscon import connect
from bsdlprofile import TMP_DIR
import requests
import os
import subprocess
import re
from atproto import Client
from atproto_client import models

LIMIT_LOAD = 100

def save_item(filename, obj, directory=""):
    filename = f"{directory}/{filename}"
    subprocess.run(["mkdir", "-p", directory])
    with open(filename, 'w') as f:
        f.write(str(obj))

def save_items(obj, directory=""):
    if isinstance(obj, dict):
        for k, v in obj.items():
            new_dir = f"{directory}/{k}" if directory else k
            save_items(v, new_dir)
    elif isinstance(obj, list):
        for i, v in enumerate(obj):
            new_dir = f"{directory}[{i}]"
            save_items(v, new_dir)
    else:
        filename = ''.join(re.findall(r'[a-zA-Z0-9]', str(obj)[:20])) + '.txt'
        save_item(filename, obj, directory)


def get_feeds(client, profile, tmp_dir=TMP_DIR, save=False, cursor=None):
    directory = f"{tmp_dir}/{profile}"
    n = 0
    while True:
        res = client.app.bsky.feed.get_author_feed(
            params={"actor": profile, "limit": LIMIT_LOAD, **({"cursor": cursor} if cursor else {})}
        )
        for post in res["feed"]:
            item_directory = f"{directory}/{n:05d}"
            print(f"\nsaving: {n:05d}\n\t{post.post.record.text}")
            save_items(post.model_dump(), item_directory)
            n += 1
        cursor = res.cursor
        if not cursor:
            break




def main():
    parser = argparse.ArgumentParser(description="Download Bluesky profile posts to JSON")
    parser.add_argument("handle", help="Bluesky handle (ex: ni-bot.bsky.social)")
    parser.add_argument("--folder", default=TMP_DIR)
    args = parser.parse_args()

    client = connect()
<<<<<<< HEAD
    profile = get_feeds(client, args.handle, args.folder, cursor=cursor)
=======
    profile = get_feeds(client, args.handle, args.folder)
>>>>>>> 01ee0aacb9e93bd6572ab9049f26878733f8bf85



if __name__ == "__main__":
    main()

