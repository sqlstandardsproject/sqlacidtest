import argparse
import subprocess
import os
import re

# Example usage:
# python3 test_binary.py --program sqlite3
# python3 test_binary.py --program mysql --extra "-u root"
# python3 test_binary.py --program psql --extra "-d postgres"
# python3 test_binary.py --program duckdb

test_dir = 'sql'
skip_tests = ['renderer.sql']

parser = argparse.ArgumentParser(description='Run all tests for a random binary.')
parser.add_argument(
    '--program',
    dest='program',
    action='store',
    help='Program to test',
    required=True,
)
parser.add_argument(
    '--extra',
    dest='extra',
    action='store',
    help='The extra arguments to pass to the binary',
    default=''
)
parser.add_argument(
    '--test',
    dest='test',
    action='store',
    help='Specifies which test to run (default: all)',
    default=''
)
parser.add_argument(
    '--verbose',
    dest='verbose',
    action='store_true',
    help='Verbose (print failures)',
    default=False
)
args = parser.parse_args()


command = [args.program]
if len(args.extra) > 0:
    command += args.extra.strip().split(' ')

def run_test(file_name):
    input_data = open(file_name).read()
    input_data = re.sub('--[^\n]+', '', input_data) + ';'
    res = subprocess.run(command, input=input_data.encode('utf8'), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout = res.stdout.decode('utf8').strip()
    stderr = res.stderr.decode('utf8').strip()
    if res.returncode != 0:
        if args.verbose:
            print(file_name)
            print(stdout)
            print(stderr)
        result = 'Error'
    elif 'T' in stdout:
        result = 'Success'
    elif 'F' in stdout:
        result = 'Fail'
    else:
        print(file_name)
        print(stdout)
        print(stderr)
        raise Exception('Found neither T nor F in result')
    print(file_name + '   -   ' + result)

file_list = os.listdir(test_dir)
file_list = sorted(file_list)
for f in file_list:
    if f in skip_tests:
        continue
    if len(args.test) > 0 and args.test not in f:
        continue
    test_name = os.path.join(test_dir, f)
    run_test(test_name)
