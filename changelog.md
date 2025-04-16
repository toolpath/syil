# V1.3.0
- created Maker_macro pack and updated the post and macros to suit
- Probe operations have a post tab to add a Q1 call to display probed results at the machine.
- Milling operations have a post tab with a drop-down to select HSHP level.
- Probing arguments reworked to use the axis being measured rather than ABC ie PROBEX A54 X10
- Reworking of @ variables to avoid conflicts with stock Syil macros
- Gauge block and manual tool change locations added to PROBECONFIG
- ReadMe updated with all the above changes and additions
- assorted bug fixes  

# V1.2.3
- Updated the macro set for compatibility with post-processor Revision 44168.
- Added a wide range of user messages to provide extra control information during probing.
- Implemented support for switching between metric and freedom (imperial) units in ProbingConfig.
- Added logic to run all extended work offsets, with an option to protect any offset above a specified number.
- Implemented support for probe spin-on and spin-off M commands.
- Removed unnecessary spindle orientations to speed up probing cycles.
- Added an experimental post based on Scott Moyse's last post, featuring numerous changes and tested for compatibility with this macro set.
- Machine simulation and connection moves now display correctly in the new post—refer to the post's changelog for a full list of changes.
- Added top-level folders to simplify the setup process for new users.
- Added a helper NC file that guides new users through the process of calibrating their probe and tool setter.

# V1.2.2
- Post properties table renamed and reordered
- G30 option added to safePositionMethod()
- Tool change position added to writeToolBlock() and machine simulation details updated to allow simulation of tool change connection moves

# V1.2.1
- Updated LOADTOOL to with the ability to skip resetting tool offsets and a few minor UI changes

# V1.2.0
- Added M20 at the end of all probe routines, to unlock spindle so following M19 will actually do something 
- Improved/corrected COR macro 
- Bug fixes and docs corrections for the CALIBRATETOOLSET and TOOLSET macros 

# V1.1.2
- added docs for the FINDCOR macro

# v1.1.1
- new FINDCOR macro for 4th axis
- bug fix in docs and macro for the CALIBRATEPROBEZ macro 
- bug fix in all macros for picking extended work offsets

# v1.0.0
- Initial functional release!
