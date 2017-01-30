#!/bin/sh
# Make presentation
pandoc src/presentation.md \
  --to revealjs \
  --no-highlight \
  --variable revealjs-url="revealjs" \
  --variable slideNumber="\"c/t\"" \
  --variable transition="none" \
  --variable controls="false" \
  --variable history="true" \
  --variable hlss=zenburn \
  --smart \
  --css "css/custom.css" \
-o index.html
