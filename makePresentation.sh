#!/bin/sh
# Make presentation
pandoc src/presentation.md \
  --to revealjs \
  --variable revealjs-url="revealjs" \
  --variable slideNumber="\"c/t\"" \
  --variable transition="none" \
  --variable controls="false" \
  --variable history="true" \
  --smart \
  --css "custom.css" \
-o index.html
