# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = "/mnt/d/facultate/sda/lab/lab 1/sorted bag"

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = "/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile"

# Include any dependencies generated for this target.
include CMakeFiles/container.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/container.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/container.dir/flags.make

CMakeFiles/container.dir/SortedBag.cpp.o: CMakeFiles/container.dir/flags.make
CMakeFiles/container.dir/SortedBag.cpp.o: ../SortedBag.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/container.dir/SortedBag.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/container.dir/SortedBag.cpp.o -c "/mnt/d/facultate/sda/lab/lab 1/sorted bag/SortedBag.cpp"

CMakeFiles/container.dir/SortedBag.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/container.dir/SortedBag.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/mnt/d/facultate/sda/lab/lab 1/sorted bag/SortedBag.cpp" > CMakeFiles/container.dir/SortedBag.cpp.i

CMakeFiles/container.dir/SortedBag.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/container.dir/SortedBag.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/mnt/d/facultate/sda/lab/lab 1/sorted bag/SortedBag.cpp" -o CMakeFiles/container.dir/SortedBag.cpp.s

CMakeFiles/container.dir/SortedBagIterator.cpp.o: CMakeFiles/container.dir/flags.make
CMakeFiles/container.dir/SortedBagIterator.cpp.o: ../SortedBagIterator.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/container.dir/SortedBagIterator.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/container.dir/SortedBagIterator.cpp.o -c "/mnt/d/facultate/sda/lab/lab 1/sorted bag/SortedBagIterator.cpp"

CMakeFiles/container.dir/SortedBagIterator.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/container.dir/SortedBagIterator.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/mnt/d/facultate/sda/lab/lab 1/sorted bag/SortedBagIterator.cpp" > CMakeFiles/container.dir/SortedBagIterator.cpp.i

CMakeFiles/container.dir/SortedBagIterator.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/container.dir/SortedBagIterator.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/mnt/d/facultate/sda/lab/lab 1/sorted bag/SortedBagIterator.cpp" -o CMakeFiles/container.dir/SortedBagIterator.cpp.s

CMakeFiles/container.dir/ShortTest.cpp.o: CMakeFiles/container.dir/flags.make
CMakeFiles/container.dir/ShortTest.cpp.o: ../ShortTest.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/container.dir/ShortTest.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/container.dir/ShortTest.cpp.o -c "/mnt/d/facultate/sda/lab/lab 1/sorted bag/ShortTest.cpp"

CMakeFiles/container.dir/ShortTest.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/container.dir/ShortTest.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/mnt/d/facultate/sda/lab/lab 1/sorted bag/ShortTest.cpp" > CMakeFiles/container.dir/ShortTest.cpp.i

CMakeFiles/container.dir/ShortTest.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/container.dir/ShortTest.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/mnt/d/facultate/sda/lab/lab 1/sorted bag/ShortTest.cpp" -o CMakeFiles/container.dir/ShortTest.cpp.s

CMakeFiles/container.dir/App.cpp.o: CMakeFiles/container.dir/flags.make
CMakeFiles/container.dir/App.cpp.o: ../App.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/container.dir/App.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/container.dir/App.cpp.o -c "/mnt/d/facultate/sda/lab/lab 1/sorted bag/App.cpp"

CMakeFiles/container.dir/App.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/container.dir/App.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/mnt/d/facultate/sda/lab/lab 1/sorted bag/App.cpp" > CMakeFiles/container.dir/App.cpp.i

CMakeFiles/container.dir/App.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/container.dir/App.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/mnt/d/facultate/sda/lab/lab 1/sorted bag/App.cpp" -o CMakeFiles/container.dir/App.cpp.s

CMakeFiles/container.dir/ExtendedTest.cpp.o: CMakeFiles/container.dir/flags.make
CMakeFiles/container.dir/ExtendedTest.cpp.o: ../ExtendedTest.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir="/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/container.dir/ExtendedTest.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/container.dir/ExtendedTest.cpp.o -c "/mnt/d/facultate/sda/lab/lab 1/sorted bag/ExtendedTest.cpp"

CMakeFiles/container.dir/ExtendedTest.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/container.dir/ExtendedTest.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E "/mnt/d/facultate/sda/lab/lab 1/sorted bag/ExtendedTest.cpp" > CMakeFiles/container.dir/ExtendedTest.cpp.i

CMakeFiles/container.dir/ExtendedTest.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/container.dir/ExtendedTest.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S "/mnt/d/facultate/sda/lab/lab 1/sorted bag/ExtendedTest.cpp" -o CMakeFiles/container.dir/ExtendedTest.cpp.s

# Object files for target container
container_OBJECTS = \
"CMakeFiles/container.dir/SortedBag.cpp.o" \
"CMakeFiles/container.dir/SortedBagIterator.cpp.o" \
"CMakeFiles/container.dir/ShortTest.cpp.o" \
"CMakeFiles/container.dir/App.cpp.o" \
"CMakeFiles/container.dir/ExtendedTest.cpp.o"

# External object files for target container
container_EXTERNAL_OBJECTS =

container: CMakeFiles/container.dir/SortedBag.cpp.o
container: CMakeFiles/container.dir/SortedBagIterator.cpp.o
container: CMakeFiles/container.dir/ShortTest.cpp.o
container: CMakeFiles/container.dir/App.cpp.o
container: CMakeFiles/container.dir/ExtendedTest.cpp.o
container: CMakeFiles/container.dir/build.make
container: CMakeFiles/container.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir="/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles" --progress-num=$(CMAKE_PROGRESS_6) "Linking CXX executable container"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/container.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/container.dir/build: container

.PHONY : CMakeFiles/container.dir/build

CMakeFiles/container.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/container.dir/cmake_clean.cmake
.PHONY : CMakeFiles/container.dir/clean

CMakeFiles/container.dir/depend:
	cd "/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile" && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" "/mnt/d/facultate/sda/lab/lab 1/sorted bag" "/mnt/d/facultate/sda/lab/lab 1/sorted bag" "/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile" "/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile" "/mnt/d/facultate/sda/lab/lab 1/sorted bag/cmake-build-wsl_profile/CMakeFiles/container.dir/DependInfo.cmake" --color=$(COLOR)
.PHONY : CMakeFiles/container.dir/depend

