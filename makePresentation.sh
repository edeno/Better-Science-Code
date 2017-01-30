#!/bin/sh
# Make presentation
pandoc src/presentation.md \
  --to revealjs \
  --highlight-style zenburn \
  --variable revealjs-url="revealjs" \
  --variable slideNumber="\"c/t\"" \
  --variable transition="none" \
  --variable controls="false" \
  --variable history="true" \
  --smart \
  --css "css/custom.css" \
-o index.html
