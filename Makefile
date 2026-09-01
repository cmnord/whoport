# whoport(1) is generated from whoport.1.scd; the generated file is committed
# so that installing the tool does not require scdoc.
#
# SOURCE_DATE_EPOCH pins the footer date to the source file's mtime. GNU stat
# uses -f for filesystem status, so try -c before the BSD/macOS -f form.

whoport.1: whoport.1.scd
	SOURCE_DATE_EPOCH=$$(stat -c %Y $< 2>/dev/null || stat -f %m $<) \
		scdoc <$< >$@

.PHONY: preview clean
preview: ; tools/man-preview whoport.1.scd
clean: ; rm -f whoport.1
