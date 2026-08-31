# whoport

Show the process(es) listening on one or more TCP ports.

```
whoport 3000              one port
whoport 3000 8080 5432    several ports
```

## Install

Symlink (or copy) `whoport` onto your `PATH`:

```
ln -s "$(pwd)/whoport" /usr/local/bin/whoport
```

For `man whoport`, symlink the man page into a directory on your `manpath`.
Run `manpath` to see yours; on Homebrew that is the `share/man/man1` under
`brew --prefix`:

```
ln -s "$(pwd)/whoport.1" "$(brew --prefix)/share/man/man1/whoport.1"
```

Elsewhere, `/usr/local/share/man/man1` is the usual spot — create it first if
it does not exist, and check that `manpath` lists it.

Without installing, read it in place:

```
man ./whoport.1
```

## Development

**Edit `whoport.1.scd`, not `whoport.1`.** The man page is written in
[scdoc](https://git.sr.ht/~sircmpwn/scdoc), a small markdown-ish format, and
compiled to roff. The generated `whoport.1` is committed so that installing the
tool needs no build step — but it is overwritten on every build.

```
./setup.sh
make
```

scdoc is the syntax check — it fails loudly on malformed input.

### Preview while editing

```
make preview
```

Opens the rendered page in a browser and rebuilds it on every save. Updates
swap the page body in place rather than reloading, so there is no spinner or
flash and your scroll position is kept. A scdoc syntax error leaves the last
good render on screen instead of blanking it.

Needs `entr` and `python3` — the local server exists because `fetch()` is
blocked on `file://` URLs. Both the server and the watcher stop with `^C`.

For a terminal preview instead, watch the source and re-render on save:

```
echo whoport.1.scd | MANPAGER=cat entr -c sh -c 'scdoc <whoport.1.scd | mandoc'
```

`-c` clears the screen between renders, so it reads like a preview pane.
`MANPAGER=cat` matters: plain `man` pipes to `less`, which holds the terminal
until you quit it, and `entr` would not see the next save. That is also why the
terminal loop cannot refresh under a pager — use the browser preview if you
want scrolling and hands-off updates at the same time.

It opens a tab, re-renders on save, and prints lint warnings to the terminal as
you go. Updates arrive by swapping the page body in place rather than
reloading, so there is no spinner or flash and your scroll position is kept.

Needs `entr` and `python3` — the local server exists because `fetch()` is
blocked on `file://` URLs. Both the server and the watcher stop with `^C`.

Note that a `less`-based loop cannot refresh on its own: `entr` waits for the
child to exit before reacting to the next save, and `less` has no watch mode of
its own — only manual `R`. So with a pager you refresh by quitting it.

## License

[MIT](https://cnord.mit-license.org) © Claire Nord. See [LICENSE](LICENSE).
