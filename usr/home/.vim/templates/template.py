#!/usr/bin/env python

#!/usr/bin/env python3
import argparse

def parse_args():
    parser = argparse.ArgumentParser(
        description="Template script using argparse"
    )
    parser.add_argument(
        "-i", "--input", 
        type=str, 
        help="Input file path", 
        required=True
    )
    parser.add_argument(
        "-o", "--output", 
        type=str, 
        help="Output file path", 
        required=False
    )
    parser.add_argument(
        "-v", "--verbose", 
        action="store_true", 
        help="Enable verbose mode"
    )
    parser.add_argument(
        "--mode", 
        choices=["fast", "slow"], 
        default="fast", 
        help="Choose mode of operation"
    )
    return parser.parse_args()

def main():
    args = parse_args()

    if args.verbose:
        print("[INFO] Verbose mode is on")
        print(f"[INFO] Input file: {args.input}")
        print(f"[INFO] Output file: {args.output or 'stdout'}")
        print(f"[INFO] Mode selected: {args.mode}")

    # Example processing
    with open(args.input, 'r') as f:
        data = f.read()

    result = data.upper() if args.mode == "fast" else data.lower()

    if args.output:
        with open(args.output, 'w') as f:
            f.write(result)
    else:
        print(result)

if __name__ == "__main__":
    main()

