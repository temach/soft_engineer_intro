#!/bin/bash
fname=$(basename -s .tex $1)
# xelatex -interaction=nonstopmode ${fname}.tex
xelatex ${fname}.tex
# show but detatch the process and without debug output
evince ${fname}.pdf &
