#!/bin/bash

# Script to install CMake 4.1.1 into AndroidIDE
# Modified version - CMake only

install_dir=$HOME
sdk_dir=$install_dir/android-sdk
cmake_dir=$sdk_dir/cmake

cmake_installed=false

download_cmake() {
    # download cmake
    cmake_version="4.1.1"
    echo "Downloading cmake-$cmake_version..."
    wget https://github.com/MrIkso/AndroidIDE-NDK/releases/download/cmake/cmake-"$cmake_version"-android-aarch64.zip --no-verbose --show-progress -N
    installing_cmake "$cmake_version"
}

installing_cmake() {
    cmake_version=$1
    cmake_file=cmake-"$cmake_version"-android-aarch64.zip
    # unzip cmake
    if [ -f "$cmake_file" ]; then
        echo "Unziping cmake..."
        unzip -qq "$cmake_file" -d "$cmake_dir"
        rm "$cmake_file"
        # set executable permission for cmake
        chmod -R +x "$cmake_dir"/"$cmake_version"/bin

        cmake_installed=true
        echo "CMake $cmake_version installed successfully!"
    else
        echo "$cmake_file does not exists."
    fi
}

echo "Installing CMake 4.1.1 for AndroidIDE..."
cd "$install_dir" || exit

# checking if previous installed cmake exists
if [ -d "$cmake_dir/4.1.1" ]; then
    echo "$cmake_dir/4.1.1 exists. Deleting old cmake..."
    rm -rf "$cmake_dir/4.1.1"
fi

if [ -d "$cmake_dir" ]; then
    cd "$cmake_dir"
    download_cmake
else
    mkdir -p "$cmake_dir"
    cd "$cmake_dir"
    download_cmake
fi

if [[ $cmake_installed == true ]]; then
    echo 'Installation Finished. CMake 4.1.1 has been installed successfully, please restart AndroidIDE!'
else
    echo 'CMake 4.1.1 installation failed!'
fi