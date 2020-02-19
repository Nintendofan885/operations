#!/usr/bin/env python3

#   -------------------------------------------------------------
#   Operations utilities
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#   Project:        Nasqueron
#   Author:         Sébastien Santoro aka Dereckson
#   Created:        2018-09-22
#   License:        BSD-2-Clause
#   Source file:    roles/devserver/userland-software/files/url.py
#   -------------------------------------------------------------
#
#   <auto-generated>
#       This file is managed by our rOPS SaltStack repository.
#
#       Changes to this file may cause incorrect behavior
#       and will be lost if the state is redeployed.
#   </auto-generated>


import platform
import os
import sys
import yaml


#   -------------------------------------------------------------
#   Exceptions
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


class NotFoundException(Exception):
    pass


#   -------------------------------------------------------------
#   Configuration file locator
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


def get_candidates_configuration_files():
    candidates = []

    if 'HOME' in os.environ:
        candidates.append(os.environ['HOME'] + "/.urls.yml")

    candidates.append('/usr/local/etc/urls.yml')
    candidates.append('/etc/urls.yml')

    return candidates


def find_configuration_file():
    for candidate in get_candidates_configuration_files():
        if os.path.isfile(candidate):
            return candidate


#   -------------------------------------------------------------
#   Configuration file parser
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


def parse_configuration_file(filename):
    configuration_file = open(filename, 'r')
    configuration = yaml.safe_load(configuration_file)
    configuration_file.close()

    if 'urls' not in configuration:
        configuration['urls'] = {}

    return configuration


def get_configuration():
    configuration_file = find_configuration_file()

    if configuration_file is None:
        print_error("No shell configuration file found")
        exit(2)

    return parse_configuration_file(configuration_file)


#   -------------------------------------------------------------
#   URL resolver
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


def extract_relative_url(base_directory, search_path):
    n = len(base_directory) + 1
    return search_path[n:]


def extract_relative_user_url(base_directory, search_path):
    return extract_relative_url_in_fragments(base_directory,
                                             search_path, 1)


def extract_relative_wwwroot_url(base_directory, search_path):
    return extract_relative_url_in_fragments(base_directory,
                                             search_path, 2)


def extract_relative_url_in_fragments(base_directory, search_path,
                                      fragments_count):
    base_url = extract_relative_url(base_directory, search_path)
    fragments = base_url.split("/", fragments_count)

    expected_len = fragments_count + 1
    actual_len = len(fragments)
    delta_len = expected_len - actual_len

    if delta_len > 1 or len(fragments[0]) == 0:
        raise NotFoundException()

    if delta_len == 1:
        fragments.append("")

    return tuple(fragments)


def resolve_url(base_directory, args, search_path):
    if 'static' in args:
        return args['static'] + extract_relative_url(base_directory,
                                                     search_path)

    if 'userdir' in args:
        username, local_url = extract_relative_user_url(base_directory,
                                                        search_path)
        return "https://" + platform.node() + "/~" + username + "/" + local_url

    if 'wwwroot' in args:
        domain, sub, local_url = extract_relative_wwwroot_url(base_directory,
                                                              search_path)
        return "https://" + sub + "." + domain + "/" + local_url

    return None


def find_path(base_directory, search_path):
    if os.path.isabs(search_path):
        normalized_path = search_path
    else:
        normalized_path = os.path.normpath(os.path.join(base_directory,
                                                        search_path))

    return os.path.realpath(normalized_path)


def find_url(urls, base_directory, required_path):
    path = find_path(base_directory, required_path)

    for url_base_dir, url_args in urls.items():
        url_base_dir = os.path.realpath(url_base_dir)
        if path.startswith(url_base_dir):
            try:
                return resolve_url(url_base_dir, url_args, path)
            except NotFoundException:
                continue

    return None


#   -------------------------------------------------------------
#   Runner code
#   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


def get_program_name():
    return os.path.basename(sys.argv[0])


def print_error(err):
    print("{}: {}".format(get_program_name(), err), file=sys.stderr)


def usage():
    print("usage: url [path]", file=sys.stderr)


def parse_path_argument():
    argc = len(sys.argv)

    if argc == 1:
        return '.'
    elif argc == 2:
        return sys.argv[1]
    else:
        usage()
        exit(1)


def main():
    required_path = parse_path_argument()
    config = get_configuration()

    url = find_url(config['urls'], os.getcwd(), required_path)
    if url is None:
        print_error("No URL found.")
        sys.exit(1)
    else:
        print(url)


if __name__ == '__main__':
    main()