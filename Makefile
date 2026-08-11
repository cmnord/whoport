# whoport(1) is generated from whoport.1.scd; the generated file is committed
# so that installing the tool does not require scdoc.
#
# SOURCE_DATE_EPOCH pins the date in the page footer to the source file's
# mtime, so rebuilding without editing does not churn the output.

whoport.1: whoport.1.scd
	SOURCE_DATE_EPOCH=$$(stat -f %m $< 2>/dev/null || stat -c %Y $<) \
		scdoc <$< >$@

.PHONY: preview clean
preview: ; tools/man-preview whoport.1.scd
clean: ; rm -f whoport.1
