import argparse
import subprocess
import os

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
args = parser.parse_args()


command = [args.program]
if len(args.extra) > 0:
    command += args.extra.strip().split(' ')

def run_test(file_name):
    input_data = open(file_name).read().encode('utf8')
    res = subprocess.run(command, input=input_data, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout = res.stdout.decode('utf8').strip()
    stderr = res.stderr.decode('utf8').strip()
    if res.returncode != 0:
        result = 'Error'
    elif 'T' in stdout:
        result = 'Success'
    elif 'F' in stdout:
        result = 'Fail'
    print(file_name + '   -   ' + result)

file_list = os.listdir(test_dir)
file_list = sorted(file_list)
for f in file_list:
    if f in skip_tests:
        continue
    test_name = os.path.join(test_dir, f)
    run_test(test_name)
