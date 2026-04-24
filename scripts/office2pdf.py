#!/usr/bin/env python3
"""
office2pdf.py - Convert Office files (PPTX, DOCX, XLSX, etc.) to PDF
"""

import argparse
import subprocess
import sys
from pathlib import Path

SUPPORTED_EXTENSIONS = {
    ".pptx",
    ".ppt",
    ".docx",
    ".doc",
    ".xlsx",
    ".xls",
    ".odp",
    ".odt",
}


def find_libreoffice() -> str:
    candidates = [
        "libreoffice",
        "soffice",
        "/usr/bin/libreoffice",
        "/usr/bin/soffice",
        "/usr/local/bin/libreoffice",
        "/Applications/LibreOffice.app/Contents/MacOS/soffice",
        r"C:\Program Files\LibreOffice\program\soffice.exe",
        r"C:\Program Files (x86)\LibreOffice\program\soffice.exe",
    ]

    for candidate in candidates:
        try:
            result = subprocess.run(
                [candidate, "--version"],
                capture_output=True,
                timeout=5,
            )
            if result.returncode == 0:
                return candidate
        except (FileNotFoundError, subprocess.TimeoutExpired):
            continue

    return None


def convert_to_pdf(input_path: Path, output_dir: Path) -> Path:
    libreoffice = find_libreoffice()

    if not libreoffice:
        print(
            "Error: LibreOffice not found. Please install it from https://www.libreoffice.org/",
            file=sys.stderr,
        )
        sys.exit(1)

    output_dir.mkdir(parents=True, exist_ok=True)

    cmd = [
        libreoffice,
        "--headless",
        "--convert-to",
        "pdf",
        "--outdir",
        str(output_dir),
        str(input_path),
    ]

    print(
        f"Converting: {input_path.name} -> {output_dir / input_path.with_suffix('.pdf').name}"
    )

    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print(f"Error converting {input_path.name}:", file=sys.stderr)
        print(result.stderr, file=sys.stderr)
        return None

    output_file = output_dir / input_path.with_suffix(".pdf").name
    if output_file.exists():
        print(f"Success: {output_file}")
        return output_file
    else:
        print(f"Error: Output file not found at {output_file}", file=sys.stderr)
        return None


def main():
    ext_list = ", ".join(sorted(SUPPORTED_EXTENSIONS))

    parser = argparse.ArgumentParser(
        description=f"Convert Office files to PDF using LibreOffice. Supported: {ext_list}"
    )
    parser.add_argument(
        "input",
        nargs="+",
        help="Input file(s) or directory to convert",
    )
    parser.add_argument(
        "-o",
        "--output",
        default=None,
        help="Output directory for PDF files (default: same as input file)",
    )

    args = parser.parse_args()

    files_to_convert = []

    for input_arg in args.input:
        input_path = Path(input_arg)

        if input_path.is_dir():
            found = [
                f
                for f in input_path.iterdir()
                if f.is_file() and f.suffix.lower() in SUPPORTED_EXTENSIONS
            ]
            if not found:
                print(f"Warning: No supported files found in {input_path}")
            files_to_convert.extend(found)
        elif input_path.is_file():
            if input_path.suffix.lower() not in SUPPORTED_EXTENSIONS:
                print(
                    f"Warning: {input_path.name} is not a supported format, skipping."
                )
            else:
                files_to_convert.append(input_path)
        else:
            print(f"Error: {input_arg} does not exist.", file=sys.stderr)
            sys.exit(1)

    if not files_to_convert:
        print("No supported files to convert.")
        sys.exit(0)

    print(f"Found {len(files_to_convert)} file(s) to convert.\n")

    success_count = 0
    fail_count = 0

    for f in files_to_convert:
        output_dir = Path(args.output) if args.output else f.parent
        result = convert_to_pdf(f, output_dir)
        if result:
            success_count += 1
        else:
            fail_count += 1

    print(f"\nDone: {success_count} succeeded, {fail_count} failed.")

    if fail_count > 0:
        sys.exit(1)


if __name__ == "__main__":
    main()
