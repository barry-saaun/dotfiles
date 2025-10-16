#!/bin/bash

# compress-pdf-v2 - Enhanced PDF compression script
# Original location: ~/.config/scripts/compress-pdf-v2
# Symlinked to PATH for system-wide access

SCRIPT_VERSION="2.1"
SCRIPT_PATH="$(realpath "$0")"
ORIGINAL_PATH=$(dirname "$SCRIPT_PATH")/compress-pdf-v2 # For symlink detection

show_help() {
	cat <<EOF
compress-pdf $SCRIPT_VERSION - Compress PDF files for lecture notes

Usage: compress-pdf [OPTIONS] <pdf_file1> [pdf_file2 ...]

Options:
    -h, --help          Show this help message
    -q, --quality       Use 'printer' settings (higher quality, larger files)
    -s, --screen        Use 'screen' settings (maximum compression, lower quality)
    -v, --verbose       Show detailed compression info
    -o, --output DIR    Output directory for compressed files (default: current dir)

Examples:
    compress-pdf notes.pdf                    # Default ebook compression
    compress-pdf -q lecture-slides.pdf        # Higher quality compression
    compress-pdf -s *.pdf                     # Maximum compression
    compress-pdf -o ~/compressed/ week*.pdf   # Output to specific folder

Requirements: Ghostscript (gs)
Files: Up to 10 PDFs at once
EOF
	exit 0
}

# Default settings
QUALITY_MODE="ebook"
VERBOSE=0
OUTPUT_DIR="."
MAX_FILES=10

# Parse options
while [[ $# -gt 0 ]]; do
	case $1 in
	-h | --help)
		show_help
		;;
	-q | --quality)
		QUALITY_MODE="printer"
		shift
		;;
	-s | --screen)
		QUALITY_MODE="screen"
		shift
		;;
	-v | --verbose)
		VERBOSE=1
		shift
		;;
	-o | --output)
		OUTPUT_DIR="$2"
		shift 2
		;;
	-*)
		echo "Error: Unknown option '$1'"
		show_help
		;;
	*)
		FILES+=("$1")
		shift
		;;
	esac
done

# Validate inputs
if [ ${#FILES[@]} -eq 0 ]; then
	echo "Error: No PDF files provided"
	show_help
fi

if [ ${#FILES[@]} -gt $MAX_FILES ]; then
	echo "Error: Maximum $MAX_FILES files allowed"
	exit 1
fi

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

# Check if Ghostscript is available
if ! command -v gs &>/dev/null; then
	echo "Error: Ghostscript (gs) is required but not installed."
	echo "Install it with: brew install ghostscript (macOS) or apt install ghostscript (Linux)"
	exit 1
fi

echo "PDF Compressor v$SCRIPT_VERSION"
echo "Mode: $QUALITY_MODE quality"
if [ $VERBOSE -eq 1 ]; then
	echo "Output directory: $OUTPUT_DIR"
	echo "Files to process: ${FILES[*]}"
	echo ""
fi

for INPUT in "${FILES[@]}"; do
	if [ ! -f "$INPUT" ]; then
		echo "Error: File not found: $INPUT"
		continue
	fi

	if [[ "$INPUT" != *.pdf ]]; then
		echo "Skipping non-PDF file: $INPUT"
		continue
	fi

	base_name=$(basename "$INPUT" .pdf)
	OUTPUT_FILE="$OUTPUT_DIR/${base_name}-compressed.pdf"

	echo "Compressing '$INPUT' -> '$OUTPUT_FILE' ($QUALITY_MODE mode)..."

	# Build Ghostscript command based on mode
	GS_CMD="gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4"

	# Base settings for all modes
	GS_CMD="$GS_CMD -dDownsampleColorImages=true -dDownsampleGrayImages=true -dDownsampleMonoImages=true"
	GS_CMD="$GS_CMD -dColorImageDownsampleType=/Bicubic -dGrayImageDownsampleType=/Bicubic -dMonoImageDownsampleType=/Bicubic"
	GS_CMD="$GS_CMD -dColorImageFilter=/DCTEncode -dGrayImageFilter=/DCTEncode -dMonoImageFilter=/CCITTFaxEncode"
	GS_CMD="$GS_CMD -dAutoFilterColorImages=false -dAutoFilterGrayImages=false -dAutoFilterMonoImages=false"
	GS_CMD="$GS_CMD -dDetectDuplicateImages=true -dCompressFonts=true -dSubsetFonts=true"
	GS_CMD="$GS_CMD -dDOCTags=false -dFastWebView=true -dNOPAUSE -dQUIET -dBATCH"

	# Mode-specific settings
	case $QUALITY_MODE in
	"screen")
		GS_CMD="$GS_CMD -dPDFSETTINGS=/screen -dColorImageResolution=72 -dGrayImageResolution=72 -dMonoImageResolution=72"
		;;
	"ebook")
		GS_CMD="$GS_CMD -dPDFSETTINGS=/ebook -dColorImageResolution=150 -dGrayImageResolution=150 -dMonoImageResolution=150"
		;;
	"printer")
		GS_CMD="$GS_CMD -dPDFSETTINGS=/printer -dColorImageResolution=300 -dGrayImageResolution=300 -dMonoImageResolution=300"
		;;
	esac

	GS_CMD="$GS_CMD -sOutputFile=\"$OUTPUT_FILE\" \"$INPUT\""

	if [ $VERBOSE -eq 1 ]; then
		echo "Ghostscript command: $GS_CMD"
		echo ""
	fi

	# Execute compression
	eval $GS_CMD

	if [ $? -eq 0 ]; then
		if [ $VERBOSE -eq 1 ]; then
			original_size=$(du -h "$INPUT" | cut -f1)
			new_size=$(du -h "$OUTPUT_FILE" | cut -f1)
			echo "✓ Success: $INPUT"
			echo "  Original: $original_size"
			echo "  Compressed: $new_size"
			echo ""
		else
			echo "✓ Compressed: $INPUT"
		fi
	else
		echo "✗ Failed to compress: $INPUT"
		rm -f "$OUTPUT_FILE" # Remove failed output
	fi
done

echo "Compression complete!"
