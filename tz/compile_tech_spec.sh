#!/bin/bash
fname=$(basename -s .tex $1)
# pdflatex -synctex=1 -interaction=nonstopmode ${fname}.tex
pdflatex -synctex=1 ${fname}.tex
# swap the title page for custom title page
pdftk A=artem_title_page.pdf B=${fname}.pdf cat A B2-end output temp_compile_file_1.pdf
mv "temp_compile_file_1.pdf" ${fname}.pdf
# add the lsit of changes to the back
# pdftk A=list_of_changes.pdf B=${fname}.pdf cat B A output temp_compile_file_1.pdf
# mv "temp_compile_file_1.pdf" ${fname}.pdf
# show but detatch the process and without debug output
evince ${fname}.pdf &
