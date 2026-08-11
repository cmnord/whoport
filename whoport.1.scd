WHOPORT(1) "whoport" "User Commands"

# NAME

whoport - show the process(es) listening on TCP ports

# SYNOPSIS

*whoport* _port_...++
*whoport* [*-h*|*--help*]

# DESCRIPTION

*whoport* reports which processes are listening on the given TCP _ports_.
For each port it prints one line per listening process, giving the port, the
process ID, and the full command line of that process.

Ports are queried one at a time so that each reported PID is attributed to the
port it was found on. A single process listening on several of the requested
ports therefore appears once per port.

Only sockets in the *LISTEN* state are considered; established connections to
or from a port are ignored. Host names and service names are not resolved.

# OPTIONS

*-h*, *--help*
	Print a usage message to standard output and exit successfully. Only
	recognized as the first argument.

# OUTPUT

Output is a header line followed by one row per listening process, in the order
the ports were given on the command line:

```
PORT   PID      COMMAND
3000   41552    node server.js
5432   688      /usr/local/opt/postgresql/bin/postgres -D /usr/local/var/postgres
```

The *PORT* and *PID* columns are padded to a fixed width; the *COMMAND* column
is the untruncated command line and may be wider than the terminal.

# EXIT STATUS

*0*
	At least one listening process was found and printed.

*1*
	No arguments were given, or nothing was listening on any of the
	requested ports. In both cases the diagnostic is written to standard
	error.

# EXAMPLES

Find what is holding a development server's port:

```
$ whoport 3000
```

Check several ports at once:

```
$ whoport 3000 8080 5432
```

Kill whatever is on port 3000:

```
$ kill $(whoport 3000 | awk 'NR > 1 { print $2 }')
```

# NOTES

Only TCP is examined. Listeners on UDP ports are not reported.

*lsof* reports only processes the invoking user is permitted to see. Ports held
by another user's process — including root's — may be reported as having
nothing listening unless *whoport* is run with sufficient privileges.

# SEE ALSO

*lsof*(8), *ps*(1), *netstat*(1), *ss*(8)

# AUTHOR

Claire Nord. Source and issue tracker:++
_https://github.com/cmnord/whoport_

# COPYRIGHT

Copyright © 2026 Claire Nord. Released under the MIT License:++
_https://cnord.mit-license.org_

This is free software: you are free to change and redistribute it. There is NO
WARRANTY, to the extent permitted by law.
