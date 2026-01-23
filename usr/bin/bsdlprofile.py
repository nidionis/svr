#!/usr/bin/env python3
import argparse
import json
from bscon import connect
import requests
import os
import subprocess
import json
from atproto import Client
from atproto_client import models

TMP_DIR="/tmp/profile_tmp"

def save_profile(profile, directory):
    avatar = requests.get(profile.avatar).content
    directory = directory + '/' + profile.handle
    subprocess.run(["mkdir", "-p", directory])
    image_file = directory + '/avatar.jpeg'
    with open(image_file, "wb") as f:
        f.write(avatar)
    description_file = directory + '/description'
    with open(description_file, "w") as f:
        f.write(str(profile.description))
    data_file = directory + '/metadata'
    with open(data_file, "w") as f:
        f.write('\n\ndid : ')
        f.write(str(profile.did))
        f.write('\n\nbanner : ')
        f.write(str(profile.banner))
        f.write("\n\nfollowers: ")
        f.write(str(profile.followers_count))
        f.write('\n\ndisplay_name : ')
        f.write(str(profile.display_name))
        f.write('\n\nfollowers_count : ')
        f.write(str(profile.followers_count))
        f.write('\n\nfollows_count : ')
        f.write(str(profile.follows_count))
        f.write('\n\npinned_post : ')
        f.write(str(profile.pinned_post))
        f.write('\n\nposts_count : ')
        f.write(str(profile.posts_count))
    metadata_file = directory + '/metadata'
    with open(metadata_file, "w") as f:
        f.write('\n\nassociated : ')
        f.write(str(profile.associated))
        f.write('\n\nconstruct : ')
        f.write(str(profile.construct))
        f.write('\n\ncopy : ')
        f.write(str(profile.copy))
        f.write('\n\ncreated_at : ')
        f.write(str(profile.created_at))
        f.write('\n\ndict : ')
        f.write(str(profile.dict))
        f.write('\n\nfrom_orm : ')
        f.write(str(profile.from_orm))
        f.write('\n\nindexed_at : ')
        f.write(str(profile.indexed_at))
        f.write('\n\njoined_via_starter_pack : ')
        f.write(str(profile.joined_via_starter_pack))
        f.write('\n\njson : ')
        f.write(str(profile.json))
        f.write('\n\nlabels : ')
        f.write(str(profile.labels))
        f.write('\n\nmodel_computed_fields : ')
        f.write(str(profile.model_computed_fields))
        f.write('\n\nmodel_config : ')
        f.write(str(profile.model_config))
        f.write('\n\nmodel_construct : ')
        f.write(str(profile.model_construct))
        f.write('\n\nmodel_copy : ')
        f.write(str(profile.model_copy))
        f.write('\n\nmodel_dump : ')
        f.write(str(profile.model_dump))
        f.write('\n\nmodel_dump_json : ')
        f.write(str(profile.model_dump_json))
        f.write('\n\nmodel_extra : ')
        f.write(str(profile.model_extra))
        f.write('\n\nmodel_fields : ')
        f.write(str(profile.model_fields))
        f.write('\n\nmodel_fields_set : ')
        f.write(str(profile.model_fields_set))
        f.write('\n\nmodel_json_schema : ')
        f.write(str(profile.model_json_schema))
        f.write('\n\nmodel_parametrized_name : ')
        f.write(str(profile.model_parametrized_name))
        f.write('\n\nmodel_post_init : ')
        f.write(str(profile.model_post_init))
        f.write('\n\nmodel_rebuild : ')
        f.write(str(profile.model_rebuild))
        f.write('\n\nmodel_validate : ')
        f.write(str(profile.model_validate))
        f.write('\n\nmodel_validate_json : ')
        f.write(str(profile.model_validate_json))
        f.write('\n\nmodel_validate_strings : ')
        f.write(str(profile.model_validate_strings))
        f.write('\n\nparse_file : ')
        f.write(str(profile.parse_file))
        f.write('\n\nparse_obj : ')
        f.write(str(profile.parse_obj))
        f.write('\n\nparse_raw : ')
        f.write(str(profile.parse_raw))
        f.write('\n\npronouns : ')
        f.write(str(profile.pronouns))
        f.write('\n\npy_type : ')
        f.write(str(profile.py_type))
        f.write('\n\nschema : ')
        f.write(str(profile.schema))
        f.write('\n\nschema_json : ')
        f.write(str(profile.schema_json))
        f.write('\n\nstatus : ')
        f.write(str(profile.status))
        f.write('\n\nupdate_forward_refs : ')
        f.write(str(profile.update_forward_refs))
        f.write('\n\nvalidate : ')
        f.write(str(profile.validate))
        f.write('\n\nverification : ')
        f.write(str(profile.verification))
        f.write('\n\nviewer : ')
        f.write(str(profile.viewer))
        f.write('\n\nwebsite : ')
        f.write(str(profile.website))

def get_profile(client, profile, tmp_dir=TMP_DIR, save=False):
    try:
        profile = client.app.bsky.actor.get_profile(params={"actor": profile})
    except:
        print("get_profile: check profile name")
    if save:
        save_profile(profile, tmp_dir)
    return profile



def main():
    parser = argparse.ArgumentParser(description="Download Bluesky profile posts to JSON")
    parser.add_argument("handle", help="Bluesky handle (ex: ni-bot.bsky.social)")
    parser.add_argument("--folder", default=TMP_DIR)
    args = parser.parse_args()

    client = connect()
    profile = get_profile(client, args.handle, args.folder)



if __name__ == "__main__":
    main()

