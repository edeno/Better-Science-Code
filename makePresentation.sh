#!/bin/sh
# Make presentation
pandoc src/presentation.md \
  --to revealjs \
  --variable revealjs-url="" \
  --variable slideNumber="\"c/t\"" \
  --variable transition="none" \
  --variable controls="false" \
  --variable history="true" \
  --smart \
-o index.html
