#!/usr/bin/bash


jq '.thread[] | {author: .thread.post.author.handle, text: .thread.post.record.text}' $1
