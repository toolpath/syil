import os
import sys
import re


MACRO_FILES_NAME_MAP = {
    'PROBECONFIG':800,
    'CALIBRATETOOLSET':801,
    'CALIBRATEPROBEZ':802,
    'CALIBRATEPROBERING':803,
    'CALIBRATEPROBEBLOCK':804,
    'UNLOADTOOL':805,
    'LOADTOOL':806,
    'TOOLSET':807,
    'COMPZEROPOINT':808,
    'COPYWCS':809,
    'PROTECTEDMOVE':810,
    'CHECKPOSITIONALTOLERANCE':811,
    'SAFESPIN':813,
    'PROBEX':814,
    'PROBEY':815,
    'PROBEZ':816,
    'PROBEPOCKET':820,
    'PROBERECTANGULARBOSS':821,
    'PROBEXWEB':824,
    'PROBEYWEB':825,
    'PROBEXYANGLE':827,
    'PROBEBORE':830,
    'PROBECIRCULARBOSS':831,
    'PROBEXSLOT':834,
    'PROBEYSLOT':835,
    'PROBEINSIDECORNER':837,
    'PROBEOUTSIDECORNER':839,
    'FINDCOR':840
}


MAKER_MACRO_FOLDER = 'maker_macros'
## Make sure to open a workspace with the top level folder set to "Macros for Controller" 

########################################################
# Helper functions 
########################################################

# we'll use these regex's a lot, so we want to precompile them 
# instead of building them on the fly each time
def build_regexs(name_map): 
    """
    make a precompiled regex for each macro file 
    and store it with the macro name and new number. 
    """
    regex_map = []
    for name, number in name_map.items(): 
        pattern = re.compile(r'(G65\s+")' + re.escape(name) + r'(")')
        regex_map.append((name, number, pattern))

    return regex_map


def find_all_caps_no_ext(directory="."):
    """
    Return a list of filenames in the specified directory that:
    - Have no file extension.
    - Have a name that is entirely uppercase letters.
    """
    matching_files = []
    # Loop through all entries in the directory
    for filename in os.listdir(directory):
        full_path = os.path.join(directory, filename)
        # Ensure that we're checking only files, not directories.
        if os.path.isfile(full_path):
            # Split the filename into base and extension
            base, ext = os.path.splitext(filename)
            # Check for no extension and all uppercase letters in the base name.
            if ext == "" and base and base == base.upper():
                matching_files.append(filename)
    return matching_files


########################################################
# Build the make_macro_m## files
########################################################

#empty out the maker_macro folder of any existing file

# Loop through all entries in the folder
for filename in os.listdir(MAKER_MACRO_FOLDER):
    file_path = os.path.join(MAKER_MACRO_FOLDER, filename)
    # Check if it is a file (ignoring directories)
    if os.path.isfile(file_path):
        os.remove(file_path)

MACRO_TO_MAKER_MACRO_LIST = build_regexs(MACRO_FILES_NAME_MAP)

for (file_name, file_m_number, _) in MACRO_TO_MAKER_MACRO_LIST: 
    # Read the file contents
    # print ("editing ", file_name)
    with open(file_name, 'r') as file:
        content = file.read()

    # fond all instances of G65 calls and replace with M calls
    for (name, m_number, pattern) in MACRO_TO_MAKER_MACRO_LIST:
        # Replace occurrences of the old file name with the new one
        content = pattern.sub(f'M{m_number}', content)

    # write the new maker macro file
    file_path = os.path.join(MAKER_MACRO_FOLDER, f'MAKER_MACRO_M{file_m_number}')
    with open(file_path, "w") as file:
        # print("writing ", file_path)
        file.write(content)


###################################################################
# Testing to make sure we didn't miss any files, or add extra ones
###################################################################

# Compare computed file list to the dictionary keys by converting both to sets.
computed_files_set = set(find_all_caps_no_ext())
provided_files_set = set(MACRO_FILES_NAME_MAP.keys())

macro_files_found = find_all_caps_no_ext()

# MACROS in the folder, but missing from the MAP
missing_files = computed_files_set - provided_files_set
# MACROS in the map, but missing from the folder
extra_files = provided_files_set - computed_files_set

if missing_files: 
    print('###############################################################')
    print("ERROR: The MACRO_FILES_NAME_MAP is missing the following files: ")
    for name in missing_files: 
        print('    ', name)
    print('###############################################################')
    print()
if extra_files: 
    print('###############################################################')
    print("ERROR: The MACRO_FILES_NAME_MAP has following non existent files: ")
    for name in extra_files: 
        print('    ', name)
    print('###############################################################')
    print()
# give a return code of 1 so the test fail
if (missing_files or extra_files):
    print("Self Tests Failed")
    sys.exit(1) 