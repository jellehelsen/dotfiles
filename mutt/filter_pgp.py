#!/usr/bin/env python3
from sys import stdin, stdout

# data=stdin.read()
# print(data)

in_pgp_output = False
pgp_buffer = ""
pgp_ok = False

for line in stdin:
    if '[-- PGP output follows (' in line:
        in_pgp_output = True
        pgp_buffer = line
        pgp_ok = False
    elif in_pgp_output:
        pgp_buffer += line
        if 'DECRYPTION_OKAY' in line:
            pgp_ok = True
        elif '[-- End of PGP output --]' in line:
            in_pgp_output = False
            if not pgp_ok:
                stdout.write(pgp_buffer)
            else:
                stdout.write("[-- PGP OK --]\n")
    else:
        stdout.write(line)
