#!/bin/sh
set -e

LC_COLLATE=C # Enforce known sort order

committers=$(git shortlog -se HEAD | cut -f2,3 | sort)
missing_authors=$(echo "$committers" | comm -13 CONTRIBUTORS -)
missing_authors=$(echo ${missing_authors} | sed 's/Caleb Donovick <donovick@cs.stanford.edu>//' )
missing_authors=$(echo ${missing_authors} | sed 's/Guillem Francès <guillem.frances@upf.edu>//' )
missing_authors=$(echo ${missing_authors} | sed 's/Matthew Fernandez <matthew.fernandez@gmail.com>//' )

if [ -n "$missing_authors" ]
then
  echo "$missing_authors" | awk '{print "::error file=CONTRIBUTORS,line=0::💥 MISSING: " $0}'

  echo "💥 Some committers do NOT appear in CONTRIBUTORS 💥"
  echo ""
  echo "$missing_authors"
  echo "== Note: The following contributors are not committers. Do we need to update .mailmap? =="
  echo "$committers" | comm -23 CONTRIBUTORS -
  exit 1
else
  echo "== Note: The following contributors were checked"
  echo "$(echo $committers | comm -12 CONTRIBUTORS -)"
  echo "All good!"
fi
