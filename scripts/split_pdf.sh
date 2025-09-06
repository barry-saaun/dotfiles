#!/bin/bash

# Check arguments
if [ $# -ne 2 ]; then
	echo "Usage: $0 <pdf_file> <number_of_parts>"
	exit 1
fi

PDF_FILE="$1"
NUM_PARTS="$2"

# Check if file exists
if [ ! -f "$PDF_FILE" ]; then
	echo "Error: File '$PDF_FILE' not found."
	exit 1
fi

# Check if NUM_PARTS is a positive integer
if ! [[ "$NUM_PARTS" =~ ^[0-9]+$ ]] || [ "$NUM_PARTS" -le 0 ]; then
	echo "Error: Number of parts must be a positive integer."
	exit 1
fi

# Get total number of pages
TOTAL_PAGES=$(qpdf --show-npages "$PDF_FILE")

if [ -z "$TOTAL_PAGES" ]; then
	echo "Error: Could not determine number of pages in PDF."
	exit 1
fi

# Calculate pages per part (ceil division)
PAGES_PER_PART=$(((TOTAL_PAGES + NUM_PARTS - 1) / NUM_PARTS))

# Extract base filename without extension
BASENAME=$(basename "$PDF_FILE" .pdf)

# Split into parts
START_PAGE=1
for ((i = 1; i <= NUM_PARTS; i++)); do
	END_PAGE=$((START_PAGE + PAGES_PER_PART - 1))
	if [ "$END_PAGE" -gt "$TOTAL_PAGES" ]; then
		END_PAGE=$TOTAL_PAGES
	fi

	if [ "$START_PAGE" -le "$TOTAL_PAGES" ]; then
		OUTPUT_FILE="${BASENAME}-part${i}.pdf"
		echo "Creating $OUTPUT_FILE (pages $START_PAGE to $END_PAGE)..."
		qpdf "$PDF_FILE" --pages "$PDF_FILE" "$START_PAGE"-"$END_PAGE" -- "$OUTPUT_FILE"
	fi

	START_PAGE=$((END_PAGE + 1))
done

echo "Done! Split into $NUM_PARTS parts."
