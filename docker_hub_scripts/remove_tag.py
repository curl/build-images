#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Removes a tag from Docker"""

import argparse
import sys
import logging
import requests

log = logging.getLogger(__name__)


def remove_tag(args):
    """Main script for remove_tag

    """
    # First, obtain a token from the Docker hub.
    login_data = {
        "username": args.username,
        "password": args.password,
    }
    r = requests.post("https://hub.docker.com/v2/users/login/", data=login_data)
    r.raise_for_status()

    # Obtain the token from the response.
    response_data = r.json()

    headers = {
        "Authorization": "JWT {0}".format(response_data["token"])
    }

    # Now delete the tag.
    url = ("https://hub.docker.com/v2/repositories/{org}/{repo}/tags/{tag}"
           .format(org=args.organization,
                   repo=args.repository,
                   tag=args.tag))

    r = requests.delete(url, headers=headers)
    r.raise_for_status()

    return ScriptRC.SUCCESS


def main():
    """Main handling function. Wraps remove_tag."""

    # Set up basic logging
    logging.basicConfig(format="%(asctime)s %(levelname)-5.5s %(message)s",
                        stream=sys.stdout,
                        level=logging.INFO)

    # Run main script.
    parser = argparse.ArgumentParser()
    parser.add_argument("--username", required=True)
    parser.add_argument("--password", required=True)
    parser.add_argument("--organization", default="curlbuildimagestemp")
    parser.add_argument("--repository", required=True)
    parser.add_argument("--tag", required=True)

    args = parser.parse_args()

    try:
        exit_code = remove_tag(args)
    except Exception as e:
        log.exception(e)
        exit_code = ScriptRC.EXCEPTION

    log.info("Returning %d", exit_code)
    return exit_code


class ScriptRC(object):
    SUCCESS = 0
    FAILURE = 1
    EXCEPTION = 2


class ScriptException(Exception):
    pass


if __name__ == '__main__':
    sys.exit(main())
