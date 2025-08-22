#!/bin/bash

if [ "$#" -eq 0 ]; then
	echo "Usage: $0 <pdf_file1> [<pdf_file2> ...]"
	exit 1
fi

if [ "$#" -ge 11 ]; then
	echo "This script only allows up to 10 pdf files"
	exit 1
fi

for INPUT in "$@"; do
	if [ ! -f "$INPUT" ]; then
		echo "Eror: file not found: $INPUT"
		continue
	fi

	if [[ "$INPUT" != *.pdf ]]; then
		echo "Skipping non-pdf file: $INPUT"
		continue
	fi

	base_name=$(basename "$INPUT" .pdf)

	OUTPUT="${base_name}-compressed.pdf"
	echo "Compressing $INPUT to $OUTPUT ..."

	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 \
		-dPDFSETTINGS=/default \
		-dDownsampleColorImages=true \
		-dDownsampleGrayImages=true \
		-dDownsampleMonoImages=true \
		-dColorImageResolution=150 \
		-dGrayImageResolution=150 \
		-dMonoImageResolution=150 \
		-dColorImageDownsampleType=/Bicubic \
		-dGrayImageDownsampleType=/Bicubic \
		-dMonoImageDownsampleType=/Bicubic \
		-dNOPAUSE -dQUIET -dBATCH -sOutputFile="$OUTPUT" "$INPUT"

	if [ $? -eq 0 ]; then
		echo "Successfully compressed $INPUT"
	else
		echo "Error compressing $INPUT. Ghostscript returned error."
	fi
done

echo "Compression process finised."
