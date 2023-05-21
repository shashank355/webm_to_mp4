#!/bin/bashi
###############################################################
#	
#	Author        : Shashank Naidu
#	Purpose       : Convert Webm file to Mp4 
#	Supported OS  : Fedora based distributions 
#
###############################################################

# Function to check and install dependencies
check_install_dependencies() {
    missing_deps=()

    # Check if FFmpeg is installed
    if ! command -v ffmpeg &>/dev/null; then
        missing_deps+=("ffmpeg")
    fi

    # Install missing dependencies
    if [ ${#missing_deps[@]} -gt 0 ]; then
        distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
        if [[ $distro == *"Fedora"* ]] || [[ $distro == *"Red Hat"* ]]; then
            sudo yum install -y "${missing_deps[@]}"
        else
            echo "Distribution not supported"
            exit1
        fi
    fi
}

# Function to convert WebM to MP4
convert_webm_to_mp4() {
    input_file="$1"
    output_file="${input_file%.*}.mp4"

    # Convert using FFmpeg
    ffmpeg -i "$input_file" "$output_file"
}

# Main script

# Check and install dependencies
check_install_dependencies

# Prompt user for input file location
read -p "Enter the location of the WebM file to convert: " input_file

# Convert WebM to MP4
if [ -n "$input_file" ]; then
    convert_webm_to_mp4 "$input_file"
else
    echo "Usage: $0 <input_file.webm>"
    exit 1
fi
