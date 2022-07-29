#!/bin/env bash
# $Id: pdf2eps,v 0.01 2005/10/28 00:55:46 Herbert Voss Exp $
# Convert PDF to encapsulated PostScript.
# usage:
# pdf2eps <page number> <pdf file without ext>

## https://gist.github.com/caruccio/836c2dda2bdfa5666c5f9b0230978f26
help=false
ARGS=()

Help() {
   # Display Help
   echo "pdf to eps converter script."
   echo
   echo "Syntax: pdf2eps [-h] <pagenumber> <pdf without ext>"
   echo "options:"
   echo "-h     Print this help page."
}
while [ $# -gt 0 ]; do
    while getopts h: name; do
        case $name in
            h) help=true;;
        esac
    done
    [ $? -eq 0 ] || exit 1
    [ $OPTIND -gt $# ] && break   # we reach end of parameters

    shift $[$OPTIND - 1] # free processed options so far
    OPTIND=1             # we must reset OPTIND
    ARGS[${#ARGS[*]}]=$1 # save first non-option argument (a.k.a. positional argument)
    shift                # remove saved arg
done

if [ ${#ARGS[@]} -lt 1 ];
then
    echo "No filename given!"
    exit
fi

if [ ${#ARGS[@]} -gt 2 ];
then
    echo "Too many arguments given!"
    exit
fi

if [ $help = true ];
then
    echo $help
    Help
    exit 0;
fi

if [ ${#ARGS[@]} -eq 1 ];
then
    pdfcrop ${ARGS[0]}.pdf
    pdftops -f 1 -l 1 -eps "${ARGS[0]}-crop.pdf" 
    rm "${ARGS[0]}-crop.pdf"
    mv "${ARGS[0]}-crop.eps" ${ARGS[0]}.eps
else
    pdfcrop ${ARGS[1]}.pdf
    pdftops -f ${ARGS[0]} -l ${ARGS[0]} -eps "${ARGS[1]}-crop.pdf" 
    rm  "${ARGS[1]}-crop.pdf"
    mv  "${ARGS[1]}-crop.eps" ${ARGS[1]}.eps
fi

