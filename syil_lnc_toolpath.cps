/**
  Copyright (C) 2012-2024 by Autodesk, Inc.
  All rights reserved.

  Syntec post processor configuration.

  $Revision: 44145 4f7aaa6c97df2d49db23603652fb3cf23f709aa1 $
  $Date: 2024-09-19 10:09:13 $

  FORKID {78441FCF-1C1F-4D81-BFA8-AAF6F30E1F3B}
*/

description = "SYIL";
vendor = "Syil";
vendorUrl = "http://www.syil.com";
legal = "Copyright (C) 2012-2024 by Autodesk, Inc.";
certificationLevel = 2;
minimumRevision = 45917;

longDescription = "Syil LNC 6800 Post Processor with A-axis and machine simulation. Written by Scott Moyse";

extension = "nc";
programNameIsInteger = true;
setCodePage("ascii");

capabilities = CAPABILITY_MILLING | CAPABILITY_MACHINE_SIMULATION;
tolerance = spatial(0.002, MM);

minimumChordLength = spatial(0.25, MM);
minimumCircularRadius = spatial(0.01, MM);
maximumCircularRadius = spatial(1000, MM);
minimumCircularSweep = toRad(0.01);
maximumCircularSweep = toRad(180);
allowHelicalMoves = true;
allowedCircularPlanes = undefined; // allow any circular motion
highFeedrate = (unit == MM) ? 5000 : 200;

// user-defined properties
properties = {
  preloadTool: {
    title      : "Preload tool",
    description: "Preloads the next tool at a tool change (if any).",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  showSequenceNumbers: {
    title      : "Use sequence numbers",
    description: "'Yes' outputs sequence numbers on each block, 'Only on tool change' outputs sequence numbers on tool change blocks only, and 'No' disables the output of sequence numbers.",
    group      : "formats",
    type       : "enum",
    values     : [
      {title:"Yes", id:"true"},
      {title:"No", id:"false"},
      {title:"Only on tool change", id:"toolChange"}
    ],
    value: "true",
    scope: "post"
  },
  sequenceNumberStart: {
    title      : "Start sequence number",
    description: "The number at which to start the sequence numbers.",
    group      : "formats",
    type       : "integer",
    value      : 10,
    scope      : "post"
  },
  sequenceNumberIncrement: {
    title      : "Sequence number increment",
    description: "The amount by which the sequence number is incremented by in each block.",
    group      : "formats",
    type       : "integer",
    value      : 5,
    scope      : "post"
  },
  optionalStop: {
    title      : "Optional stop",
    description: "Outputs optional stop code during when necessary in the code.",
    group      : "preferences",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  separateWordsWithSpace: {
    title      : "Separate words with space",
    description: "Adds spaces between words if 'yes' is selected.",
    group      : "formats",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  allow3DArcs: {
    title      : "Allow 3D arcs",
    description: "Specifies whether 3D circular arcs are allowed.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useRadius: {
    title      : "Radius arcs",
    description: "If yes is selected, arcs are outputted using radius values rather than IJK.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  showNotes: {
    title      : "Show notes",
    description: "Writes operation notes as comments in the outputted code.",
    group      : "formats",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useSmoothing: {
    title      : "SGI / High Precision Mode",
    description: "High-Speed High-Precision Parameter.",
    group      : "preferences",
    type       : "enum",
    values     : [
      {title:"Off", id:"-1"},
      {title:"Automatic", id:"9999"},
      {title:"Fine Precision", id:"1"},
      {title:"Fine Velocity", id:"2"},
      {title:"Rough", id:"3"}
    ],
    value: "-1",
    scope: "post"
  },
  precisionLevel: {
    title      : "Machining Condition",
    description: "Users can choose the High-Speed High-Precision Parameter based on the controller HSHP configuration",
    group      : "preferences",
    type       : "enum",
    values     : [
      {title:"P1 More Corner", id:"P1"},
      {title:"P2 More Arcs", id:"P2"},
      {title:"P3 3C Product", id:"P3"},
    ],
    value: "P2",
    scope: "post"
  },
  usePitchForTapping: {
    title      : "Use pitch for tapping",
    description: "Enables the use of pitch instead of feed for the F-word in canned tapping cycles. Your CNC control must be setup for pitch mode!",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useG95: {
    title      : "Use G95",
    description: "Use IPR/MPR instead of IPM/MPM.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  safeStartAllOperations: {
    title      : "Safe start all operations",
    description: "Write optional blocks at the beginning of all operations that include all commands to start program.",
    group      : "preferences",
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  useClampCodes: {
    title      : "Use clamp codes",
    description: "Specifies whether clamp codes for rotary axes should be output. For simultaneous toolpaths rotary axes will always get unclamped.",
    group      : "multiAxis",
    type       : "boolean",
    value      : true,
    scope      : "post"
  },
  safePositionMethod: {
    title      : "Safe Retracts",
    description: "Select your desired retract option. 'Clearance Height' retracts to the operation clearance height.",
    group      : "homePositions",
    type       : "enum",
    values     : [
      {title:"G28", id:"G28"},
      {title:"G53", id:"G53"}
    ],
    value: "G28",
    scope: "post"
  },
  breakControlError: {
    title      : "Max. Break Control Error",
    description: "Maximum Allowable Error for Break Control.",
    type       : "number",
    value      : 0.05,
    scope      : "post"
  },
  ForceTCPosition: {
    title      : "Change Position Before Toolchange",
    description: "Change the machine position before executing a toolchange.",
    group      : 4,
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  TCposX: {
    title      : "Toolchange Position X Axis - Machine Coordinate",
    description: "Machine Coordinate for toolchange on X Axis.",
    group      : 4,
    type       : "number",
    value      : 0,
    scope      : "post"
  },
  TCposY: {
    title      : "Toolchange Position Y Axis - Machine Coordinate",
    description: "Machine Coordinate for toolchange on Y Axis.",
    group      : 4,
    type       : "number",
    value      : 0,
    scope      : "post"
  },
  EnableZeroPointCompensation: {
    title      : "Enable Zero Point Compensation",
    description: "Allows probing cycles to compensate for deltas bewteen a probed part and it's expected postition. The WCS after probing becomes the override origin translated by the computed deltas.",
    group      : 5,
    type       : "boolean",
    value      : false,
    scope      : "post"
  },
  CustomOnOpenGcode: {
    title      : "Custom on open G-code",
    description: "Inserts custom G-code at the beginning of the program",
    group      : 6,
    type       : "string",
    value      : "",
    scope      : "post"
  },
  CustomOnCloseGcode: {
    title      : "Custom on close G-code",
    description: "Inserts custom G-code at the end of the program",
    group      : 7,
    type       : "string",
    value      : "",
    scope      : "post"
  }
};

// wcs definiton
wcsDefinitions = {
  useZeroOffset: false,
  wcs          : [
    {name:"Standard", format:"G", range:[54, 59]},
    {name:"Extended", format:"G59.", range:[1, 106]}
  ]
};

var gFormat = createFormat({prefix:"G", minDigitsLeft:2, decimals:1});
var mFormat = createFormat({prefix:"M", minDigitsLeft:2, decimals:1});
var hFormat = createFormat({prefix:"H", minDigitsLeft:2, decimals:1});
var diameterOffsetFormat = createFormat({prefix:"D", minDigitsLeft:2, decimals:1});

var xyzFormat = createFormat({decimals:(unit == MM ? 3 : 4), type:FORMAT_REAL});
var ijkFormat = createFormat({decimals:6, type:FORMAT_REAL}); // unitless
var rFormat = xyzFormat; // radius
var abcFormat = createFormat({decimals:3, type:FORMAT_REAL, scale:DEG});
var feedFormat = createFormat({decimals:(unit == MM ? 0 : 1), type:FORMAT_REAL});
var inverseTimeFormat = createFormat({decimals:3, type:FORMAT_REAL});
var pitchFormat = createFormat({decimals:(unit == MM ? 3 : 4), type:FORMAT_REAL});
var toolFormat = createFormat({decimals:0});
var rpmFormat = createFormat({decimals:0});
var secFormat = createFormat({decimals:3, type:FORMAT_REAL}); // seconds - range 0.001-99999.999
var milliFormat = createFormat({decimals:0}); // milliseconds // range 1-9999
var taperFormat = createFormat({decimals:1, scale:DEG});
var oFormat = createFormat({minDigitsLeft:4, decimals:0});
var peckFormat = createFormat({decimals:(unit == MM ? 3 : 4), type:FORMAT_REAL});
// var peckFormat = createFormat({decimals:0, type:FORMAT_LZS, minDigitsLeft:4, scale:(unit == MM ? 1000 : 10000)});

var xOutput = createOutputVariable({onchange:function() {state.retractedX = false;}, prefix:"X"}, xyzFormat);
var yOutput = createOutputVariable({onchange:function() {state.retractedY = false;}, prefix:"Y"}, xyzFormat);
var zOutput = createOutputVariable({onchange:function() {state.retractedZ = false;}, prefix:"Z"}, xyzFormat);
var toolVectorOutputI = createOutputVariable({prefix:"I", control:CONTROL_FORCE}, ijkFormat);
var toolVectorOutputJ = createOutputVariable({prefix:"J", control:CONTROL_FORCE}, ijkFormat);
var toolVectorOutputK = createOutputVariable({prefix:"K", control:CONTROL_FORCE}, ijkFormat);
var aOutput = createOutputVariable({prefix:"A"}, abcFormat);
var bOutput = createOutputVariable({prefix:"B"}, abcFormat);
var cOutput = createOutputVariable({prefix:"C"}, abcFormat);
var feedOutput = createOutputVariable({prefix:"F"}, feedFormat);
var inverseTimeOutput = createOutputVariable({prefix:"F", control:CONTROL_FORCE}, inverseTimeFormat);
var pitchOutput = createOutputVariable({prefix:"F", control:CONTROL_FORCE}, pitchFormat);
var sOutput = createOutputVariable({prefix:"S", control:CONTROL_FORCE}, rpmFormat);
var peckOutput = createOutputVariable({prefix:"Q", control:CONTROL_FORCE}, peckFormat);

// circular output
var iOutput = createOutputVariable({prefix:"I", control:CONTROL_NONZERO}, xyzFormat);
var jOutput = createOutputVariable({prefix:"J", control:CONTROL_NONZERO}, xyzFormat);
var kOutput = createOutputVariable({prefix:"K", control:CONTROL_NONZERO}, xyzFormat);

var gMotionModal = createOutputVariable({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createOutputVariable({onchange:function () {gMotionModal.reset();}}, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createOutputVariable({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createOutputVariable({}, gFormat); // modal group 5 // G94-95
var gUnitModal = createOutputVariable({}, gFormat); // modal group 6 // G70-71
var gCycleModal = createOutputVariable({}, gFormat); // modal group 9 // G81, ...
var gRetractModal = createOutputVariable({}, gFormat); // modal group 10 // G98-99
var fourthAxisClamp = createOutputVariable({}, mFormat);
var fifthAxisClamp = createOutputVariable({}, mFormat);

var settings = {
  coolant: {
    // samples:
    // {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
    // {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
    // {id: COOLANT_THROUGH_TOOL, on: "M88 P3 (myComment)", off: "M89"}
    coolants: [
      {id:COOLANT_FLOOD, on:8},
      {id:COOLANT_MIST},
      {id:COOLANT_THROUGH_TOOL, on:88, off:89},
      {id:COOLANT_AIR, on:7},
      {id:COOLANT_AIR_THROUGH_TOOL},
      {id:COOLANT_SUCTION},
      {id:COOLANT_FLOOD_MIST},
      {id:COOLANT_FLOOD_THROUGH_TOOL, on:[8, 88], off:[9, 89]},
      {id:COOLANT_OFF, off:9}
    ],
    singleLineCoolant: false, // specifies to output multiple coolant codes in one line rather than in separate lines
  },
  smoothing: {
    roughing              : 3, // roughing level for smoothing in automatic mode
    semi                  : 2, // semi-roughing level for smoothing in automatic mode
    semifinishing         : 2, // semi-finishing level for smoothing in automatic mode
    finishing             : 1, // finishing level for smoothing in automatic mode
    thresholdRoughing     : toPreciseUnit(0.5, MM), // operations with stock/tolerance above that threshold will use roughing level in automatic mode
    thresholdFinishing    : toPreciseUnit(0.05, MM), // operations with stock/tolerance below that threshold will use finishing level in automatic mode
    thresholdSemiFinishing: toPreciseUnit(0.1, MM), // operations with stock/tolerance above finishing and below threshold roughing that threshold will use semi finishing level in automatic mode

    differenceCriteria: "level", // options: "level", "tolerance", "both". Specifies criteria when output smoothing codes
    autoLevelCriteria : "stock", // use "stock" or "tolerance" to determine levels in automatic mode
    cancelCompensation: false // tool length compensation must be canceled prior to changing the smoothing level
  },
  retract: {
    cancelRotationOnRetracting: false, // specifies that rotations (G68) need to be canceled prior to retracting
    methodXY                  : undefined, // special condition, overwrite retract behavior per axis
    methodZ                   : undefined, // special condition, overwrite retract behavior per axis
    useZeroValues             : ["G28", "G30"], // enter property value id(s) for using "0" value instead of machineConfiguration axes home position values (ie G30 Z0)
    homeXY                    : {onIndexing:false, onToolChange:false, onProgramEnd:{axes:[X, Y]}} // Specifies when the machine should be homed in X/Y. Sample: onIndexing:{axes:[X, Y], singleLine:false}
  },
  parametricFeeds: {
    firstFeedParameter    : 500, // specifies the initial parameter number to be used for parametric feedrate output
    feedAssignmentVariable: "#", // specifies the syntax to define a parameter
    feedOutputVariable    : "F#" // specifies the syntax to output the feedrate as parameter
  },
  machineAngles: { // refer to https://cam.autodesk.com/posts/reference/classMachineConfiguration.html#a14bcc7550639c482492b4ad05b1580c8
    controllingAxis: ABC,
    type           : PREFER_PREFERENCE,
    options        : ENABLE_ALL
  },
  workPlaneMethod: {
    useTiltedWorkplane    : true, // specifies that tilted workplanes should be used (ie. G68.2, G254, PLANE SPATIAL, CYCLE800), can be overwritten by property
    eulerConvention       : EULER_ZXZ_R, // specifies the euler convention (ie EULER_XYZ_R), set to undefined to use machine angles for TWP commands ('undefined' requires machine configuration)
    eulerCalculationMethod: "standard", // ('standard' / 'machine') 'machine' adjusts euler angles to match the machines ABC orientation, machine configuration required
    cancelTiltFirst       : true, // cancel tilted workplane prior to WCS (G54-G59) blocks
    useABCPrepositioning  : true, // position ABC axes prior to tilted workplane blocks
    forceMultiAxisIndexing: false, // force multi-axis indexing for 3D programs
    optimizeType          : undefined // can be set to OPTIMIZE_NONE, OPTIMIZE_BOTH, OPTIMIZE_TABLES, OPTIMIZE_HEADS, OPTIMIZE_AXIS. 'undefined' uses legacy rotations
  },
  subprograms: {
    initialSubprogramNumber: 9001, // specifies the initial number to be used for subprograms. 'undefined' uses the main program number
    minimumCyclePoints     : 5, // minimum number of points in cycle operation to consider for subprogram
    format                 : oFormat, // the format to use for the subprogam number format
    // objects below also accept strings with "%currentSubprogram" as placeholder. Sample: {files:["%"], embedded:"N" + "%currentSubprogram"}
    files                  : {extension:extension, prefix:undefined}, // specifies the subprogram file extension and the prefix to use for the generated file
    startBlock             : {files:["%" + EOL + "O"], embedded:["N"]}, // specifies the start syntax of a subprogram followed by the subprogram number
    endBlock               : {files:[mFormat.format(99) + EOL + "%"], embedded:[mFormat.format(99)]}, // specifies the command to for the end of a subprogram
    callBlock              : {files:[mFormat.format(98) + " H"], embedded:[mFormat.format(98) + " H"]} // specifies the command for calling a subprogram followed by the subprogram number
  },
  comments: {
    permittedCommentChars: " abcdefghijklmnopqrstuvwxyz0123456789.,=_-:", // letters are not case sensitive, use option 'outputFormat' below. Set to 'undefined' to allow any character
    prefix               : "(", // specifies the prefix for the comment
    suffix               : ")", // specifies the suffix for the comment
    outputFormat         : "upperCase", // can be set to "upperCase", "lowerCase" and "ignoreCase". Set to "ignoreCase" to write comments without upper/lower case formatting
    maximumLineLength    : 80 // the maximum number of characters allowed in a line, set to 0 to disable comment output
  },
  probing: {
    macroCall              : gFormat.format(65), // specifies the command to call a macro
    probeAngleMethod       : undefined, // supported options are: OFF, AXIS_ROT, G68, G54.4. 'undefined' uses automatic selection
    probeAngleVariables    : {x:"#135", y:"#136", z:0, i:0, j:0, k:1, r:"#144", baseParamG54x4:26000, baseParamAxisRot:5200, method:0}, // specifies variables for the angle compensation macros, method 0 = Fanuc, 1 = Haas
    allowIndexingWCSProbing: false // specifies that probe WCS with tool orientation is supported
  },
  maximumSequenceNumber         : undefined, // the maximum sequence number (Nxxx), use 'undefined' for unlimited
  supportsToolVectorOutput      : true, // specifies if the control does support tool axis vector output for multi axis toolpath
  allowCancelTCPBeforeRetracting: true, // allows TCP/tool length compensation to be canceled prior retracting. Warning, ensure machine parameters 5006.6(Fanuc)/F114 bit 1(Mazak) are set to prevent axis motion when cancelling compensation.
  maximumToolLengthOffset       : 199,
  maximumToolDiameterOffset     : 199
};

function onOpen() {
  // define and enable machine configuration
  receivedMachineConfiguration = machineConfiguration.isReceived();
  if (typeof defineMachine == "function") {
    defineMachine(); // hardcoded machine configuration
  }
  activateMachine();

  // postprocessor/machine specific requirements
  if (getProperty("useRadius")) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }
  if (getProperty("safePositionMethod") == "G53" && (!machineConfiguration.hasHomePositionX() || !machineConfiguration.hasHomePositionY())) {
    settings.retract.methodXY = "G28";
  }

  // initialize formats
  gRotationModal.format(69); // Default to G69 Rotation Off

  if (!getProperty("separateWordsWithSpace")) {
    setWordSeparator("");
  }

  if (getProperty("useG95")) {
    if (getProperty("useParametricFeed")) {
      error(localize("Parametric feed is not supported when using G95."));
      return;
    }
    feedFormat = createFormat({decimals:(unit == MM ? 4 : 5), type:FORMAT_REAL});
    feedOutput.setFormat(feedFormat);
  }

  writeln("%");
  if (Number.isInteger(programName)) {
    writeln("O" + oFormat.format(getProgramNumber()) + conditional(programComment, " " + formatComment(programComment)));
  } else {
    writeComment(programName);
  }
  writeProgramHeader();

  // absolute coordinates and feed per min
  writeBlock(gAbsIncModal.format(90), gFeedModeModal.format(getProperty("useG95") ? 95 : 94), gPlaneModal.format(17), toolLengthCompOutput.format(49), gFormat.format(40), gFormat.format(80));
  writeBlock(gUnitModal.format(unit == MM ? 71 : 70));
  validateCommonParameters();

  // Save the G59 Z axis into a variable #199 for use with G10 calls
  writeComment("G59 stores the zero point. #199 can be used with G10 commands to pull G59 into a local WCS");
  writeBlock("#199 = R_G53G59_COOR[0,59,3]");
  writeBlock("@980 = TIME[3]"); //month
  writeBlock("@981 = TIME[4]"); //day
  writeBlock("@982 = TIME[2]"); //year
  writeBlock("@983 = TIME[5]"); //hour
  writeBlock("@984 = TIME[6]"); //minute
  writeBlock("@985 = TIME[7]"); //second
  writeBlock(getProperty("CustomOnOpenGcode"));
}

function setSmoothing(mode) {
  smoothingSettings = settings.smoothing;
  if (mode == smoothing.isActive && (!mode || !smoothing.isDifferent) && !smoothing.force) {
    return; // return if smoothing is already active or is not different
  }
  if (validateLengthCompensation && smoothingSettings.cancelCompensation) {
    validate(!state.lengthCompensationActive, "Length compensation is active while trying to update smoothing.");
  }
  if (mode) { // enable smoothing
    writeBlock(gFormat.format(120.1), getProperty("precisionLevel"), "Q" + smoothing.level);
  } else { // disable smoothing
    writeBlock(gFormat.format(121));
  }
  smoothing.isActive = mode;
  smoothing.force = false;
  smoothing.isDifferent = false;
}

function onSection() {
  var forceSectionRestart = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();
  var insertToolCall = isToolChangeNeeded("number") || forceSectionRestart;
  var newWorkOffset = isNewWorkOffset() || forceSectionRestart;
  var newWorkPlane = isNewWorkPlane() || forceSectionRestart;
  operationNeedsSafeStart = getProperty("safeStartAllOperations") && !isFirstSection();
  initializeSmoothing(); // initialize smoothing mode

  if (insertToolCall || newWorkOffset || newWorkPlane || smoothing.cancel || state.tcpIsActive) {

    // stop spindle before retract during tool change
    if (insertToolCall && !isFirstSection()) {
      onCommand(COMMAND_STOP_SPINDLE);
    }
    disableLengthCompensation();
    if (getSetting("workPlaneMethod.cancelTiltFirst", false)) {
      cancelWorkPlane();
    }
    writeRetract(Z); // retract
    if (isFirstSection() && machineConfiguration.isMultiAxisConfiguration()) {
      setWorkPlane(new Vector(0, 0, 0)); // reset working plane
      forceABC();
    }
    forceXYZ();
    if (!isFirstSection() && (insertToolCall || smoothing.cancel || state.tcpIsActive)) {
      disableLengthCompensation();
      if (smoothing.cancel || insertToolCall) {
        setSmoothing(false);
      }
    }
  }

  writeln("");
  writeComment(getParameter("operation-comment", ""));

  if (getProperty("showNotes")) {
    writeSectionNotes();
  }

  // tool change
  writeToolCall(tool, insertToolCall);
  startSpindle(tool, insertToolCall);

  // write parametric feedrate table
  if (typeof initializeParametricFeeds == "function") {
    initializeParametricFeeds(insertToolCall);
  }
  // Output modal commands here
  writeBlock(gPlaneModal.format(17), gAbsIncModal.format(90), gFeedModeModal.format(getProperty("useG95") ? 95 : 94));

  // set wcs
  var wcsIsRequired = true;
  if (insertToolCall || operationNeedsSafeStart) {
    currentWorkOffset = undefined; // force work offset when changing tool
    wcsIsRequired = newWorkOffset || insertToolCall || !operationNeedsSafeStart;
  }
  writeWCS(currentSection, wcsIsRequired);

  forceXYZ();

  onCommand(COMMAND_START_CHIP_TRANSPORT);

  var abc = defineWorkPlane(currentSection, true);

  setCoolant(tool.coolant); // writes the required coolant codes

  setSmoothing(smoothing.isAllowed); // writes the required smoothing codes

  // prepositioning
  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  var isRequired = insertToolCall || state.retractedZ || !state.lengthCompensationActive  || (!isFirstSection() && getPreviousSection().isMultiAxis());
  writeInitialPositioning(initialPosition, isRequired);

  if (subprogramsAreSupported()) {
    subprogramDefine(initialPosition, abc); // define subprogram
  }
  state.retractedZ = false;
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  milliseconds = clamp(1, seconds * 1000, 99999999);
  writeBlock(gFeedModeModal.format(94), gFormat.format(4), "P" + milliFormat.format(milliseconds));
  writeBlock(gFeedModeModal.format(getProperty("useG95") ? 95 : 94)); // back to G95
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(sOutput.format(spindleSpeed));
}

function onCycle() {
  writeBlock(gPlaneModal.format(17));
}

function onCyclePoint(x, y, z) {
  if (isInspectionOperation()) {
    if (typeof inspectionCycleInspect == "function") {
      inspectionCycleInspect(cycle, x, y, z);
      return;
    } else {
      cycleNotSupported();
    }
  } else if (isProbeOperation()) {
    writeProbeCycle(cycle, x, y, z);
  } else {
    properties.useRigidTapping = {current:"no"}; // TAG: required to include common Fanuc cycles
    writeDrillCycle(cycle, x, y, z);
  }
}

function onCycleEnd() {
  if (subprogramsAreSupported() && subprogramState.cycleSubprogramIsActive) {
    subprogramEnd();
  }
  if (!cycleExpanded) {
    writeBlock(gFeedModeModal.format(getProperty("useG95") ? 95 : 94), gCycleModal.format(80));
    zOutput.reset();
  }
}

var mapCommand = {
  COMMAND_END                     : 2,
  COMMAND_SPINDLE_CLOCKWISE       : 3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE: 4,
  COMMAND_STOP_SPINDLE            : 5,
  COMMAND_ORIENTATE_SPINDLE       : 19
};

function onCommand(command) {
  switch (command) {
  case COMMAND_COOLANT_OFF:
    setCoolant(COOLANT_OFF);
    return;
  case COMMAND_COOLANT_ON:
    setCoolant(tool.coolant);
    return;
  case COMMAND_STOP:
    writeBlock(mFormat.format(0));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_OPTIONAL_STOP:
    writeBlock(mFormat.format(1));
    forceSpindleSpeed = true;
    forceCoolant = true;
    return;
  case COMMAND_START_SPINDLE:
    forceSpindleSpeed = false;
    writeBlock(sOutput.format(spindleSpeed), mFormat.format(tool.clockwise ? 3 : 4));
    return;
  case COMMAND_LOAD_TOOL:
    writeToolBlock("T" + toolFormat.format(tool.number), mFormat.format(6));
    writeComment(tool.comment);

    var preloadTool = getNextTool(tool.number != getFirstTool().number);
    if (getProperty("preloadTool") && preloadTool) {
      writeBlock("T" + toolFormat.format(preloadTool.number)); // preload next/first tool
    }
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    var outputClampCodes = getProperty("useClampCodes") || currentSection.isMultiAxis();
    if (outputClampCodes && machineConfiguration.isMultiAxisConfiguration()) {
      writeBlock(fourthAxisClamp.format(10), conditional(machineConfiguration.getNumberOfAxes() > 4, fifthAxisClamp.format(110))); // lock 4th + 5th axis
    }
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    var outputClampCodes = getProperty("useClampCodes") || currentSection.isMultiAxis();
    if (outputClampCodes && machineConfiguration.isMultiAxisConfiguration()) {
      writeBlock(fourthAxisClamp.format(11), conditional(machineConfiguration.getNumberOfAxes() > 4, fifthAxisClamp.format(111))); // unlock 4th + 5th axis
    }
    return;
  case COMMAND_START_CHIP_TRANSPORT:
    return;
  case COMMAND_STOP_CHIP_TRANSPORT:
    return;
  case COMMAND_BREAK_CONTROL:
    return;
  case COMMAND_TOOL_MEASURE:
    return;
  case COMMAND_PROBE_ON:
    return;
  case COMMAND_PROBE_OFF:
    return;
  }

  var stringId = getCommandStringId(command);
  var mcode = mapCommand[stringId];
  if (mcode != undefined) {
    writeBlock(mFormat.format(mcode));
  } else {
    onUnsupportedCommand(command);
  }
}

function onSectionEnd() {
  if (currentSection.isMultiAxis()) {
    writeBlock(gFeedModeModal.format(getProperty("useG95") ? 95 : 94)); // inverse time feed off
  }
  writeBlock(gPlaneModal.format(17));

  if (!isLastSection()) {
    if (getNextSection().getTool().coolant != tool.coolant) {
      setCoolant(COOLANT_OFF);
    }
    if (tool.breakControl && isToolChangeNeeded(getNextSection(), getProperty("toolAsName") ? "description" : "number")) {
      onCommand(COMMAND_BREAK_CONTROL);
    }
  }

  if (subprogramsAreSupported()) {
    subprogramEnd();
  }

  forceAny();

  operationNeedsSafeStart = false; // reset for next section
}

// Start of onRewindMachine logic
/** Allow user to override the onRewind logic. */
function onRewindMachineEntry(_a, _b, _c) {
  return false;
}

/** Retract to safe position before indexing rotaries. */
function onMoveToSafeRetractPosition() {
  writeRetract(Z);
  // cancel TCP so that tool doesn't follow rotaries
  if (currentSection.isMultiAxis() && tcp.isSupportedByOperation) {
    disableLengthCompensation(false, "TCPC OFF");
  }
}

/** Rotate axes to new position above reentry position */
function onRotateAxes(_x, _y, _z, _a, _b, _c) {
  // position rotary axes
  xOutput.disable();
  yOutput.disable();
  zOutput.disable();
  onRapid5D(_x, _y, _z, _a, _b, _c);
  setCurrentABC(new Vector(_a, _b, _c));
  machineSimulation({a:_a, b:_b, c:_c, coordinates:MACHINE});
  xOutput.enable();
  yOutput.enable();
  zOutput.enable();
}

/** Return from safe position after indexing rotaries. */
function onReturnFromSafeRetractPosition(_x, _y, _z) {
  // reinstate TCP / tool length compensation
  if (!state.lengthCompensationActive) {
    writeBlock(getOffsetCode(), hFormat.format(tool.lengthOffset));
  }

  // position in XY
  forceXYZ();
  xOutput.reset();
  yOutput.reset();
  zOutput.disable();
  if (highFeedMapping != HIGH_FEED_NO_MAPPING) {
    onLinear(_x, _y, _z, highFeedrate);
  } else {
    onRapid(_x, _y, _z);
  }
  machineSimulation({x:_x, y:_y});
  // position in Z
  zOutput.enable();
  invokeOnRapid(_x, _y, _z);
}
// End of onRewindMachine logic

function onClose() {
  optionalSection = false;
  writeln("");
  onCommand(COMMAND_STOP_SPINDLE);
  onCommand(COMMAND_COOLANT_OFF);
  disableLengthCompensation(true);
  cancelWorkPlane();
  writeRetract(Z); // retract
  setSmoothing(false);
  forceWorkPlane();
  setWorkPlane(new Vector(0, 0, 0)); // reset working plane
  if (getSetting("retract.homeXY.onProgramEnd", false)) {
    writeRetract(settings.retract.homeXY.onProgramEnd);
  }
  writeBlock(mFormat.format(30)); // program end

  if (subprogramsAreSupported()) {
    writeSubprograms();
  }
  writeln("%");
  writeBlock(getProperty("CustomOnCloseGcode"));
}

// >>>>> INCLUDED FROM include_files/commonFunctions.cpi
// internal variables, do not change
var receivedMachineConfiguration;
var tcp = {isSupportedByControl:getSetting("supportsTCP", true), isSupportedByMachine:false, isSupportedByOperation:false};
var state = {
  retractedX              : false, // specifies that the machine has been retracted in X
  retractedY              : false, // specifies that the machine has been retracted in Y
  retractedZ              : false, // specifies that the machine has been retracted in Z
  tcpIsActive             : false, // specifies that TCP is currently active
  twpIsActive             : false, // specifies that TWP is currently active
  lengthCompensationActive: !getSetting("outputToolLengthCompensation", true), // specifies that tool length compensation is active
  mainState               : true // specifies the current context of the state (true = main, false = optional)
};
var validateLengthCompensation = getSetting("outputToolLengthCompensation", true); // disable validation when outputToolLengthCompensation is disabled
var multiAxisFeedrate;
var sequenceNumber;
var optionalSection = false;
var currentWorkOffset;
var forceSpindleSpeed = false;
var operationNeedsSafeStart = false; // used to convert blocks to optional for safeStartAllOperations

function activateMachine() {
  // disable unsupported rotary axes output
  if (!machineConfiguration.isMachineCoordinate(0) && (typeof aOutput != "undefined")) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1) && (typeof bOutput != "undefined")) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2) && (typeof cOutput != "undefined")) {
    cOutput.disable();
  }

  // setup usage of useTiltedWorkplane
  settings.workPlaneMethod.useTiltedWorkplane = getProperty("useTiltedWorkplane") != undefined ? getProperty("useTiltedWorkplane") :
    getSetting("workPlaneMethod.useTiltedWorkplane", false);
  settings.workPlaneMethod.useABCPrepositioning = getProperty("useABCPrepositioning") != undefined ? getProperty("useABCPrepositioning") :
    getSetting("workPlaneMethod.useABCPrepositioning", false);

  if (!machineConfiguration.isMultiAxisConfiguration()) {
    return; // don't need to modify any settings for 3-axis machines
  }

  // identify if any of the rotary axes has TCP enabled
  var axes = [machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW()];
  tcp.isSupportedByMachine = axes.some(function(axis) {return axis.isEnabled() && axis.isTCPEnabled();}); // true if TCP is enabled on any rotary axis

  // save multi-axis feedrate settings from machine configuration
  var mode = machineConfiguration.getMultiAxisFeedrateMode();
  var type = mode == FEED_INVERSE_TIME ? machineConfiguration.getMultiAxisFeedrateInverseTimeUnits() :
    (mode == FEED_DPM ? machineConfiguration.getMultiAxisFeedrateDPMType() : DPM_STANDARD);
  multiAxisFeedrate = {
    mode     : mode,
    maximum  : machineConfiguration.getMultiAxisFeedrateMaximum(),
    type     : type,
    tolerance: mode == FEED_DPM ? machineConfiguration.getMultiAxisFeedrateOutputTolerance() : 0,
    bpwRatio : mode == FEED_DPM ? machineConfiguration.getMultiAxisFeedrateBpwRatio() : 1
  };

  // setup of retract/reconfigure  TAG: Only needed until post kernel supports these machine config settings
  if (receivedMachineConfiguration && machineConfiguration.performRewinds()) {
    safeRetractDistance = machineConfiguration.getSafeRetractDistance();
    safePlungeFeed = machineConfiguration.getSafePlungeFeedrate();
    safeRetractFeed = machineConfiguration.getSafeRetractFeedrate();
  }
  if (typeof safeRetractDistance == "number" && getProperty("safeRetractDistance") != undefined && getProperty("safeRetractDistance") != 0) {
    safeRetractDistance = getProperty("safeRetractDistance");
  }

  if (machineConfiguration.isHeadConfiguration()) {
    compensateToolLength = typeof compensateToolLength == "undefined" ? false : compensateToolLength;
  }

  if (machineConfiguration.isHeadConfiguration() && compensateToolLength) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var section = getSection(i);
      if (section.isMultiAxis()) {
        machineConfiguration.setToolLength(getBodyLength(section.getTool())); // define the tool length for head adjustments
        section.optimizeMachineAnglesByMachine(machineConfiguration, OPTIMIZE_AXIS);
      }
    }
  } else {
    optimizeMachineAngles2(OPTIMIZE_AXIS);
  }
}

function getBodyLength(tool) {
  for (var i = 0; i < getNumberOfSections(); ++i) {
    var section = getSection(i);
    if (tool.number == section.getTool().number) {
      return section.getParameter("operation:tool_overallLength", tool.bodyLength + tool.holderLength);
    }
  }
  return tool.bodyLength + tool.holderLength;
}

function getFeed(f) {
  if (getProperty("useG95")) {
    return feedOutput.format(f / spindleSpeed); // use feed value
  }
  if (typeof activeMovements != "undefined" && activeMovements) {
    var feedContext = activeMovements[movement];
    if (feedContext != undefined) {
      if (!feedFormat.areDifferent(feedContext.feed, f)) {
        if (feedContext.id == currentFeedId) {
          return ""; // nothing has changed
        }
        forceFeed();
        currentFeedId = feedContext.id;
        return settings.parametricFeeds.feedOutputVariable + (settings.parametricFeeds.firstFeedParameter + feedContext.id);
      }
    }
    currentFeedId = undefined; // force parametric feed next time
  }
  return feedOutput.format(f); // use feed value
}

function validateCommonParameters() {
  validateToolData();
  for (var i = 0; i < getNumberOfSections(); ++i) {
    var section = getSection(i);
    if (getSection(0).workOffset == 0 && section.workOffset > 0) {
      if (!(typeof wcsDefinitions != "undefined" && wcsDefinitions.useZeroOffset)) {
        error(localize("Using multiple work offsets is not possible if the initial work offset is 0."));
      }
    }
    if (section.isMultiAxis()) {
      if (!section.isOptimizedForMachine() &&
        (!getSetting("workPlaneMethod.useTiltedWorkplane", false) || !getSetting("supportsToolVectorOutput", false))) {
        error(localize("This postprocessor requires a machine configuration for 5-axis simultaneous toolpath."));
      }
      if (machineConfiguration.getMultiAxisFeedrateMode() == FEED_INVERSE_TIME && !getSetting("supportsInverseTimeFeed", true)) {
        error(localize("This postprocessor does not support inverse time feedrates."));
      }
      if (getSetting("supportsToolVectorOutput", false) && !tcp.isSupportedByControl) {
        error(localize("Incompatible postprocessor settings detected." + EOL +
        "Setting 'supportsToolVectorOutput' requires setting 'supportsTCP' to be enabled as well."));
      }
    }
  }
  if (!tcp.isSupportedByControl && tcp.isSupportedByMachine) {
    error(localize("The machine configuration has TCP enabled which is not supported by this postprocessor."));
  }
  if (getProperty("safePositionMethod") == "clearanceHeight") {
    var msg = "-Attention- Property 'Safe Retracts' is set to 'Clearance Height'." + EOL +
      "Ensure the clearance height will clear the part and or fixtures." + EOL +
      "Raise the Z-axis to a safe height before starting the program.";
    warning(msg);
    writeComment(msg);
  }
}

function validateToolData() {
  var _default = 99999;
  var _maximumSpindleRPM = machineConfiguration.getMaximumSpindleSpeed() > 0 ? machineConfiguration.getMaximumSpindleSpeed() :
    settings.maximumSpindleRPM == undefined ? _default : settings.maximumSpindleRPM;
  var _maximumToolNumber = machineConfiguration.isReceived() && machineConfiguration.getNumberOfTools() > 0 ? machineConfiguration.getNumberOfTools() :
    settings.maximumToolNumber == undefined ? _default : settings.maximumToolNumber;
  var _maximumToolLengthOffset = settings.maximumToolLengthOffset == undefined ? _default : settings.maximumToolLengthOffset;
  var _maximumToolDiameterOffset = settings.maximumToolDiameterOffset == undefined ? _default : settings.maximumToolDiameterOffset;

  var header = ["Detected maximum values are out of range.", "Maximum values:"];
  var warnings = {
    toolNumber    : {msg:"Tool number value exceeds the maximum value for tool: " + EOL, max:" Tool number: " + _maximumToolNumber, values:[]},
    lengthOffset  : {msg:"Tool length offset value exceeds the maximum value for tool: " + EOL, max:" Tool length offset: " + _maximumToolLengthOffset, values:[]},
    diameterOffset: {msg:"Tool diameter offset value exceeds the maximum value for tool: " + EOL, max:" Tool diameter offset: " + _maximumToolDiameterOffset, values:[]},
    spindleSpeed  : {msg:"Spindle speed exceeds the maximum value for operation: " + EOL, max:" Spindle speed: " + _maximumSpindleRPM, values:[]}
  };

  var toolIds = [];
  for (var i = 0; i < getNumberOfSections(); ++i) {
    var section = getSection(i);
    if (toolIds.indexOf(section.getTool().getToolId()) === -1) { // loops only through sections which have a different tool ID
      var toolNumber = section.getTool().number;
      var lengthOffset = section.getTool().lengthOffset;
      var diameterOffset = section.getTool().diameterOffset;
      var comment = section.getParameter("operation-comment", "");

      if (toolNumber > _maximumToolNumber && !getProperty("toolAsName")) {
        warnings.toolNumber.values.push(SP + toolNumber + EOL);
      }
      if (lengthOffset > _maximumToolLengthOffset) {
        warnings.lengthOffset.values.push(SP + "Tool " + toolNumber + " (" + comment + "," + " Length offset: " + lengthOffset + ")" + EOL);
      }
      if (diameterOffset > _maximumToolDiameterOffset) {
        warnings.diameterOffset.values.push(SP + "Tool " + toolNumber + " (" + comment + "," + " Diameter offset: " + diameterOffset + ")" + EOL);
      }
      toolIds.push(section.getTool().getToolId());
    }
    // loop through all sections regardless of tool id for idenitfying spindle speeds

    // identify if movement ramp is used in current toolpath, use ramp spindle speed for comparisons
    var ramp = section.getMovements() & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_ZIG_ZAG) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_HELIX));
    var _sectionSpindleSpeed = Math.max(section.getTool().spindleRPM, ramp ? section.getTool().rampingSpindleRPM : 0, 0);
    if (_sectionSpindleSpeed > _maximumSpindleRPM) {
      warnings.spindleSpeed.values.push(SP + section.getParameter("operation-comment", "") + " (" + _sectionSpindleSpeed + " RPM" + ")" + EOL);
    }
  }

  // sort lists by tool number
  warnings.toolNumber.values.sort(function(a, b) {return a - b;});
  warnings.lengthOffset.values.sort(function(a, b) {return a.localeCompare(b);});
  warnings.diameterOffset.values.sort(function(a, b) {return a.localeCompare(b);});

  var warningMessages = [];
  for (var key in warnings) {
    if (warnings[key].values != "") {
      header.push(warnings[key].max); // add affected max values to the header
      warningMessages.push(warnings[key].msg + warnings[key].values.join(""));
    }
  }
  if (warningMessages.length != 0) {
    warningMessages.unshift(header.join(EOL) + EOL);
    warning(warningMessages.join(EOL));
  }
}

function forceFeed() {
  currentFeedId = undefined;
  feedOutput.reset();
}

/** Force output of X, Y, and Z. */
function forceXYZ() {
  xOutput.reset();
  yOutput.reset();
  zOutput.reset();
}

/** Force output of A, B, and C. */
function forceABC() {
  aOutput.reset();
  bOutput.reset();
  cOutput.reset();
}

/** Force output of X, Y, Z, A, B, C, and F on next output. */
function forceAny() {
  forceXYZ();
  forceABC();
  forceFeed();
}

/**
  Writes the specified block.
*/
function writeBlock() {
  var text = formatWords(arguments);
  if (!text) {
    return;
  }
  var prefix = getSetting("sequenceNumberPrefix", "N");
  var suffix = getSetting("writeBlockSuffix", "");
  if ((optionalSection || skipBlocks) && !getSetting("supportsOptionalBlocks", true)) {
    error(localize("Optional blocks are not supported by this post."));
  }
  if (getProperty("showSequenceNumbers") == "true") {
    if (sequenceNumber == undefined || sequenceNumber >= settings.maximumSequenceNumber) {
      sequenceNumber = getProperty("sequenceNumberStart");
    }
    if (optionalSection || skipBlocks) {
      writeWords2("/", prefix + sequenceNumber, text + suffix);
    } else {
      writeWords2(prefix + sequenceNumber, text + suffix);
    }
    sequenceNumber += getProperty("sequenceNumberIncrement");
  } else {
    if (optionalSection || skipBlocks) {
      writeWords2("/", text + suffix);
    } else {
      writeWords(text + suffix);
    }
  }
}

validate(settings.comments, "Setting 'comments' is required but not defined.");
function formatComment(text) {
  var prefix = settings.comments.prefix;
  var suffix = settings.comments.suffix;
  var _permittedCommentChars = settings.comments.permittedCommentChars == undefined ? "" : settings.comments.permittedCommentChars;
  switch (settings.comments.outputFormat) {
  case "upperCase":
    text = text.toUpperCase();
    _permittedCommentChars = _permittedCommentChars.toUpperCase();
    break;
  case "lowerCase":
    text = text.toLowerCase();
    _permittedCommentChars = _permittedCommentChars.toLowerCase();
    break;
  case "ignoreCase":
    _permittedCommentChars = _permittedCommentChars.toUpperCase() + _permittedCommentChars.toLowerCase();
    break;
  default:
    error(localize("Unsupported option specified for setting 'comments.outputFormat'."));
  }
  if (_permittedCommentChars != "") {
    text = filterText(String(text), _permittedCommentChars);
  }
  text = String(text).substring(0, settings.comments.maximumLineLength - prefix.length - suffix.length);
  return text != "" ?  prefix + text + suffix : "";
}

/**
  Output a comment.
*/
function writeComment(text) {
  if (!text) {
    return;
  }
  var comments = String(text).split(EOL);
  for (comment in comments) {
    var _comment = formatComment(comments[comment]);
    if (_comment) {
      if (getSetting("comments.showSequenceNumbers", false)) {
        writeBlock(_comment);
      } else {
        writeln(_comment);
      }
    }
  }
}

function onComment(text) {
  writeComment(text);
}

/**
  Writes the specified block - used for tool changes only.
*/
function writeToolBlock() {
  var show = getProperty("showSequenceNumbers");
  setProperty("showSequenceNumbers", (show == "true" || show == "toolChange") ? "true" : "false");
  writeBlock(arguments);
  setProperty("showSequenceNumbers", show);
  machineSimulation({/*x:toPreciseUnit(200, MM), y:toPreciseUnit(200, MM), coordinates:MACHINE,*/ mode:TOOLCHANGE}); // move machineSimulation to a tool change position
}

var skipBlocks = false;
var initialState = JSON.parse(JSON.stringify(state)); // save initial state
var optionalState = JSON.parse(JSON.stringify(state));
var saveCurrentSectionId = undefined;
function writeStartBlocks(isRequired, code) {
  var saveSkipBlocks = skipBlocks;
  var saveMainState = state; // save main state

  if (!isRequired) {
    if (!getProperty("safeStartAllOperations", false)) {
      return; // when safeStartAllOperations is disabled, dont output code and return
    }
    if (saveCurrentSectionId != getCurrentSectionId()) {
      saveCurrentSectionId = getCurrentSectionId();
      forceModals(); // force all modal variables when entering a new section
      optionalState = Object.create(initialState); // reset optionalState to initialState when entering a new section
    }
    skipBlocks = true; // if values are not required, but safeStartAllOperations is enabled - write following blocks as optional
    state = optionalState; // set state to optionalState if skipBlocks is true
    state.mainState = false;
  }
  code(); // writes out the code which is passed to this function as an argument

  state = saveMainState; // restore main state
  skipBlocks = saveSkipBlocks; // restore skipBlocks value
}

var pendingRadiusCompensation = -1;
function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
  if (pendingRadiusCompensation >= 0 && !getSetting("supportsRadiusCompensation", true)) {
    error(localize("Radius compensation mode is not supported."));
    return;
  }
}

function onPassThrough(text) {
  var commands = String(text).split(",");
  for (text in commands) {
    writeBlock(commands[text]);
  }
}

function forceModals() {
  if (arguments.length == 0) { // reset all modal variables listed below
    if (typeof gMotionModal != "undefined") {
      gMotionModal.reset();
    }
    if (typeof gPlaneModal != "undefined") {
      gPlaneModal.reset();
    }
    if (typeof gAbsIncModal != "undefined") {
      gAbsIncModal.reset();
    }
    if (typeof gFeedModeModal != "undefined") {
      gFeedModeModal.reset();
    }
  } else {
    for (var i in arguments) {
      arguments[i].reset(); // only reset the modal variable passed to this function
    }
  }
}

/** Helper function to be able to use a default value for settings which do not exist. */
function getSetting(setting, defaultValue) {
  var result = defaultValue;
  var keys = setting.split(".");
  var obj = settings;
  for (var i in keys) {
    if (obj[keys[i]] != undefined) { // setting does exist
      result = obj[keys[i]];
      if (typeof [keys[i]] === "object") {
        obj = obj[keys[i]];
        continue;
      }
    } else { // setting does not exist, use default value
      if (defaultValue != undefined) {
        result = defaultValue;
      } else {
        error("Setting '" + keys[i] + "' has no default value and/or does not exist.");
        return undefined;
      }
    }
  }
  return result;
}

function getForwardDirection(_section) {
  var forward = undefined;
  var _optimizeType = settings.workPlaneMethod && settings.workPlaneMethod.optimizeType;
  if (_section.isMultiAxis()) {
    forward = _section.workPlane.forward;
  } else if (!getSetting("workPlaneMethod.useTiltedWorkplane", false) && machineConfiguration.isMultiAxisConfiguration()) {
    if (_optimizeType == undefined) {
      var saveRotation = getRotation();
      getWorkPlaneMachineABC(_section, true);
      forward = getRotation().forward;
      setRotation(saveRotation); // reset rotation
    } else {
      var abc = getWorkPlaneMachineABC(_section, false);
      var forceAdjustment = settings.workPlaneMethod.optimizeType == OPTIMIZE_TABLES || settings.workPlaneMethod.optimizeType == OPTIMIZE_BOTH;
      forward = machineConfiguration.getOptimizedDirection(_section.workPlane.forward, abc, false, forceAdjustment);
    }
  } else {
    forward = getRotation().forward;
  }
  return forward;
}

function getRetractParameters() {
  var _arguments = typeof arguments[0] === "object" ? arguments[0].axes : arguments;
  var singleLine = arguments[0].singleLine == undefined ? true : arguments[0].singleLine;
  var words = []; // store all retracted axes in an array
  var retractAxes = new Array(false, false, false);
  var method = getProperty("safePositionMethod", "undefined");
  if (method == "clearanceHeight") {
    if (!is3D()) {
      error(localize("Safe retract option 'Clearance Height' is only supported when all operations are along the setup Z-axis."));
    }
    return undefined;
  }
  validate(settings.retract, "Setting 'retract' is required but not defined.");
  validate(_arguments.length != 0, "No axis specified for getRetractParameters().");
  for (i in _arguments) {
    retractAxes[_arguments[i]] = true;
  }
  if ((retractAxes[0] || retractAxes[1]) && !state.retractedZ) { // retract Z first before moving to X/Y home
    error(localize("Retracting in X/Y is not possible without being retracted in Z."));
    return undefined;
  }
  // special conditions
  if (retractAxes[0] || retractAxes[1]) {
    method = getSetting("retract.methodXY", method);
  }
  if (retractAxes[2]) {
    method = getSetting("retract.methodZ", method);
  }
  // define home positions
  var useZeroValues = (settings.retract.useZeroValues && settings.retract.useZeroValues.indexOf(method) != -1);
  var _xHome = machineConfiguration.hasHomePositionX() && !useZeroValues ? machineConfiguration.getHomePositionX() : toPreciseUnit(0, MM);
  var _yHome = machineConfiguration.hasHomePositionY() && !useZeroValues ? machineConfiguration.getHomePositionY() : toPreciseUnit(0, MM);
  var _zHome = machineConfiguration.getRetractPlane() != 0 && !useZeroValues ? machineConfiguration.getRetractPlane() : toPreciseUnit(0, MM);
  for (var i = 0; i < _arguments.length; ++i) {
    switch (_arguments[i]) {
    case X:
      if (!state.retractedX) {
        words.push("X" + xyzFormat.format(_xHome));
        xOutput.reset();
        state.retractedX = true;
      }
      break;
    case Y:
      if (!state.retractedY) {
        words.push("Y" + xyzFormat.format(_yHome));
        yOutput.reset();
        state.retractedY = true;
      }
      break;
    case Z:
      if (!state.retractedZ) {
        words.push("Z" + xyzFormat.format(_zHome));
        zOutput.reset();
        state.retractedZ = true;
      }
      break;
    default:
      error(localize("Unsupported axis specified for getRetractParameters()."));
      return undefined;
    }
  }
  return {
    method     : method,
    retractAxes: retractAxes,
    words      : words,
    positions  : {
      x: retractAxes[0] ? _xHome : undefined,
      y: retractAxes[1] ? _yHome : undefined,
      z: retractAxes[2] ? _zHome : undefined},
    singleLine: singleLine};
}

/** Returns true when subprogram logic does exist into the post. */
function subprogramsAreSupported() {
  return typeof subprogramState != "undefined";
}

// Start of machine simulation connection move support
var TCPON = "TCP ON";
var TCPOFF = "TCP OFF";
var TWPON = "TWP ON";
var TWPOFF = "TWP OFF";
var TOOLCHANGE = "TOOL CHANGE";
var WORK = "WORK CS";
var MACHINE = "MACHINE CS";
var isTwpOn; // only used for debugging
var isTcpOn; // only used for debugging
if (typeof groupDefinitions != "object") {
  groupDefinitions = {};
}
groupDefinitions.machineSimulation = {title:"Machine Simulation", collapsed:true, order:99};
properties.simulateConnectionMoves = {
  title      : "Simulate Connection Moves (Preview feature)",
  description: "Specifies that connection moves like prepositioning, tool changes, retracts and other non-cutting moves should be shown in the machine simulation." + EOL +
    "Note, this property does not affect the NC output, it only affects the machine simulation.",
  group: "machineSimulation",
  type : "boolean",
  value: false,
  scope: "machine"
};
/**
 * Helper function for connection moves in machine simulation.
 * @param {Object} parameters An object containing the desired options for machine simulation.
 * @note Available properties are:
 * @param {Number} x X axis position
 * @param {Number} y Y axis position
 * @param {Number} z Z axis position
 * @param {Number} a A axis position (in radians)
 * @param {Number} b B axis position (in radians)
 * @param {Number} c C axis position (in radians)
 * @param {Number} feed desired feedrate, automatically set to high/current feedrate if not specified
 * @param {String} mode mode TCPON | TCPOFF | TWPON | TWPOFF | TOOLCHANGE
 * @param {String} coordinates WORK | MACHINE - if undefined, work coordinates will be used by default
 * @param {Number} eulerAngles the calculated Euler angles for the workplane
 * @example
  machineSimulation({a:abc.x, b:abc.y, c:abc.z, coordinates:MACHINE});
  machineSimulation({x:toPreciseUnit(200, MM), y:toPreciseUnit(200, MM), coordinates:MACHINE, toolChange:true});
*/
var debugSimulation = false; // enable to output debug information for connection move support in the NC program

function machineSimulation(parameters) {
  if (revision < 50075 || skipBlocks || !getProperty("simulateConnectionMoves")) {
    return; // return when post kernel revision is lower than 50075 or when skipBlocks is enabled
  }
  var x = parameters.x;
  var y = parameters.y;
  var z = parameters.z;
  var a = parameters.a;
  var b = parameters.b;
  var c = parameters.c;
  var coordinates = parameters.coordinates;
  var eulerAngles = parameters.eulerAngles;
  var feed = parameters.feed;
  if (feed === undefined && typeof gMotionModal !== "undefined") {
    feed = gMotionModal.getCurrent() !== 0;
  }
  var mode  = parameters.mode;
  var performToolChange = mode == TOOLCHANGE;
  if (mode !== undefined && ![TCPON, TCPOFF, TWPON, TWPOFF, TOOLCHANGE].includes(mode)) {
    error(subst("Mode '%1' is not supported.", mode));
  }

  // mode takes precedence over active state
  var enableTCP = mode != undefined ? mode == TCPON : typeof state !== "undefined" && state.tcpIsActive;
  var enableTWP = mode != undefined ? mode == TWPON : typeof state !== "undefined" && state.twpIsActive;
  var disableTCP = mode != undefined ? mode == TCPOFF : typeof state !== "undefined" && !state.tcpIsActive;
  var disableTWP = mode != undefined ? mode == TWPOFF : typeof state !== "undefined" && !state.twpIsActive;
  if (enableTCP) { // update TCP mode
    simulation.setTWPModeOff();
    simulation.setTCPModeOn();
    isTcpOn = true;
  } else if (disableTCP) {
    simulation.setTCPModeOff();
    isTcpOn = false;
  }

  if (enableTWP) { // update TWP mode
    simulation.setTCPModeOff();
    if (settings.workPlaneMethod.eulerConvention == undefined) {
      simulation.setTWPModeAlignToCurrentPose();
    } else if (eulerAngles) {
      simulation.setTWPModeByEulerAngles(settings.workPlaneMethod.eulerConvention, eulerAngles.x, eulerAngles.y, eulerAngles.z);
    }
    isTwpOn = true;
  } else if (disableTWP) {
    simulation.setTWPModeOff();
    isTwpOn = false;
  }
  if (debugSimulation) {
    writeln("  DEBUG" + JSON.stringify(parameters));
    writeln("  DEBUG" + JSON.stringify({isTwpOn:isTwpOn, isTcpOn:isTcpOn, feed:feed}));
  }

  if (x !== undefined || y !== undefined || z !== undefined || a !== undefined || b !== undefined || c !== undefined) {
    if (x !== undefined) {simulation.setTargetX(x);}
    if (y !== undefined) {simulation.setTargetY(y);}
    if (z !== undefined) {simulation.setTargetZ(z);}
    if (a !== undefined) {simulation.setTargetA(a);}
    if (b !== undefined) {simulation.setTargetB(b);}
    if (c !== undefined) {simulation.setTargetC(c);}

    if (feed != undefined && feed) {
      simulation.setMotionToLinear();
      simulation.setFeedrate(typeof feed == "number" ? feed : feedOutput.getCurrent() == 0 ? highFeedrate : feedOutput.getCurrent());
    } else {
      simulation.setMotionToRapid();
    }

    if (coordinates != undefined && coordinates == MACHINE) {
      simulation.moveToTargetInMachineCoords();
    } else {
      simulation.moveToTargetInWorkCoords();
    }
  }
  if (performToolChange) {
    simulation.performToolChangeCycle();
  }
}
// <<<<< INCLUDED FROM include_files/commonFunctions.cpi
// >>>>> INCLUDED FROM include_files/defineMachine.cpi
var compensateToolLength = false; // add the tool length to the pivot distance for nonTCP rotary heads
function defineMachine() {
  var useTCP = true;
  if (false) { // note: setup your machine here
    var aAxis = createAxis({coordinate:0, table:true, axis:[1, 0, 0], range:[-120, 120], preference:1, tcp:useTCP});
    var cAxis = createAxis({coordinate:2, table:true, axis:[0, 0, 1], range:[-360, 360], preference:0, tcp:useTCP});
    machineConfiguration = new MachineConfiguration(aAxis, cAxis);

    setMachineConfiguration(machineConfiguration);
    if (receivedMachineConfiguration) {
      warning(localize("The provided CAM machine configuration is overwritten by the postprocessor."));
      receivedMachineConfiguration = false; // CAM provided machine configuration is overwritten
    }
  }

  if (!receivedMachineConfiguration) {
    // multiaxis settings
    if (machineConfiguration.isHeadConfiguration()) {
      machineConfiguration.setVirtualTooltip(false); // translate the pivot point to the virtual tool tip for nonTCP rotary heads
    }

    // retract / reconfigure
    var performRewinds = false; // set to true to enable the rewind/reconfigure logic
    if (performRewinds) {
      machineConfiguration.enableMachineRewinds(); // enables the retract/reconfigure logic
      safeRetractDistance = (unit == IN) ? 1 : 25; // additional distance to retract out of stock, can be overridden with a property
      safeRetractFeed = (unit == IN) ? 20 : 500; // retract feed rate
      safePlungeFeed = (unit == IN) ? 10 : 250; // plunge feed rate
      machineConfiguration.setSafeRetractDistance(safeRetractDistance);
      machineConfiguration.setSafeRetractFeedrate(safeRetractFeed);
      machineConfiguration.setSafePlungeFeedrate(safePlungeFeed);
      var stockExpansion = new Vector(toPreciseUnit(0.1, IN), toPreciseUnit(0.1, IN), toPreciseUnit(0.1, IN)); // expand stock XYZ values
      machineConfiguration.setRewindStockExpansion(stockExpansion);
    }

    // multi-axis feedrates
    if (machineConfiguration.isMultiAxisConfiguration()) {
      machineConfiguration.setMultiAxisFeedrate(
        useTCP ? FEED_FPM : getProperty("useDPMFeeds") ? FEED_DPM : FEED_INVERSE_TIME,
        9999.99, // maximum output value for inverse time feed rates
        getProperty("useDPMFeeds") ? DPM_COMBINATION : INVERSE_MINUTES, // INVERSE_MINUTES/INVERSE_SECONDS or DPM_COMBINATION/DPM_STANDARD
        0.5, // tolerance to determine when the DPM feed has changed
        1.0 // ratio of rotary accuracy to linear accuracy for DPM calculations
      );
      setMachineConfiguration(machineConfiguration);
    }

    /* home positions */
    // machineConfiguration.setHomePositionX(toPreciseUnit(0, IN));
    // machineConfiguration.setHomePositionY(toPreciseUnit(0, IN));
    // machineConfiguration.setRetractPlane(toPreciseUnit(0, IN));
  }
}
// <<<<< INCLUDED FROM include_files/defineMachine.cpi
// >>>>> INCLUDED FROM include_files/defineWorkPlane.cpi
validate(settings.workPlaneMethod, "Setting 'workPlaneMethod' is required but not defined.");
function defineWorkPlane(_section, _setWorkPlane) {
  var abc = new Vector(0, 0, 0);
  if (settings.workPlaneMethod.forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) {
    if (isPolarModeActive()) {
      abc = getCurrentDirection();
    } else if (_section.isMultiAxis()) {
      forceWorkPlane();
      cancelTransformation();
      abc = _section.isOptimizedForMachine() ? _section.getInitialToolAxisABC() : _section.getGlobalInitialToolAxis();
    } else if (settings.workPlaneMethod.useTiltedWorkplane && settings.workPlaneMethod.eulerConvention != undefined) {
      if (settings.workPlaneMethod.eulerCalculationMethod == "machine" && machineConfiguration.isMultiAxisConfiguration()) {
        abc = machineConfiguration.getOrientation(getWorkPlaneMachineABC(_section, true)).getEuler2(settings.workPlaneMethod.eulerConvention);
      } else {
        abc = _section.workPlane.getEuler2(settings.workPlaneMethod.eulerConvention);
      }
    } else {
      abc = getWorkPlaneMachineABC(_section, true);
    }

    if (_setWorkPlane) {
      if (_section.isMultiAxis() || isPolarModeActive()) { // 4-5x simultaneous operations
        cancelWorkPlane();
        if (_section.isOptimizedForMachine()) {
          positionABC(abc, true);
        } else {
          setCurrentDirection(abc);
        }
      } else { // 3x and/or 3+2x operations
        setWorkPlane(abc);
      }
    }
  } else {
    var remaining = _section.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return abc;
    }
    setRotation(remaining);
  }
  tcp.isSupportedByOperation = isTCPSupportedByOperation(_section);
  return abc;
}

function isTCPSupportedByOperation(_section) {
  var _tcp = _section.getOptimizedTCPMode() == OPTIMIZE_NONE;
  if (!_section.isMultiAxis() && (settings.workPlaneMethod.useTiltedWorkplane ||
    isSameDirection(machineConfiguration.getSpindleAxis(), getForwardDirection(_section)) ||
    settings.workPlaneMethod.optimizeType == OPTIMIZE_HEADS ||
    settings.workPlaneMethod.optimizeType == OPTIMIZE_TABLES ||
    settings.workPlaneMethod.optimizeType == OPTIMIZE_BOTH)) {
    _tcp = false;
  }
  return _tcp;
}
// <<<<< INCLUDED FROM include_files/defineWorkPlane.cpi
// >>>>> INCLUDED FROM include_files/getWorkPlaneMachineABC.cpi
validate(settings.machineAngles, "Setting 'machineAngles' is required but not defined.");
function getWorkPlaneMachineABC(_section, rotate) {
  var currentABC = isFirstSection() ? new Vector(0, 0, 0) : getCurrentABC();
  var abc = _section.getABCByPreference(machineConfiguration, _section.workPlane, currentABC, settings.machineAngles.controllingAxis, settings.machineAngles.type, settings.machineAngles.options);
  if (!isSameDirection(machineConfiguration.getDirection(abc), _section.workPlane.forward)) {
    error(localize("Orientation not supported."));
  }
  if (rotate) {
    if (settings.workPlaneMethod.optimizeType == undefined || settings.workPlaneMethod.useTiltedWorkplane) { // legacy
      var useTCP = false;
      var R = machineConfiguration.getRemainingOrientation(abc, _section.workPlane);
      setRotation(useTCP ? _section.workPlane : R);
    } else {
      if (!_section.isOptimizedForMachine()) {
        machineConfiguration.setToolLength(compensateToolLength ? _section.getTool().overallLength : 0); // define the tool length for head adjustments
        _section.optimize3DPositionsByMachine(machineConfiguration, abc, settings.workPlaneMethod.optimizeType);
      }
    }
  }
  return abc;
}
// <<<<< INCLUDED FROM include_files/getWorkPlaneMachineABC.cpi
// >>>>> INCLUDED FROM include_files/positionABC.cpi
function positionABC(abc, force) {
  if (!machineConfiguration.isMultiAxisConfiguration()) {
    error("Function 'positionABC' can only be used with multi-axis machine configurations.");
  }
  if (typeof unwindABC == "function") {
    unwindABC(abc);
  }
  if (force) {
    forceABC();
  }
  var a = aOutput.format(abc.x);
  var b = bOutput.format(abc.y);
  var c = cOutput.format(abc.z);
  if (a || b || c) {
    writeRetract(Z);
    if (getSetting("retract.homeXY.onIndexing", false)) {
      writeRetract(settings.retract.homeXY.onIndexing);
    }
    onCommand(COMMAND_UNLOCK_MULTI_AXIS);
    gMotionModal.reset();
    writeBlock(gMotionModal.format(0), a, b, c);

    if (getCurrentSectionId() != -1) {
      setCurrentABC(abc); // required for machine simulation
    }
    machineSimulation({a:abc.x, b:abc.y, c:abc.z, coordinates:MACHINE});
  }
}
// <<<<< INCLUDED FROM include_files/positionABC.cpi
// >>>>> INCLUDED FROM include_files/writeWCS.cpi
function writeWCS(section, wcsIsRequired) {
  if (section.workOffset != currentWorkOffset) {
    if (getSetting("workPlaneMethod.cancelTiltFirst", false) && wcsIsRequired) {
      cancelWorkPlane();
    }
    if (typeof forceWorkPlane == "function" && wcsIsRequired) {
      forceWorkPlane();
    }
    writeStartBlocks(wcsIsRequired, function () {
      writeBlock(section.wcs);
    });
    currentWorkOffset = section.workOffset;
  }
}
// <<<<< INCLUDED FROM include_files/writeWCS.cpi
// >>>>> INCLUDED FROM include_files/writeToolCall.cpi
function writeToolCall(tool, insertToolCall) {
  if (!isFirstSection()) {
    writeStartBlocks(!getProperty("safeStartAllOperations") && insertToolCall, function () {
      writeRetract(Z); // write optional Z retract before tool change if safeStartAllOperations is enabled
    });
  }
  writeStartBlocks(insertToolCall, function () {
    writeRetract(Z);
    if (getSetting("retract.homeXY.onToolChange", false)) {
      writeRetract(settings.retract.homeXY.onToolChange);
    }
    if (!isFirstSection() && insertToolCall) {
      if (typeof forceWorkPlane == "function") {
        forceWorkPlane();
      }
      onCommand(COMMAND_COOLANT_OFF); // turn off coolant on tool change
      if (typeof disableLengthCompensation == "function") {
        disableLengthCompensation(false);
      }
    }

    if (tool.manualToolChange) {
      onCommand(COMMAND_STOP);
      writeComment("MANUAL TOOL CHANGE TO T" + toolFormat.format(tool.number));
    } else {
      if (!isFirstSection() && getProperty("optionalStop") && insertToolCall) {
        onCommand(COMMAND_OPTIONAL_STOP);
      }
      onCommand(COMMAND_LOAD_TOOL);
    }
  });
  if (typeof forceModals == "function" && (insertToolCall || getProperty("safeStartAllOperations"))) {
    forceModals();
  }
}
// <<<<< INCLUDED FROM include_files/writeToolCall.cpi
// >>>>> INCLUDED FROM include_files/startSpindle.cpi

function startSpindle(tool, insertToolCall) {
  if (tool.type != TOOL_PROBE) {
    var spindleSpeedIsRequired = insertToolCall || forceSpindleSpeed || isFirstSection() ||
      rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent()) ||
      (tool.clockwise != getPreviousSection().getTool().clockwise);

    writeStartBlocks(spindleSpeedIsRequired, function () {
      if (spindleSpeedIsRequired || operationNeedsSafeStart) {
        onCommand(COMMAND_START_SPINDLE);
      }
    });
  }
}
// <<<<< INCLUDED FROM include_files/startSpindle.cpi
// >>>>> INCLUDED FROM include_files/parametricFeeds.cpi
properties.useParametricFeed = {
  title      : "Parametric feed",
  description: "Specifies that the feedrates should be output using parameters.",
  group      : "preferences",
  type       : "boolean",
  value      : false,
  scope      : "post"
};
var activeMovements;
var currentFeedId;
validate(settings.parametricFeeds, "Setting 'parametricFeeds' is required but not defined.");
function initializeParametricFeeds(insertToolCall) {
  if (getProperty("useParametricFeed") && getParameter("operation-strategy") != "drill" && !currentSection.hasAnyCycle()) {
    if (!insertToolCall && activeMovements && (getCurrentSectionId() > 0) &&
      ((getPreviousSection().getPatternId() == currentSection.getPatternId()) && (currentSection.getPatternId() != 0))) {
      return; // use the current feeds
    }
  } else {
    activeMovements = undefined;
    return;
  }

  activeMovements = new Array();
  var movements = currentSection.getMovements();

  var id = 0;
  var activeFeeds = new Array();
  if (hasParameter("operation:tool_feedCutting")) {
    if (movements & ((1 << MOVEMENT_CUTTING) | (1 << MOVEMENT_LINK_TRANSITION) | (1 << MOVEMENT_EXTENDED))) {
      var feedContext = new FeedContext(id, localize("Cutting"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_CUTTING] = feedContext;
      if (!hasParameter("operation:tool_feedTransition")) {
        activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
      }
      activeMovements[MOVEMENT_EXTENDED] = feedContext;
    }
    ++id;
    if (movements & (1 << MOVEMENT_PREDRILL)) {
      feedContext = new FeedContext(id, localize("Predrilling"), getParameter("operation:tool_feedCutting"));
      activeMovements[MOVEMENT_PREDRILL] = feedContext;
      activeFeeds.push(feedContext);
    }
    ++id;
  }
  if (hasParameter("operation:finishFeedrate")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:finishFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting")) {
    if (movements & (1 << MOVEMENT_FINISH_CUTTING)) {
      var feedContext = new FeedContext(id, localize("Finish"), getParameter("operation:tool_feedCutting"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_FINISH_CUTTING] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedEntry")) {
    if (movements & (1 << MOVEMENT_LEAD_IN)) {
      var feedContext = new FeedContext(id, localize("Entry"), getParameter("operation:tool_feedEntry"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_IN] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LEAD_OUT)) {
      var feedContext = new FeedContext(id, localize("Exit"), getParameter("operation:tool_feedExit"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LEAD_OUT] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:noEngagementFeedrate")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), getParameter("operation:noEngagementFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  } else if (hasParameter("operation:tool_feedCutting") &&
             hasParameter("operation:tool_feedEntry") &&
             hasParameter("operation:tool_feedExit")) {
    if (movements & (1 << MOVEMENT_LINK_DIRECT)) {
      var feedContext = new FeedContext(id, localize("Direct"), Math.max(getParameter("operation:tool_feedCutting"), getParameter("operation:tool_feedEntry"), getParameter("operation:tool_feedExit")));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_DIRECT] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:reducedFeedrate")) {
    if (movements & (1 << MOVEMENT_REDUCED)) {
      var feedContext = new FeedContext(id, localize("Reduced"), getParameter("operation:reducedFeedrate"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_REDUCED] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedRamp")) {
    if (movements & ((1 << MOVEMENT_RAMP) | (1 << MOVEMENT_RAMP_HELIX) | (1 << MOVEMENT_RAMP_PROFILE) | (1 << MOVEMENT_RAMP_ZIG_ZAG))) {
      var feedContext = new FeedContext(id, localize("Ramping"), getParameter("operation:tool_feedRamp"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_RAMP] = feedContext;
      activeMovements[MOVEMENT_RAMP_HELIX] = feedContext;
      activeMovements[MOVEMENT_RAMP_PROFILE] = feedContext;
      activeMovements[MOVEMENT_RAMP_ZIG_ZAG] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedPlunge")) {
    if (movements & (1 << MOVEMENT_PLUNGE)) {
      var feedContext = new FeedContext(id, localize("Plunge"), getParameter("operation:tool_feedPlunge"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_PLUNGE] = feedContext;
    }
    ++id;
  }
  if (true) { // high feed
    if ((movements & (1 << MOVEMENT_HIGH_FEED)) || (highFeedMapping != HIGH_FEED_NO_MAPPING)) {
      var feed;
      if (hasParameter("operation:highFeedrateMode") && getParameter("operation:highFeedrateMode") != "disabled") {
        feed = getParameter("operation:highFeedrate");
      } else {
        feed = this.highFeedrate;
      }
      var feedContext = new FeedContext(id, localize("High Feed"), feed);
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_HIGH_FEED] = feedContext;
      activeMovements[MOVEMENT_RAPID] = feedContext;
    }
    ++id;
  }
  if (hasParameter("operation:tool_feedTransition")) {
    if (movements & (1 << MOVEMENT_LINK_TRANSITION)) {
      var feedContext = new FeedContext(id, localize("Transition"), getParameter("operation:tool_feedTransition"));
      activeFeeds.push(feedContext);
      activeMovements[MOVEMENT_LINK_TRANSITION] = feedContext;
    }
    ++id;
  }

  for (var i = 0; i < activeFeeds.length; ++i) {
    var feedContext = activeFeeds[i];
    var feedDescription = typeof formatComment == "function" ? formatComment(feedContext.description) : feedContext.description;
    writeBlock(settings.parametricFeeds.feedAssignmentVariable + (settings.parametricFeeds.firstFeedParameter + feedContext.id) + "=" + feedFormat.format(feedContext.feed) + SP + feedDescription);
  }
}

function FeedContext(id, description, feed) {
  this.id = id;
  this.description = description;
  this.feed = feed;
}
// <<<<< INCLUDED FROM include_files/parametricFeeds.cpi
// >>>>> INCLUDED FROM include_files/coolant.cpi
var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;
var isOptionalCoolant = false;
var forceCoolant = false;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    writeStartBlocks(!isOptionalCoolant, function () {
      if (settings.coolant.singleLineCoolant) {
        writeBlock(coolantCodes.join(getWordSeparator()));
      } else {
        for (var c in coolantCodes) {
          writeBlock(coolantCodes[c]);
        }
      }
    });
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant, format) {
  if (!getProperty("useCoolant", true)) {
    return undefined; // coolant output is disabled by property if it exists
  }
  isOptionalCoolant = false;
  if (typeof operationNeedsSafeStart == "undefined") {
    operationNeedsSafeStart = false;
  }
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  var coolants = settings.coolant.coolants;
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (tool.type && tool.type == TOOL_PROBE) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode) {
    if (operationNeedsSafeStart && coolant != COOLANT_OFF) {
      isOptionalCoolant = true;
    } else if (!forceCoolant || coolant == COOLANT_OFF) {
      return undefined; // coolant is already active
    }
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined) && !forceCoolant && !isOptionalCoolant) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(coolantOff[i]);
      }
    } else {
      multipleCoolantBlocks.push(coolantOff);
    }
  }
  forceCoolant = false;

  var m;
  var coolantCodes = {};
  for (var c in coolants) { // find required coolant codes into the coolants array
    if (coolants[c].id == coolant) {
      coolantCodes.on = coolants[c].on;
      if (coolants[c].off != undefined) {
        coolantCodes.off = coolants[c].off;
        break;
      } else {
        for (var i in coolants) {
          if (coolants[i].id == COOLANT_OFF) {
            coolantCodes.off = coolants[i].off;
            break;
          }
        }
      }
    }
  }
  if (coolant == COOLANT_OFF) {
    m = !coolantOff ? coolantCodes.off : coolantOff; // use the default coolant off command when an 'off' value is not specified
  } else {
    coolantOff = coolantCodes.off;
    m = coolantCodes.on;
  }

  if (!m) {
    onUnsupportedCoolant(coolant);
    m = 9;
  } else {
    if (Array.isArray(m)) {
      for (var i in m) {
        multipleCoolantBlocks.push(m[i]);
      }
    } else {
      multipleCoolantBlocks.push(m);
    }
    currentCoolantMode = coolant;
    for (var i in multipleCoolantBlocks) {
      if (typeof multipleCoolantBlocks[i] == "number") {
        multipleCoolantBlocks[i] = mFormat.format(multipleCoolantBlocks[i]);
      }
    }
    if (format == undefined || format) {
      return multipleCoolantBlocks; // return the single formatted coolant value
    } else {
      return m; // return unformatted coolant value
    }
  }
  return undefined;
}
// <<<<< INCLUDED FROM include_files/coolant.cpi
// >>>>> INCLUDED FROM include_files/smoothing.cpi
// collected state below, do not edit
validate(settings.smoothing, "Setting 'smoothing' is required but not defined.");
var smoothing = {
  cancel     : false, // cancel tool length prior to update smoothing for this operation
  isActive   : false, // the current state of smoothing
  isAllowed  : false, // smoothing is allowed for this operation
  isDifferent: false, // tells if smoothing levels/tolerances/both are different between operations
  level      : -1, // the active level of smoothing
  tolerance  : -1, // the current operation tolerance
  force      : false // smoothing needs to be forced out in this operation
};

function initializeSmoothing() {
  var smoothingSettings = settings.smoothing;
  var previousLevel = smoothing.level;
  var previousTolerance = xyzFormat.getResultingValue(smoothing.tolerance);

  // format threshold parameters
  var thresholdRoughing = xyzFormat.getResultingValue(smoothingSettings.thresholdRoughing);
  var thresholdSemiFinishing = xyzFormat.getResultingValue(smoothingSettings.thresholdSemiFinishing);
  var thresholdFinishing = xyzFormat.getResultingValue(smoothingSettings.thresholdFinishing);

  // determine new smoothing levels and tolerances
  smoothing.level = parseInt(getProperty("useSmoothing"), 10);
  smoothing.level = isNaN(smoothing.level) ? -1 : smoothing.level;
  smoothing.tolerance = xyzFormat.getResultingValue(Math.max(getParameter("operation:tolerance", thresholdFinishing), 0));

  if (smoothing.level == 9999) {
    if (smoothingSettings.autoLevelCriteria == "stock") { // determine auto smoothing level based on stockToLeave
      var stockToLeave = xyzFormat.getResultingValue(getParameter("operation:stockToLeave", 0));
      var verticalStockToLeave = xyzFormat.getResultingValue(getParameter("operation:verticalStockToLeave", 0));
      if (((stockToLeave >= thresholdRoughing) && (verticalStockToLeave >= thresholdRoughing)) || getParameter("operation:strategy", "") == "face") {
        smoothing.level = smoothingSettings.roughing; // set roughing level
      } else {
        if (((stockToLeave >= thresholdSemiFinishing) && (stockToLeave < thresholdRoughing)) &&
          ((verticalStockToLeave >= thresholdSemiFinishing) && (verticalStockToLeave  < thresholdRoughing))) {
          smoothing.level = smoothingSettings.semi; // set semi level
        } else if (((stockToLeave >= thresholdFinishing) && (stockToLeave < thresholdSemiFinishing)) &&
          ((verticalStockToLeave >= thresholdFinishing) && (verticalStockToLeave  < thresholdSemiFinishing))) {
          smoothing.level = smoothingSettings.semifinishing; // set semi-finishing level
        } else {
          smoothing.level = smoothingSettings.finishing; // set finishing level
        }
      }
    } else { // detemine auto smoothing level based on operation tolerance instead of stockToLeave
      if (smoothing.tolerance >= thresholdRoughing || getParameter("operation:strategy", "") == "face") {
        smoothing.level = smoothingSettings.roughing; // set roughing level
      } else {
        if (((smoothing.tolerance >= thresholdSemiFinishing) && (smoothing.tolerance < thresholdRoughing))) {
          smoothing.level = smoothingSettings.semi; // set semi level
        } else if (((smoothing.tolerance >= thresholdFinishing) && (smoothing.tolerance < thresholdSemiFinishing))) {
          smoothing.level = smoothingSettings.semifinishing; // set semi-finishing level
        } else {
          smoothing.level = smoothingSettings.finishing; // set finishing level
        }
      }
    }
  }

  if (smoothing.level == -1) { // useSmoothing is disabled
    smoothing.isAllowed = false;
  } else { // do not output smoothing for the following operations
    smoothing.isAllowed = !(currentSection.getTool().type == TOOL_PROBE || isDrillingCycle());
  }
  if (!smoothing.isAllowed) {
    smoothing.level = -1;
    smoothing.tolerance = -1;
  }

  switch (smoothingSettings.differenceCriteria) {
  case "level":
    smoothing.isDifferent = smoothing.level != previousLevel;
    break;
  case "tolerance":
    smoothing.isDifferent = smoothing.tolerance != previousTolerance;
    break;
  case "both":
    smoothing.isDifferent = smoothing.level != previousLevel || smoothing.tolerance != previousTolerance;
    break;
  default:
    error(localize("Unsupported smoothing criteria."));
    return;
  }

  // tool length compensation needs to be canceled when smoothing state/level changes
  if (smoothingSettings.cancelCompensation) {
    smoothing.cancel = !isFirstSection() && smoothing.isDifferent;
  }
}
// <<<<< INCLUDED FROM include_files/smoothing.cpi
// >>>>> INCLUDED FROM include_files/writeProgramHeader.cpi
properties.writeMachine = {
  title      : "Write machine",
  description: "Output the machine settings in the header of the program.",
  group      : "formats",
  type       : "boolean",
  value      : true,
  scope      : "post"
};
properties.writeTools = {
  title      : "Write tool list",
  description: "Output a tool list in the header of the program.",
  group      : "formats",
  type       : "boolean",
  value      : true,
  scope      : "post"
};
function writeProgramHeader() {
  writeComment((now.getMonth() + 1) + "-" + now.getDate() + "-" + now.getFullYear() + " " + now.getHours() + ":" + ("0" + now.getMinutes()).slice(-2)); //BJE
  // dump machine configuration
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var mDescription = machineConfiguration.getDescription();
  if (getProperty("writeMachine") && (vendor || model || mDescription)) {
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (mDescription) {
      writeComment("  " + localize("description") + ": "  + mDescription);
    }
  }

  // dump tool information
  if (getProperty("writeTools")) {
    if (false) { // set to true to use the post kernel version of the tool list
      writeToolTable(TOOL_NUMBER_COL);
    } else {
      var zRanges = {};
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        for (var i = 0; i < numberOfSections; ++i) {
          var section = getSection(i);
          var zRange = section.getGlobalZRange();
          var tool = section.getTool();
          if (zRanges[tool.number]) {
            zRanges[tool.number].expandToRange(zRange);
          } else {
            zRanges[tool.number] = zRange;
          }
        }
      }
      var tools = getToolTable();
      if (tools.getNumberOfTools() > 0) {
        for (var i = 0; i < tools.getNumberOfTools(); ++i) {
          var tool = tools.getTool(i);
          var comment = (getProperty("toolAsName") ? "\"" + tool.description.toUpperCase() + "\"" : "T" + toolFormat.format(tool.number)) + " " +
          "D=" + xyzFormat.format(tool.diameter) + " " +
          localize("CR") + "=" + xyzFormat.format(tool.cornerRadius);
          if ((tool.taperAngle > 0) && (tool.taperAngle < Math.PI)) {
            comment += " " + localize("TAPER") + "=" + taperFormat.format(tool.taperAngle) + localize("deg");
          }
          if (zRanges[tool.number]) {
            comment += " - " + localize("ZMIN") + "=" + xyzFormat.format(zRanges[tool.number].getMinimum());
          }
          comment += " - " + getToolTypeName(tool.type);
          writeComment(comment);
        }
      }
    }
  }
}
// <<<<< INCLUDED FROM include_files/writeProgramHeader.cpi
// >>>>> INCLUDED FROM include_files/subprograms.cpi
properties.useSubroutines = {
  title      : "Use subroutines",
  description: "Select your desired subroutine option. 'All Operations' creates subroutines per each operation, 'Cycles' creates subroutines for cycle operations on same holes, and 'Patterns' creates subroutines for patterned operations.",
  group      : "preferences",
  type       : "enum",
  values     : [
    {title:"No", id:"none"},
    {title:"All Operations", id:"allOperations"},
    {title:"All Operations & Patterns", id:"allPatterns"},
    {title:"Cycles", id:"cycles"},
    {title:"Operations, Patterns, Cycles", id:"all"},
    {title:"Patterns", id:"patterns"}
  ],
  value: "none",
  scope: "post"
};
properties.useFilesForSubprograms = {
  title      : "Use files for subroutines",
  description: "If enabled, subroutines will be saved as individual files.",
  group      : "preferences",
  type       : "boolean",
  value      : false,
  scope      : "post"
};

var NONE = 0x0000;
var PATTERNS = 0x0001;
var CYCLES = 0x0010;
var ALLOPERATIONS = 0x0100;
var subroutineBitmasks = {
  none         : NONE,
  patterns     : PATTERNS,
  cycles       : CYCLES,
  allOperations: ALLOPERATIONS,
  allPatterns  : PATTERNS + ALLOPERATIONS,
  all          : PATTERNS + CYCLES + ALLOPERATIONS
};

var SUB_UNKNOWN = 0;
var SUB_PATTERN = 1;
var SUB_CYCLE = 2;

// collected state below, do not edit
validate(settings.subprograms, "Setting 'subprograms' is required but not defined.");
var subprogramState = {
  subprograms            : [],          // Redirection buffer
  newSubprogram          : false,       // Indicate if the current subprogram is new to definedSubprograms
  currentSubprogram      : 0,           // The current subprogram number
  lastSubprogram         : undefined,   // The last subprogram number
  definedSubprograms     : new Array(), // A collection of pattern and cycle subprograms
  saveShowSequenceNumbers: "",          // Used to store pre-condition of "showSequenceNumbers"
  cycleSubprogramIsActive: false,       // Indicate if it's handling a cycle subprogram
  patternIsActive        : false,       // Indicate if it's handling a pattern subprogram
  incrementalSubprogram  : false,       // Indicate if the current subprogram needs to go incremental mode
  incrementalMode        : false,       // Indicate if incremental mode is on
  mainProgramNumber      : undefined    // The main program number
};

function subprogramResolveSetting(_setting, _val, _comment) {
  if (typeof _setting == "string") {
    return formatWords(_setting.toString().replace("%currentSubprogram", subprogramState.currentSubprogram), (_comment ? formatComment(_comment) : ""));
  } else {
    return formatWords(_setting + (_val ? settings.subprograms.format.format(_val) : ""), (_comment ? formatComment(_comment) : ""));
  }
}

/**
 * Start to redirect buffer to subprogram.
 * @param {Vector} initialPosition Initial position
 * @param {Vector} abc Machine axis angles
 * @param {boolean} incremental If the subprogram needs to go incremental mode
 */
function subprogramStart(initialPosition, abc, incremental) {
  var comment = getParameter("operation-comment", "");
  var startBlock;
  if (getProperty("useFilesForSubprograms")) {
    var _fileName = subprogramState.currentSubprogram;
    var subprogramExtension = extension;
    if (settings.subprograms.files) {
      if (settings.subprograms.files.prefix != undefined) {
        _fileName = subprogramResolveSetting(settings.subprograms.files.prefix, subprogramState.currentSubprogram);
      }
      if (settings.subprograms.files.extension) {
        subprogramExtension = settings.subprograms.files.extension;
      }
    }
    var path = FileSystem.getCombinedPath(FileSystem.getFolderPath(getOutputPath()), _fileName + "." + subprogramExtension);
    redirectToFile(path);
    startBlock = subprogramResolveSetting(settings.subprograms.startBlock.files, subprogramState.currentSubprogram, comment);
  } else {
    redirectToBuffer();
    startBlock = subprogramResolveSetting(settings.subprograms.startBlock.embedded, subprogramState.currentSubprogram, comment);
  }
  writeln(startBlock);

  subprogramState.saveShowSequenceNumbers = getProperty("showSequenceNumbers", undefined);
  if (subprogramState.saveShowSequenceNumbers != undefined) {
    setProperty("showSequenceNumbers", "false");
  }
  if (incremental) {
    setAbsIncMode(true, initialPosition, abc);
  }
  if (typeof gPlaneModal != "undefined" && typeof gMotionModal != "undefined") {
    forceModals(gPlaneModal, gMotionModal);
  }
}

/** Output the command for calling a subprogram by its subprogram number. */
function subprogramCall() {
  var callBlock;
  if (getProperty("useFilesForSubprograms")) {
    callBlock = subprogramResolveSetting(settings.subprograms.callBlock.files, subprogramState.currentSubprogram);
  } else {
    callBlock = subprogramResolveSetting(settings.subprograms.callBlock.embedded, subprogramState.currentSubprogram);
  }
  writeBlock(callBlock); // call subprogram
}

/** End of subprogram and close redirection. */
function subprogramEnd() {
  if (isRedirecting()) {
    if (subprogramState.newSubprogram) {
      var finalPosition = getFramePosition(currentSection.getFinalPosition());
      var abc;
      if (currentSection.isMultiAxis() && machineConfiguration.isMultiAxisConfiguration()) {
        abc = currentSection.getFinalToolAxisABC();
      } else {
        abc = getCurrentDirection();
      }
      setAbsIncMode(false, finalPosition, abc);

      if (getProperty("useFilesForSubprograms")) {
        var endBlockFiles = subprogramResolveSetting(settings.subprograms.endBlock.files);
        writeln(endBlockFiles);
      } else {
        var endBlockEmbedded = subprogramResolveSetting(settings.subprograms.endBlock.embedded);
        writeln(endBlockEmbedded);
        writeln("");
        subprogramState.subprograms += getRedirectionBuffer();
      }
    }
    forceAny();
    subprogramState.newSubprogram = false;
    subprogramState.cycleSubprogramIsActive = false;
    if (subprogramState.saveShowSequenceNumbers != undefined) {
      setProperty("showSequenceNumbers", subprogramState.saveShowSequenceNumbers);
    }
    closeRedirection();
  }
}

/** Returns true if the spatial vectors are significantly different. */
function areSpatialVectorsDifferent(_vector1, _vector2) {
  return (xyzFormat.getResultingValue(_vector1.x) != xyzFormat.getResultingValue(_vector2.x)) ||
    (xyzFormat.getResultingValue(_vector1.y) != xyzFormat.getResultingValue(_vector2.y)) ||
    (xyzFormat.getResultingValue(_vector1.z) != xyzFormat.getResultingValue(_vector2.z));
}

/** Returns true if the spatial boxes are a pure translation. */
function areSpatialBoxesTranslated(_box1, _box2) {
  return !areSpatialVectorsDifferent(Vector.diff(_box1[1], _box1[0]), Vector.diff(_box2[1], _box2[0])) &&
    !areSpatialVectorsDifferent(Vector.diff(_box2[0], _box1[0]), Vector.diff(_box2[1], _box1[1]));
}

/** Returns true if the spatial boxes are same. */
function areSpatialBoxesSame(_box1, _box2) {
  return !areSpatialVectorsDifferent(_box1[0], _box2[0]) && !areSpatialVectorsDifferent(_box1[1], _box2[1]);
}

/**
 * Search defined pattern subprogram by the given id.
 * @param {number} subprogramId Subprogram Id
 * @returns {Object} Returns defined subprogram if found, otherwise returns undefined
 */
function getDefinedPatternSubprogram(subprogramId) {
  for (var i = 0; i < subprogramState.definedSubprograms.length; ++i) {
    if ((SUB_PATTERN == subprogramState.definedSubprograms[i].type) && (subprogramId == subprogramState.definedSubprograms[i].id)) {
      return subprogramState.definedSubprograms[i];
    }
  }
  return undefined;
}

/**
 * Search defined cycle subprogram pattern by the given id, initialPosition, finalPosition.
 * @param {number} subprogramId Subprogram Id
 * @param {Vector} initialPosition Initial position of the cycle
 * @param {Vector} finalPosition Final position of the cycle
 * @returns {Object} Returns defined subprogram if found, otherwise returns undefined
 */
function getDefinedCycleSubprogram(subprogramId, initialPosition, finalPosition) {
  for (var i = 0; i < subprogramState.definedSubprograms.length; ++i) {
    if ((SUB_CYCLE == subprogramState.definedSubprograms[i].type) && (subprogramId == subprogramState.definedSubprograms[i].id) &&
        !areSpatialVectorsDifferent(initialPosition, subprogramState.definedSubprograms[i].initialPosition) &&
        !areSpatialVectorsDifferent(finalPosition, subprogramState.definedSubprograms[i].finalPosition)) {
      return subprogramState.definedSubprograms[i];
    }
  }
  return undefined;
}

/**
 * Creates and returns new defined subprogram
 * @param {Section} section The section to create subprogram
 * @param {number} subprogramId Subprogram Id
 * @param {number} subprogramType Subprogram type, can be SUB_UNKNOWN, SUB_PATTERN or SUB_CYCLE
 * @param {Vector} initialPosition Initial position
 * @param {Vector} finalPosition Final position
 * @returns {Object} Returns new defined subprogram
 */
function defineNewSubprogram(section, subprogramId, subprogramType, initialPosition, finalPosition) {
  // determine if this is valid for creating a subprogram
  isValid = subprogramIsValid(section, subprogramId, subprogramType);
  var subprogram = isValid ? subprogram = ++subprogramState.lastSubprogram : undefined;
  subprogramState.definedSubprograms.push({
    type           : subprogramType,
    id             : subprogramId,
    subProgram     : subprogram,
    isValid        : isValid,
    initialPosition: initialPosition,
    finalPosition  : finalPosition
  });
  return subprogramState.definedSubprograms[subprogramState.definedSubprograms.length - 1];
}

/** Returns true if the given section is a pattern **/
function isPatternOperation(section) {
  return section.isPatterned && section.isPatterned();
}

/** Returns true if the given section is a cycle operation **/
function isCycleOperation(section, minimumCyclePoints) {
  return section.doesStrictCycle &&
  (section.getNumberOfCycles() == 1) && (section.getNumberOfCyclePoints() >= minimumCyclePoints);
}

/** Returns true if the subroutine bit flag is enabled **/
function isSubProgramEnabledFor(subroutine) {
  return subroutineBitmasks[getProperty("useSubroutines")] & subroutine;
}

/**
 * Define subprogram based on the property "useSubroutines"
 * @param {Vector} _initialPosition Initial position
 * @param {Vector} _abc Machine axis angles
 */
function subprogramDefine(_initialPosition, _abc) {
  if (isSubProgramEnabledFor(NONE)) {
    // Return early
    return;
  }

  if (subprogramState.lastSubprogram == undefined) { // initialize first subprogram number
    if (settings.subprograms.initialSubprogramNumber == undefined) {
      try {
        subprogramState.lastSubprogram = getAsInt(programName);
        subprogramState.mainProgramNumber = subprogramState.lastSubprogram; // mainProgramNumber must be a number
      } catch (e) {
        error(localize("Program name must be a number when using subprograms."));
        return;
      }
    } else {
      subprogramState.lastSubprogram = settings.subprograms.initialSubprogramNumber - 1;
      // if programName is a string set mainProgramNumber to undefined, if programName is a number set mainProgramNumber to programName
      subprogramState.mainProgramNumber = (!isNaN(programName) && !isNaN(parseInt(programName, 10))) ? getAsInt(programName) : undefined;
    }
  }

  // convert patterns into subprograms
  subprogramState.patternIsActive = false;
  if (isSubProgramEnabledFor(PATTERNS) && isPatternOperation(currentSection)) {
    var subprogramId = currentSection.getPatternId();
    var subprogramType = SUB_PATTERN;
    var subprogramDefinition = getDefinedPatternSubprogram(subprogramId);

    subprogramState.newSubprogram = !subprogramDefinition;
    if (subprogramState.newSubprogram) {
      subprogramDefinition = defineNewSubprogram(currentSection, subprogramId, subprogramType, _initialPosition, _initialPosition);
    }

    subprogramState.currentSubprogram = subprogramDefinition.subProgram;
    if (subprogramDefinition.isValid) {
      // make sure Z-position is output prior to subprogram call
      var z = zOutput.format(_initialPosition.z);
      if (!state.retractedZ && z) {
        validate(!validateLengthCompensation || state.lengthCompensationActive, "Tool length compensation is not active."); // make sure that length compensation is enabled
        var block = "";
        if (typeof gAbsIncModal != "undefined") {
          block += gAbsIncModal.format(90);
        }
        if (typeof gPlaneModal != "undefined") {
          block += gPlaneModal.format(17);
        }
        writeBlock(block);
        zOutput.reset();
        invokeOnRapid(xOutput.getCurrent(), yOutput.getCurrent(), _initialPosition.z);
      }

      // call subprogram
      subprogramCall();
      subprogramState.patternIsActive = true;

      if (subprogramState.newSubprogram) {
        subprogramStart(_initialPosition, _abc, subprogramState.incrementalSubprogram);
      } else {
        skipRemainingSection();
        setCurrentPosition(getFramePosition(currentSection.getFinalPosition()));
      }
    }
  }

  // Patterns are not used, check other cases
  if (!subprogramState.patternIsActive) {
    // Output cycle operation as subprogram
    if (isSubProgramEnabledFor(CYCLES) && isCycleOperation(currentSection, settings.subprograms.minimumCyclePoints)) {
      var finalPosition = getFramePosition(currentSection.getFinalPosition());
      var subprogramId = currentSection.getNumberOfCyclePoints();
      var subprogramType = SUB_CYCLE;
      var subprogramDefinition = getDefinedCycleSubprogram(subprogramId, _initialPosition, finalPosition);
      subprogramState.newSubprogram = !subprogramDefinition;
      if (subprogramState.newSubprogram) {
        subprogramDefinition = defineNewSubprogram(currentSection, subprogramId, subprogramType, _initialPosition, finalPosition);
      }
      subprogramState.currentSubprogram = subprogramDefinition.subProgram;
      subprogramState.cycleSubprogramIsActive = subprogramDefinition.isValid;
    }

    // Neither patterns and cycles are used, check other operations
    if (!subprogramState.cycleSubprogramIsActive && isSubProgramEnabledFor(ALLOPERATIONS)) {
      // Output all operations as subprograms
      subprogramState.currentSubprogram = ++subprogramState.lastSubprogram;
      if (subprogramState.mainProgramNumber != undefined && (subprogramState.currentSubprogram == subprogramState.mainProgramNumber)) {
        subprogramState.currentSubprogram = ++subprogramState.lastSubprogram; // avoid using main program number for current subprogram
      }
      subprogramCall();
      subprogramState.newSubprogram = true;
      subprogramStart(_initialPosition, _abc, false);
    }
  }
}

/**
 * Determine if this is valid for creating a subprogram
 * @param {Section} section The section to create subprogram
 * @param {number} subprogramId Subprogram Id
 * @param {number} subprogramType Subprogram type, can be SUB_UNKNOWN, SUB_PATTERN or SUB_CYCLE
 * @returns {boolean} If this is valid for creating a subprogram
 */
function subprogramIsValid(_section, subprogramId, subprogramType) {
  var sectionId = _section.getId();
  var numberOfSections = getNumberOfSections();
  var validSubprogram = subprogramType != SUB_CYCLE;

  var masterPosition = new Array();
  masterPosition[0] = getFramePosition(_section.getInitialPosition());
  masterPosition[1] = getFramePosition(_section.getFinalPosition());
  var tempBox = _section.getBoundingBox();
  var masterBox = new Array();
  masterBox[0] = getFramePosition(tempBox[0]);
  masterBox[1] = getFramePosition(tempBox[1]);

  var rotation = getRotation();
  var translation = getTranslation();
  subprogramState.incrementalSubprogram = undefined;

  for (var i = 0; i < numberOfSections; ++i) {
    var section = getSection(i);
    if (section.getId() != sectionId) {
      defineWorkPlane(section, false);

      // check for valid pattern
      if (subprogramType == SUB_PATTERN) {
        if (section.getPatternId() == subprogramId) {
          var patternPosition = new Array();
          patternPosition[0] = getFramePosition(section.getInitialPosition());
          patternPosition[1] = getFramePosition(section.getFinalPosition());
          tempBox = section.getBoundingBox();
          var patternBox = new Array();
          patternBox[0] = getFramePosition(tempBox[0]);
          patternBox[1] = getFramePosition(tempBox[1]);

          if (areSpatialBoxesSame(masterPosition, patternPosition) && areSpatialBoxesSame(masterBox, patternBox) && !section.isMultiAxis()) {
            subprogramState.incrementalSubprogram = subprogramState.incrementalSubprogram ? subprogramState.incrementalSubprogram : false;
          } else if (!areSpatialBoxesTranslated(masterPosition, patternPosition) || !areSpatialBoxesTranslated(masterBox, patternBox)) {
            validSubprogram = false;
            break;
          } else {
            subprogramState.incrementalSubprogram = true;
          }
        }

      // check for valid cycle operation
      } else if (subprogramType == SUB_CYCLE) {
        if ((section.getNumberOfCyclePoints() == subprogramId) && (section.getNumberOfCycles() == 1)) {
          var patternInitial = getFramePosition(section.getInitialPosition());
          var patternFinal = getFramePosition(section.getFinalPosition());
          if (!areSpatialVectorsDifferent(patternInitial, masterPosition[0]) && !areSpatialVectorsDifferent(patternFinal, masterPosition[1])) {
            validSubprogram = true;
            break;
          }
        }
      }
    }
  }
  setRotation(rotation);
  setTranslation(translation);
  return (validSubprogram);
}

/**
 * Sets xyz and abc output formats to incremental or absolute type
 * @param {boolean} incremental true: Sets incremental mode, false: Sets absolute mode
 * @param {Vector} xyz Linear axis values for formating
 * @param {Vector} abc Rotary axis values for formating
*/
function setAbsIncMode(incremental, xyz, abc) {
  var outputFormats = [xOutput, yOutput, zOutput, aOutput, bOutput, cOutput];
  for (var i = 0; i < outputFormats.length; ++i) {
    outputFormats[i].setType(incremental ? TYPE_INCREMENTAL : TYPE_ABSOLUTE);
    if (typeof incPrefix != "undefined" && typeof absPrefix != "undefined") {
      outputFormats[i].setPrefix(incremental ? incPrefix[i] : absPrefix[i]);
    }
    if (i <= 2) { // xyz
      outputFormats[i].setCurrent(xyz.getCoordinate(i));
    } else { // abc
      outputFormats[i].setCurrent(abc.getCoordinate(i - 3));
    }
  }
  subprogramState.incrementalMode = incremental;
  if (typeof gAbsIncModal != "undefined") {
    if (incremental) {
      forceModals(gAbsIncModal);
    }
    writeBlock(gAbsIncModal.format(incremental ? 91 : 90));
  }
}

function setCyclePosition(_position) {
  var _spindleAxis;
  if (typeof gPlaneModal != "undefined") {
    _spindleAxis = gPlaneModal.getCurrent() == 17 ? Z : (gPlaneModal.getCurrent() == 18 ? Y : X);
  } else {
    var _spindleDirection = machineConfiguration.getSpindleAxis().getAbsolute();
    _spindleAxis = isSameDirection(_spindleDirection, new Vector(0, 0, 1)) ? Z : isSameDirection(_spindleDirection, new Vector(0, 1, 0)) ? Y : X;
  }
  switch (_spindleAxis) {
  case Z:
    zOutput.format(_position);
    break;
  case Y:
    yOutput.format(_position);
    break;
  case X:
    xOutput.format(_position);
    break;
  }
}

/**
 * Place cycle operation in subprogram
 * @param {Vector} initialPosition Initial position
 * @param {Vector} abc Machine axis angles
 * @param {boolean} incremental If the subprogram needs to go incremental mode
 */
function handleCycleSubprogram(initialPosition, abc, incremental) {
  subprogramState.cycleSubprogramIsActive &= !(cycleExpanded || isProbeOperation());
  if (subprogramState.cycleSubprogramIsActive) {
    // call subprogram
    subprogramCall();
    subprogramStart(initialPosition, abc, incremental);
  }
}

function writeSubprograms() {
  if (subprogramState.subprograms.length > 0) {
    writeln("");
    write(subprogramState.subprograms);
  }
}
// <<<<< INCLUDED FROM include_files/subprograms.cpi

// >>>>> INCLUDED FROM include_files/onRapid_fanuc.cpi
function onRapid(_x, _y, _z) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      error(localize("Radius compensation mode cannot be changed at rapid traversal."));
      return;
    }
    writeBlock(gMotionModal.format(0), x, y, z);
    forceFeed();
  }
}
// <<<<< INCLUDED FROM include_files/onRapid_fanuc.cpi
// >>>>> INCLUDED FROM include_files/onLinear_fanuc.cpi
function onLinear(_x, _y, _z, feed) {
  if (pendingRadiusCompensation >= 0) {
    xOutput.reset();
    yOutput.reset();
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = getFeed(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      var d = getSetting("outputToolDiameterOffset", true) ? diameterOffsetFormat.format(tool.diameterOffset) : "";
      writeBlock(gPlaneModal.format(17));
      switch (radiusCompensation) {
      case RADIUS_COMPENSATION_LEFT:
        writeBlock(gMotionModal.format(1), gFormat.format(41), x, y, z, d, f);
        break;
      case RADIUS_COMPENSATION_RIGHT:
        writeBlock(gMotionModal.format(1), gFormat.format(42), x, y, z, d, f);
        break;
      default:
        writeBlock(gMotionModal.format(1), gFormat.format(40), x, y, z, f);
      }
    } else {
      writeBlock(gMotionModal.format(1), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gMotionModal.format(1), f);
    }
  }
}
// <<<<< INCLUDED FROM include_files/onLinear_fanuc.cpi
// >>>>> INCLUDED FROM include_files/onRapid5D_fanuc.cpi
function onRapid5D(_x, _y, _z, _a, _b, _c) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode cannot be changed at rapid traversal."));
    return;
  }
  if (!currentSection.isOptimizedForMachine()) {
    forceXYZ();
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = currentSection.isOptimizedForMachine() ? aOutput.format(_a) : toolVectorOutputI.format(_a);
  var b = currentSection.isOptimizedForMachine() ? bOutput.format(_b) : toolVectorOutputJ.format(_b);
  var c = currentSection.isOptimizedForMachine() ? cOutput.format(_c) : toolVectorOutputK.format(_c);

  if (x || y || z || a || b || c) {
    writeBlock(gMotionModal.format(0), x, y, z, a, b, c);
    forceFeed();
  }
}
// <<<<< INCLUDED FROM include_files/onRapid5D_fanuc.cpi
// >>>>> INCLUDED FROM include_files/onLinear5D_fanuc.cpi
function onLinear5D(_x, _y, _z, _a, _b, _c, feed, feedMode) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }
  if (!currentSection.isOptimizedForMachine()) {
    forceXYZ();
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = currentSection.isOptimizedForMachine() ? aOutput.format(_a) : toolVectorOutputI.format(_a);
  var b = currentSection.isOptimizedForMachine() ? bOutput.format(_b) : toolVectorOutputJ.format(_b);
  var c = currentSection.isOptimizedForMachine() ? cOutput.format(_c) : toolVectorOutputK.format(_c);
  if (feedMode == FEED_INVERSE_TIME) {
    forceFeed();
  }
  var f = feedMode == FEED_INVERSE_TIME ? inverseTimeOutput.format(feed) : getFeed(feed);
  var fMode = feedMode == FEED_INVERSE_TIME ? 93 : getProperty("useG95") ? 95 : 94;

  if (x || y || z || a || b || c) {
    writeBlock(gFeedModeModal.format(fMode), gMotionModal.format(1), x, y, z, a, b, c, f);
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(fMode), gMotionModal.format(1), f);
    }
  }
}
// <<<<< INCLUDED FROM include_files/onLinear5D_fanuc.cpi
// >>>>> INCLUDED FROM include_files/onCircular_fanuc.cpi
function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();

  if (isFullCircle()) {
    if (getProperty("useRadius") || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x), jOutput.format(cy - start.y), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x), kOutput.format(cz - start.z), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gMotionModal.format(clockwise ? 2 : 3), jOutput.format(cy - start.y), kOutput.format(cz - start.z), getFeed(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else if (!getProperty("useRadius")) {
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x), jOutput.format(cy - start.y), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x), kOutput.format(cz - start.z), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y), kOutput.format(cz - start.z), getFeed(feed));
      break;
    default:
      if (getProperty("allow3DArcs")) {
        // make sure maximumCircularSweep is well below 360deg
        // we could use G02.4 or G03.4 - direction is calculated
        var ip = getPositionU(0.5);
        writeBlock(gMotionModal.format(clockwise ? 2.4 : 3.4), xOutput.format(ip.x), yOutput.format(ip.y), zOutput.format(ip.z), getFeed(feed));
        writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
      } else {
        linearize(tolerance);
      }
    }
  } else { // use radius mode
    var r = getCircularRadius();
    if (toDeg(getCircularSweep()) > (180 + 1e-9)) {
      r = -r; // allow up to <360 deg arcs
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), getFeed(feed));
      break;
    default:
      if (getProperty("allow3DArcs")) {
        // make sure maximumCircularSweep is well below 360deg
        // we could use G02.4 or G03.4 - direction is calculated
        var ip = getPositionU(0.5);
        writeBlock(gMotionModal.format(clockwise ? 2.4 : 3.4), xOutput.format(ip.x), yOutput.format(ip.y), zOutput.format(ip.z), getFeed(feed));
        writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
      } else {
        linearize(tolerance);
      }
    }
  }
}
// <<<<< INCLUDED FROM include_files/onCircular_fanuc.cpi
// >>>>> INCLUDED FROM include_files/workPlaneFunctions_fanuc.cpi
var gRotationModal = createOutputVariable({current : 69,
  onchange: function () {
    state.twpIsActive = gRotationModal.getCurrent() != 69;
    if (typeof probeVariables != "undefined") {
      probeVariables.outputRotationCodes = probeVariables.probeAngleMethod == "G68";
    }
  }}, gFormat);

var currentWorkPlaneABC = undefined;
function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function cancelWCSRotation() {
  if (typeof gRotationModal != "undefined" && gRotationModal.getCurrent() == 68) {
    cancelWorkPlane(true);
  }
}

function cancelWorkPlane(force) {
  if (typeof gRotationModal != "undefined") {
    if (force) {
      gRotationModal.reset();
    }
    var command = gRotationModal.format(69);
    if (command) {
      writeBlock(command); // cancel frame
      forceWorkPlane();
    }
  }
}

function setWorkPlane(abc) {
  if (!settings.workPlaneMethod.forceMultiAxisIndexing && is3D() && !machineConfiguration.isMultiAxisConfiguration()) {
    return; // ignore
  }
  var workplaneIsRequired = (currentWorkPlaneABC == undefined) ||
    abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
    abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
    abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z);

  writeStartBlocks(workplaneIsRequired, function () {
    writeRetract(Z);
    if (getSetting("retract.homeXY.onIndexing", false)) {
      writeRetract(settings.retract.homeXY.onIndexing);
    }
    if (currentSection.getId() > 0 && (isTCPSupportedByOperation(getSection(currentSection.getId() - 1) || tcp.isSupportedByOperation)) && typeof disableLengthCompensation == "function") {
      disableLengthCompensation(); // cancel TCP
    }

    if (settings.workPlaneMethod.useTiltedWorkplane) {
      onCommand(COMMAND_UNLOCK_MULTI_AXIS);
      cancelWorkPlane();
      if (machineConfiguration.isMultiAxisConfiguration()) {
        var machineABC = abc.isNonZero() ? (currentSection.isMultiAxis() ? getCurrentDirection() : getWorkPlaneMachineABC(currentSection, false)) : abc;
        if (settings.workPlaneMethod.useABCPrepositioning || machineABC.isZero()) {
          positionABC(machineABC, false);
        } else {
          setCurrentABC(machineABC);
        }
      }
      if (abc.isNonZero() || !machineConfiguration.isMultiAxisConfiguration()) {
        gRotationModal.reset();
        writeBlock(
          gRotationModal.format(68.2), "X" + xyzFormat.format(currentSection.workOrigin.x), "Y" + xyzFormat.format(currentSection.workOrigin.y), "Z" + xyzFormat.format(currentSection.workOrigin.z),
          "I" + abcFormat.format(abc.x), "J" + abcFormat.format(abc.y), "K" + abcFormat.format(abc.z)
        ); // set frame
        writeBlock(gFormat.format(53.1)); // turn machine
        machineSimulation({a:getCurrentABC().x, b:getCurrentABC().y, c:getCurrentABC().z, coordinates:MACHINE, eulerAngles:abc});
      }
    } else {
      positionABC(abc, true);
    }
    if (!currentSection.isMultiAxis()) {
      onCommand(COMMAND_LOCK_MULTI_AXIS);
    }
    currentWorkPlaneABC = abc;
  });
}
// <<<<< INCLUDED FROM include_files/workPlaneFunctions_fanuc.cpi
// >>>>> INCLUDED FROM include_files/writeRetract_fanuc.cpi
function writeRetract() {
  var retract = getRetractParameters.apply(this, arguments);
  if (retract && retract.words.length > 0) {
    if (typeof cancelWCSRotation == "function" && getSetting("retract.cancelRotationOnRetracting", false)) { // cancel rotation before retracting
      cancelWCSRotation();
    }
    if (typeof disableLengthCompensation == "function" && getSetting("allowCancelTCPBeforeRetracting", false) && state.tcpIsActive) {
      disableLengthCompensation(); // cancel TCP before retracting
    }
    for (var i in retract.words) {
      var words = retract.singleLine ? retract.words : retract.words[i];
      switch (retract.method) {
      case "G28":
        forceModals(gMotionModal, gAbsIncModal);
        writeBlock(gFormat.format(28), gAbsIncModal.format(91), words);
        writeBlock(gAbsIncModal.format(90));
        break;
      case "G30":
        forceModals(gMotionModal, gAbsIncModal);
        writeBlock(gFormat.format(30), gAbsIncModal.format(91), words);
        writeBlock(gAbsIncModal.format(90));
        break;
      case "G53":
        forceModals(gMotionModal);
        writeBlock(gAbsIncModal.format(90), gFormat.format(53), gMotionModal.format(0), words);
        break;
      default:
        if (typeof writeRetractCustom == "function") {
          writeRetractCustom(retract);
        } else {
          error(subst(localize("Unsupported safe position method '%1'"), retract.method));
          return;
        }
      }
      machineSimulation({
        x          : retract.singleLine || words.indexOf("X") != -1 ? retract.positions.x : undefined,
        y          : retract.singleLine || words.indexOf("Y") != -1 ? retract.positions.y : undefined,
        z          : retract.singleLine || words.indexOf("Z") != -1 ? retract.positions.z : undefined,
        coordinates: MACHINE
      });
      if (retract.singleLine) {
        break;
      }
    }
  }
}
// <<<<< INCLUDED FROM include_files/writeRetract_fanuc.cpi
// >>>>> INCLUDED FROM include_files/initialPositioning_fanuc.cpi
/**
 * Writes the initial positioning procedure for a section to get to the start position of the toolpath.
 * @param {Vector} position The initial position to move to
 * @param {boolean} isRequired true: Output full positioning, false: Output full positioning in optional state or output simple positioning only
 * @param {String} codes1 Allows to add additional code to the first positioning line
 * @param {String} codes2 Allows to add additional code to the second positioning line (if applicable)
 * @example
  var myVar1 = formatWords("T" + tool.number, currentSection.wcs);
  var myVar2 = getCoolantCodes(tool.coolant);
  writeInitialPositioning(initialPosition, isRequired, myVar1, myVar2);
*/
function writeInitialPositioning(position, isRequired, codes1, codes2) {
  var motionCode = {single:0, multi:0};
  switch (highFeedMapping) {
  case HIGH_FEED_MAP_ANY:
    motionCode = {single:1, multi:1}; // map all rapid traversals to high feed
    break;
  case HIGH_FEED_MAP_MULTI:
    motionCode = {single:0, multi:1}; // map rapid traversal along more than one axis to high feed
    break;
  }
  var feed = (highFeedMapping != HIGH_FEED_NO_MAPPING) ? getFeed(highFeedrate) : "";
  var hOffset = getSetting("outputToolLengthOffset", true) ? hFormat.format(tool.lengthOffset) : "";
  var additionalCodes = [formatWords(codes1), formatWords(codes2)];

  forceModals(gMotionModal);
  writeStartBlocks(isRequired, function() {
    var modalCodes = formatWords(gAbsIncModal.format(90), gPlaneModal.format(17));
    if (typeof disableLengthCompensation == "function") {
      disableLengthCompensation(!isRequired); // cancel tool length compensation prior to enabling it, required when switching G43/G43.4 modes
    }

    // multi axis prepositioning with TWP
    if (currentSection.isMultiAxis() && getSetting("workPlaneMethod.prepositionWithTWP", true) && getSetting("workPlaneMethod.useTiltedWorkplane", false) &&
      tcp.isSupportedByOperation && getCurrentDirection().isNonZero()) {
      var W = machineConfiguration.isMultiAxisConfiguration() ? machineConfiguration.getOrientation(getCurrentDirection()) :
        Matrix.getOrientationFromDirection(getCurrentDirection());
      var prePosition = W.getTransposed().multiply(position);
      var angles = W.getEuler2(settings.workPlaneMethod.eulerConvention);
      setWorkPlane(angles);
      writeBlock(modalCodes, gMotionModal.format(motionCode.multi), xOutput.format(prePosition.x), yOutput.format(prePosition.y), feed, additionalCodes[0]);
      machineSimulation({x:prePosition.x, y:prePosition.y});
      cancelWorkPlane();
      writeBlock(getOffsetCode(), hOffset, additionalCodes[1]); // omit Z-axis output is desired
      forceAny(); // required to output XYZ coordinates in the following line
    } else {
      if (machineConfiguration.isHeadConfiguration()) {
        writeBlock(modalCodes, gMotionModal.format(motionCode.multi), getOffsetCode(),
          xOutput.format(position.x), yOutput.format(position.y), zOutput.format(position.z),
          hOffset, feed, additionalCodes
        );
        machineSimulation({x:position.x, y:position.y, z:position.z});
      } else {
        writeBlock(modalCodes, gMotionModal.format(motionCode.multi), xOutput.format(position.x), yOutput.format(position.y), feed, additionalCodes[0]);
        machineSimulation({x:position.x, y:position.y});
        writeBlock(gMotionModal.format(motionCode.single), getOffsetCode(), zOutput.format(position.z), hOffset, additionalCodes[1]);
        machineSimulation(tcp.isSupportedByOperation ? {x:position.x, y:position.y, z:position.z} : {z:position.z});
      }
    }
    forceModals(gMotionModal);
    if (isRequired) {
      additionalCodes = []; // clear additionalCodes buffer
    }
  });

  validate(!validateLengthCompensation || state.lengthCompensationActive, "Tool length compensation is not active."); // make sure that lenght compensation is enabled
  if (!isRequired) { // simple positioning
    var modalCodes = formatWords(gAbsIncModal.format(90), gPlaneModal.format(17));
    if (!state.retractedZ && xyzFormat.getResultingValue(getCurrentPosition().z) < xyzFormat.getResultingValue(position.z)) {
      writeBlock(modalCodes, gMotionModal.format(motionCode.single), zOutput.format(position.z), feed);
      machineSimulation({z:position.z});
    }
    forceXYZ();
    writeBlock(modalCodes, gMotionModal.format(motionCode.multi), xOutput.format(position.x), yOutput.format(position.y), feed, additionalCodes);
    machineSimulation({x:position.x, y:position.y});
  }
}

Matrix.getOrientationFromDirection = function (ijk) {
  var forward = ijk;
  var unitZ = new Vector(0, 0, 1);
  var W;
  if (Math.abs(Vector.dot(forward, unitZ)) < 0.5) {
    var imX = Vector.cross(forward, unitZ).getNormalized();
    W = new Matrix(imX, Vector.cross(forward, imX), forward);
  } else {
    var imX = Vector.cross(new Vector(0, 1, 0), forward).getNormalized();
    W = new Matrix(imX, Vector.cross(forward, imX), forward);
  }
  return W;
};
// <<<<< INCLUDED FROM include_files/initialPositioning_fanuc.cpi
// >>>>> INCLUDED FROM include_files/getOffsetCode_fanuc.cpi
var toolLengthCompOutput = createOutputVariable({control : CONTROL_FORCE,
  onchange: function() {
    state.tcpIsActive = toolLengthCompOutput.getCurrent() == 43.4 || toolLengthCompOutput.getCurrent() == 43.5;
    state.lengthCompensationActive = toolLengthCompOutput.getCurrent() != 49;
  }
}, gFormat);

function getOffsetCode() {
  if (!getSetting("outputToolLengthCompensation", true) && toolLengthCompOutput.isEnabled()) {
    state.lengthCompensationActive = true; // always assume that length compensation is active
    toolLengthCompOutput.disable();
  }
  var offsetCode = 43;
  if (tcp.isSupportedByOperation) {
    offsetCode = machineConfiguration.isMultiAxisConfiguration() ? 43.4 : 43.5;
  }
  return toolLengthCompOutput.format(offsetCode);
}
// <<<<< INCLUDED FROM include_files/getOffsetCode_fanuc.cpi
// >>>>> INCLUDED FROM include_files/disableLengthCompensation_fanuc.cpi
function disableLengthCompensation(force) {
  if (state.lengthCompensationActive || force) {
    if (force) {
      toolLengthCompOutput.reset();
    }
    if (!getSetting("allowCancelTCPBeforeRetracting", false)) {
      validate(state.retractedZ, "Cannot cancel tool length compensation if the machine is not fully retracted.");
    }
    writeBlock(toolLengthCompOutput.format(49));
  }
}
// <<<<< INCLUDED FROM include_files/disableLengthCompensation_fanuc.cpi
// >>>>> INCLUDED FROM include_files/getProgramNumber_fanuc.cpi
function getProgramNumber() {
  if (typeof oFormat != "undefined" && getProperty("o8")) {
    oFormat.setMinDigitsLeft(8);
  }
  var minimumProgramNumber = getSetting("programNumber.min", 1);
  var maximumProgramNumber = getSetting("programNumber.max", getProperty("o8") ? 99999999 : 9999);
  var reservedProgramNumbers = getSetting("programNumber.reserved", [8000, 9999]);
  if (programName) {
    var _programNumber;
    try {
      _programNumber = getAsInt(programName);
    } catch (e) {
      error(localize("Program name must be a number."));
    }
    if (!((_programNumber >= minimumProgramNumber) && (_programNumber <= maximumProgramNumber))) {
      error(subst(localize("Program number '%1' is out of range. Please enter a program number between '%2' and '%3'."), _programNumber, minimumProgramNumber, maximumProgramNumber));
    }
    if ((_programNumber >= reservedProgramNumbers[0]) && (_programNumber <= reservedProgramNumbers[1])) {
      warning(subst(localize("Program number '%1' is potentially reserved by the machine tool builder. Reserved range is '%2' to '%3'."), _programNumber, reservedProgramNumbers[0], reservedProgramNumbers[1]));
    }
  } else {
    error(localize("Program name has not been specified."));
  }
  return _programNumber;
}
// <<<<< INCLUDED FROM include_files/getProgramNumber_fanuc.cpi
// >>>>> INCLUDED FROM include_files/drillCycles_fanuc.cpi
function writeDrillCycle(cycle, x, y, z) {
  if (!isSameDirection(machineConfiguration.getSpindleAxis(), getForwardDirection(currentSection))) {
    expandCyclePoint(x, y, z);
    return;
  }
  if (isFirstCyclePoint()) {
    // return to initial Z which is clearance plane and set absolute mode
    repositionToCycleClearance(cycle, x, y, z);

    var F = getProperty("useG95") ? (cycle.feedrate / spindleSpeed) : cycle.feedrate;
    var P = !cycle.dwell ? 0 : clamp(1, cycle.dwell * 1000, 99999999); // in milliseconds
    switch (cycleType) {
    case "drilling":
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(81),
        getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
        feedOutput.format(F)
      );
      break;
    case "counter-boring":
      if (P > 0) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(82),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(81),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
      }
      break;
    case "chip-breaking":
      if ((cycle.accumulatedDepth < cycle.depth) || (P > 0)) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(73),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          peckOutput.format(cycle.incrementalDepth),
          feedOutput.format(F)
        );
      }
      break;
    case "deep-drilling":
      if (P > 0) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(83),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          peckOutput.format(cycle.incrementalDepth),
          // conditional(P > 0, "P" + milliFormat.format(P)),
          feedOutput.format(F)
        );
      }
      break;
    case "tapping":
      if (getProperty("useRigidTapping") != "no") {
        writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
      }
      if (getProperty("usePitchForTapping")) {
        writeBlock(
          gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          pitchOutput.format(tool.threadPitch)
        );
        forceFeed();
      } else {
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95") ? tool.getThreadPitch() : tappingFPM);
        writeBlock(
          gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      }
      break;
    case "left-tapping":
      if (getProperty("useRigidTapping") != "no") {
        writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
      }
      if (getProperty("usePitchForTapping")) {
        writeBlock(
          gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          pitchOutput.format(tool.threadPitch)
        );
        forceFeed();
      } else {
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95") ? tool.getThreadPitch() : tappingFPM);
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      }
      break;
    case "right-tapping":
      if (getProperty("useRigidTapping") != "no") {
        writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
      }
      if (getProperty("usePitchForTapping")) {
        writeBlock(
          gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format(84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          pitchOutput.format(tool.threadPitch)
        );
        forceFeed();
      } else {
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (getProperty("useG95") ? tool.getThreadPitch() : tappingFPM);
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      }
      break;
    case "tapping-with-chip-breaking":
    case "left-tapping-with-chip-breaking":
    case "right-tapping-with-chip-breaking":
      if (cycle.accumulatedDepth < cycle.depth) {
        error(localize("Accumulated pecking depth is not supported for tapping cycles with chip breaking."));
        return;
      } else {
        if (getProperty("useRigidTapping") != "no") {
          writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
        }
        if (getProperty("usePitchForTapping")) {
          writeBlock(
            gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84)),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            peckOutput.format(cycle.incrementalDepth),
            pitchOutput.format(tool.threadPitch)
          );
          forceFeed();
        } else {
          var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
          F = (getProperty("useG95") ? tool.getThreadPitch() : tappingFPM);
          writeBlock(
            gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84)),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            peckOutput.format(cycle.incrementalDepth),
            feedOutput.format(F)
          );
        }
      }
      break;
    case "fine-boring":
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(76),
        getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
        "P" + milliFormat.format(P), // not optional
        "Q" + xyzFormat.format(cycle.shift),
        feedOutput.format(F)
      );
      break;
    case "back-boring":
      var dx = (gPlaneModal.getCurrent() == 19) ? cycle.backBoreDistance : 0;
      var dy = (gPlaneModal.getCurrent() == 18) ? cycle.backBoreDistance : 0;
      var dz = (gPlaneModal.getCurrent() == 17) ? cycle.backBoreDistance : 0;
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(87),
        getCommonCycle(x - dx, y - dy, z - dz, cycle.bottom, cycle.clearance),
        "Q" + xyzFormat.format(cycle.shift),
        "P" + milliFormat.format(P), // not optional
        feedOutput.format(F)
      );
      break;
    case "reaming":
      if (feedFormat.getResultingValue(cycle.feedrate) != feedFormat.getResultingValue(cycle.retractFeedrate)) {
        expandCyclePoint(x, y, z);
        break;
      }
      if (P > 0) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
      }
      break;
    case "stop-boring":
      if (P > 0) {
        expandCyclePoint(x, y, z);
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(86),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
      }
      break;
    case "manual-boring":
      writeBlock(
        gRetractModal.format(98), gCycleModal.format(88),
        getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
        "P" + milliFormat.format(P), // not optional
        feedOutput.format(F)
      );
      break;
    case "boring":
      if (feedFormat.getResultingValue(cycle.feedrate) != feedFormat.getResultingValue(cycle.retractFeedrate)) {
        expandCyclePoint(x, y, z);
        break;
      }
      if (P > 0) {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(89),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P), // not optional
          feedOutput.format(F)
        );
      } else {
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(85),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          feedOutput.format(F)
        );
      }
      break;
    default:
      expandCyclePoint(x, y, z);
    }
    if (subprogramsAreSupported()) {
      // place cycle operation in subprogram
      handleCycleSubprogram(new Vector(x, y, z), new Vector(0, 0, 0), false);
      if (subprogramState.incrementalMode) { // set current position to clearance height
        setCyclePosition(cycle.clearance);
      }
    }
  } else {
    if (cycleExpanded) {
      expandCyclePoint(x, y, z);
    } else {
      if (!xyzFormat.areDifferent(x, xOutput.getCurrent()) &&
          !xyzFormat.areDifferent(y, yOutput.getCurrent()) &&
          !xyzFormat.areDifferent(z, zOutput.getCurrent())) {
        switch (gPlaneModal.getCurrent()) {
        case 17: // XY
          xOutput.reset(); // at least one axis is required
          break;
        case 18: // ZX
          zOutput.reset(); // at least one axis is required
          break;
        case 19: // YZ
          yOutput.reset(); // at least one axis is required
          break;
        }
      }
      if (subprogramsAreSupported() && subprogramState.incrementalMode) { // set current position to retract height
        setCyclePosition(cycle.retract);
      }
      writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
      if (subprogramsAreSupported() && subprogramState.incrementalMode) { // set current position to clearance height
        setCyclePosition(cycle.clearance);
      }
    }
  }
}

function getCommonCycle(x, y, z, r, c) {
  forceXYZ(); // force xyz on first drill hole of any cycle
  if (subprogramsAreSupported() && subprogramState.incrementalMode) {
    zOutput.format(c);
    return [xOutput.format(x), yOutput.format(y),
      "Z" + xyzFormat.format(z - r),
      "R" + xyzFormat.format(r - c)];
  } else {
    return [xOutput.format(x), yOutput.format(y),
      zOutput.format(z),
      "R" + xyzFormat.format(r)];
  }
}
// <<<<< INCLUDED FROM include_files/drillCycles_fanuc.cpi
// >>>>> INCLUDED FROM include_files/commonInspectionFunctions_fanuc.cpi
var macroFormat = createFormat({prefix:(typeof inspectionVariables == "undefined" ? "#" : inspectionVariables.localVariablePrefix), decimals:0});
var macroRoundingFormat =  (unit == MM) ? "[53]" : "[44]";
var isDPRNTopen = false;

var WARNING_OUTDATED = 0;
var toolpathIdFormat = createFormat({decimals:5, forceDecimal:true});
var patternInstances = new Array();
var initializePatternInstances = true; // initialize patternInstances array the first time inspectionGetToolpathId is called
function inspectionGetToolpathId(section) {
  if (initializePatternInstances) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var _section = getSection(i);
      if (_section.getInternalPatternId) {
        var sectionId = _section.getId();
        var patternId = _section.getInternalPatternId();
        var isPatterned = _section.isPatterned && _section.isPatterned();
        var isMirrored = patternId != _section.getPatternId();
        if (isPatterned || isMirrored) {
          var isKnownPatternId = false;
          for (var j = 0; j < patternInstances.length; j++) {
            if (patternId == patternInstances[j].patternId) {
              patternInstances[j].patternIndex++;
              patternInstances[j].sections.push(sectionId);
              isKnownPatternId = true;
              break;
            }
          }
          if (!isKnownPatternId) {
            patternInstances.push({patternId:patternId, patternIndex:1, sections:[sectionId]});
          }
        }
      }
    }
    initializePatternInstances = false;
  }

  var _operationId = section.getParameter("autodeskcam:operation-id", "");
  var key = -1;
  for (k in patternInstances) {
    if (patternInstances[k].patternId == _operationId) {
      key = k;
      break;
    }
  }
  var _patternId = (key > -1) ? patternInstances[key].sections.indexOf(section.getId()) + 1 : 0;
  var _cycleId = cycle && ("cycleID" in cycle) ? cycle.cycleID : section.getParameter("cycleID", 0);
  if (isProbeOperation(section) && _cycleId == 0 && getGlobalParameter("product-id").toLowerCase().indexOf("fusion") > -1) {
    // we expect the cycleID to be non zero always for macro probing toolpaths, Fusion only
    warningOnce(localize("Outdated macro probing operations detected. Please regenerate all macro probing operations."), WARNING_OUTDATED);
  }
  if (_patternId > 99) {
    error(subst(localize("The maximum number of pattern instances is limited to 99" + EOL +
      "You need to split operation '%1' into separate pattern groups."
    ), section.getParameter("operation-comment", "")));
  }
  if (_cycleId > 99) {
    error(subst(localize("The maximum number of probing cycles is limited to 99" + EOL +
      "You need to split operation '%1' to multiple operations with less than 100 cycles in each operation."
    ), section.getParameter("operation-comment", "")));
  }
  return toolpathIdFormat.format(_operationId + (_cycleId * 0.01) + (_patternId * 0.0001) + 0.00001);
}

var localVariableStart = 19;
var localVariable = [
  macroFormat.format(localVariableStart + 1),
  macroFormat.format(localVariableStart + 2),
  macroFormat.format(localVariableStart + 3),
  macroFormat.format(localVariableStart + 4),
  macroFormat.format(localVariableStart + 5),
  macroFormat.format(localVariableStart + 6)
];

function defineLocalVariable(indx, value) {
  writeln(localVariable[indx - 1] + " = " + value);
}

function formatLocalVariable(prefix, indx, rnd) {
  return prefix + localVariable[indx - 1] + rnd;
}

function inspectionCreateResultsFileHeader() {
  if (isDPRNTopen) {
    if (!getProperty("singleResultsFile")) {
      writeln("DPRNT[END]");
      writeBlock("PCLOS");
      isDPRNTopen = false;
    }
  }

  if (isProbeOperation() && !printProbeResults()) {
    return; // if print results is not desired by probe/ probeWCS
  }

  if (!isDPRNTopen) {
    writeBlock("PCLOS");
    writeBlock("POPEN");
    // check for existence of none alphanumeric characters but not spaces
    var resFile;
    if (getProperty("singleResultsFile")) {
      resFile = getParameter("job-description") + "-RESULTS";
    } else {
      resFile = getParameter("operation-comment") + "-RESULTS";
    }
    resFile = resFile.replace(/:/g, "-");
    resFile = resFile.replace(/[^a-zA-Z0-9 -]/g, "");
    resFile = resFile.replace(/\s/g, "-");
    resFile = resFile.toUpperCase();
    writeln("DPRNT[START]");
    writeln("DPRNT[RESULTSFILE*" + resFile + "]");
    if (hasGlobalParameter("document-id")) {
      writeln("DPRNT[DOCUMENTID*" + getGlobalParameter("document-id").toUpperCase() + "]");
    }
    if (hasGlobalParameter("model-version")) {
      writeln("DPRNT[MODELVERSION*" + getGlobalParameter("model-version").toUpperCase() + "]");
    }
  }
  if (isProbeOperation() && printProbeResults()) {
    isDPRNTopen = true;
  }
}

function getPointNumber() {
  if (typeof inspectionWriteVariables == "function") {
    return (inspectionVariables.pointNumber);
  } else {
    return ("#122[60]");
  }
}

function inspectionWriteCADTransform() {
  var cadOrigin = currentSection.getModelOrigin();
  var cadWorkPlane = currentSection.getModelPlane().getTransposed();
  var cadEuler = cadWorkPlane.getEuler2(EULER_XYZ_S);
  defineLocalVariable(1, abcFormat.format(cadEuler.x));
  defineLocalVariable(2, abcFormat.format(cadEuler.y));
  defineLocalVariable(3, abcFormat.format(cadEuler.z));
  defineLocalVariable(4, xyzFormat.format(-cadOrigin.x));
  defineLocalVariable(5, xyzFormat.format(-cadOrigin.y));
  defineLocalVariable(6, xyzFormat.format(-cadOrigin.z));
  writeln(
    "DPRNT[G331" +
    "*N" + getPointNumber() +
    formatLocalVariable("*A", 1, macroRoundingFormat) +
    formatLocalVariable("*B", 2, macroRoundingFormat) +
    formatLocalVariable("*C", 3, macroRoundingFormat) +
    formatLocalVariable("*X", 4, macroRoundingFormat) +
    formatLocalVariable("*Y", 5, macroRoundingFormat) +
    formatLocalVariable("*Z", 6, macroRoundingFormat) +
    "]"
  );
}

function inspectionWriteWorkplaneTransform() {
  var orientation = machineConfiguration.isMultiAxisConfiguration() ? machineConfiguration.getOrientation(getCurrentDirection()) : currentSection.workPlane;
  var abc = orientation.getEuler2(EULER_XYZ_S);
  if (getProperty("useLiveConnection")) {
    liveConnectorInterface("WORKPLANE");
    writeBlock(inspectionVariables.liveConnectionWPA, "=", abcFormat.format(abc.x));
    writeBlock(inspectionVariables.liveConnectionWPB, "=", abcFormat.format(abc.y));
    writeBlock(inspectionVariables.liveConnectionWPC, "=", abcFormat.format(abc.z));
    forceSequenceNumbers(true);
    writeBlock("IF [" + inspectionVariables.workplaneStartAddress, "NE -1] GOTO" + skipNLines(2));
    writeBlock(inspectionVariables.workplaneStartAddress, "=", inspectionGetToolpathId(currentSection));
    writeBlock(" ");
    forceSequenceNumbers(false);
  }

  defineLocalVariable(1, abcFormat.format(abc.x));
  defineLocalVariable(2, abcFormat.format(abc.y));
  defineLocalVariable(3, abcFormat.format(abc.z));
  writeln("DPRNT[G330" +
    "*N" + getPointNumber() +
    formatLocalVariable("*A", 1, macroRoundingFormat) +
    formatLocalVariable("*B", 2, macroRoundingFormat) +
    formatLocalVariable("*C", 3, macroRoundingFormat) +
    "*X0*Y0*Z0*I0*R0]"
  );
}

function writeProbingToolpathInformation(cycleDepth) {
  defineLocalVariable(1, inspectionGetToolpathId(currentSection));
  writeln(formatLocalVariable("DPRNT[TOOLPATHID*", 1, "[35]]"));
  if (isInspectionOperation()) {
    writeln("DPRNT[TOOLPATH*" + getParameter("operation-comment").toUpperCase().replace(/[()]/g, "") + "]");
  } else {
    defineLocalVariable(2, xyzFormat.format(cycleDepth));
    writeln(formatLocalVariable("DPRNT[CYCLEDEPTH*", 2, macroRoundingFormat + "]"));
  }
}
// <<<<< INCLUDED FROM include_files/commonInspectionFunctions_fanuc.cpi
// >>>>> INCLUDED FROM include_files/probeCycles_renishaw.cpi
validate(settings.probing, "Setting 'probing' is required but not defined.");
var probeVariables = {
  outputRotationCodes: false, // determines if it is required to output rotation codes
  compensationXY     : undefined,
  probeAngleMethod   : undefined,
  rotaryTableAxis    : -1
};
function writeProbeCycle(cycle, x, y, z, P, F) {
  var openString = "OPEN[0,1,\"" + programName + "_inspection_report" + "_@980" + "_@981" + "_@982" + "_@983" + "_@984" + "_@985" + "\"]";
  if (isProbeOperation()) {
    if (!settings.workPlaneMethod.useTiltedWorkplane && !isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1))) {
      if (!settings.probing.allowIndexingWCSProbing && currentSection.strategy == "probe") {
        error(localize("Updating WCS / work offset using probing is only supported by the CNC in the WCS frame."));
        return;
      }
    }
    if (printProbeResults()) {
      writeProbingToolpathInformation(z - cycle.depth + tool.diameter / 2);
      inspectionWriteCADTransform();
      inspectionWriteWorkplaneTransform();
      if (typeof inspectionWriteVariables == "function") {
        inspectionVariables.pointNumber += 1;
      }
    }
    protectedProbeMove(cycle, x, y, z);
  }

  var macroCall = settings.probing.macroCall;
  switch (cycleType) {
  case "probing-x":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE   = getProbingArguments(cycle, probeWorkOffsetCode);
    EXPECTED_Y = yOutput.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2));
    EXPECTED_X = xOutput.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2));
    EXPECTED_Z = "Z" + xyzFormat.format(cycle.stock - cycle.depth);
    DISTANCE   = approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2 + cycle.probeOvertravel);
    B_ARG      = "B" + xyzFormat.format(DISTANCE);

    writeBlock(macroCall, "\"PROBEX\"", WCS_CODE[7], WCS_CODE[8], B_ARG);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V1", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"PROBED X POINT: @996\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-y":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE   = getProbingArguments(cycle, probeWorkOffsetCode);
    EXPECTED_Y = yOutput.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2));
    EXPECTED_X = xOutput.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2));
    EXPECTED_Z = "Z" + xyzFormat.format(cycle.stock - cycle.depth);
    DISTANCE   = approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2 + cycle.probeOvertravel);
    B_ARG      = "B" + xyzFormat.format(DISTANCE);

    writeBlock(macroCall, "\"PROBEY\"", WCS_CODE[7], WCS_CODE[8], B_ARG);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V2", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"PROBED Y POINT: @996\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-z":
    forceXYZ();
    protectedProbeMove(cycle, x, y, Math.min(z - cycle.depth + cycle.probeClearance, cycle.retract));

    WCS_CODE    = getProbingArguments(cycle, probeWorkOffsetCode);
    EXPECTED_X  = xOutput.format(x);
    EXPECTED_Y  = yOutput.format(y);
    EXPECTED_Z  = "Z" + xyzFormat.format(cycle.stock - cycle.depth);
    B_ARG       = "B" + xyzFormat.format(-cycle.depth - cycle.probeOvertravel);

    writeBlock(macroCall, "\"PROBEZ\"", WCS_CODE[7], WCS_CODE[8], B_ARG);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V3", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"PROBED Z POINT: @996\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-x-wall":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z);
    WCS_CODE  = getProbingArguments(cycle, probeWorkOffsetCode);
    WEB_WIDTH = "B" + xyzFormat.format(cycle.width1);
    Z_DROP    = "C" + xyzFormat.format(cycle.depth);

    writeBlock(macroCall, "\"PROBEXWEB\"", WCS_CODE[7], WCS_CODE[8], WEB_WIDTH, Z_DROP, "Q0", WCS_CODE[2]);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED X WEB WIDTH: @998\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-y-wall":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z);

    WCS_CODE  = getProbingArguments(cycle, probeWorkOffsetCode);
    WEB_WIDTH = "B" + xyzFormat.format(cycle.width1);
    Z_DROP    = "C" + xyzFormat.format(cycle.depth);

    writeBlock(macroCall, "\"PROBEYWEB\"", WCS_CODE[7], WCS_CODE[8], WEB_WIDTH, Z_DROP, "Q0", WCS_CODE[2]);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED Y WEB WIDTH: @999\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-x-channel":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE   = getProbingArguments(cycle, probeWorkOffsetCode);
    SLOT_WIDTH = "B" + xyzFormat.format(cycle.width1);

    writeBlock(macroCall, "\"PROBEXSLOT\"", WCS_CODE[7], WCS_CODE[8], SLOT_WIDTH, "Q0", WCS_CODE[2]);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED X SLOT WIDTH: @998\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-x-channel-with-island":
    error(localize("probing-x-channel-with-island is unsupported"));
    /*protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9812,
      "X" + xyzFormat.format(cycle.width1),
      zOutput.format(z - cycle.depth),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(-cycle.probeClearance),
      getProbingArguments(cycle, true)
    ); */
    break;
  case "probing-y-channel":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE   = getProbingArguments(cycle, probeWorkOffsetCode);
    SLOT_WIDTH = "B" + xyzFormat.format(cycle.width1);

    writeBlock(macroCall, "\"PROBEYSLOT\"", WCS_CODE[7], WCS_CODE[8], SLOT_WIDTH, "Q0", WCS_CODE[2]);

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED Y SLOT WIDTH: @999\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-y-channel-with-island":
    error(localize("probing-y-channel-with-island is unsupported"));
    /*protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9812,
      "Y" + xyzFormat.format(cycle.width1),
      zOutput.format(z - cycle.depth),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(-cycle.probeClearance),
      getProbingArguments(cycle, true)
    ); */
    break;
  case "probing-xy-circular-boss":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z);

    WCS_CODE      = getProbingArguments(cycle, probeWorkOffsetCode);
    BOSS_DIAMETER = "B" + xyzFormat.format(cycle.width1);
    Z_DROP        = "C" + xyzFormat.format(cycle.depth);
    EXPECTED_X    = xOutput.format(x);
    EXPECTED_Y    = yOutput.format(y);
    EXPECTED_Z    = "Z" + xyzFormat.format(cycle.stock - cycle.depth);

    writeBlock(macroCall, "\"PROBECIRCULARBOSS\"", WCS_CODE[7], WCS_CODE[8], BOSS_DIAMETER, Z_DROP, "Q0", WCS_CODE[2]);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V4", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    if (getProperty("EnableZeroPointCompensation") == true && WCS_CODE[7] === null) {
      writeBlock(macroCall, "\"COMPZEROPOINT\"", WCS_CODE[8], WCS_CODE[9], EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    }

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED CIRCULAR BOSS DIAMETER IN X: @998\"]");
      writeBlock("PRINT[\"MEASURED CIRCULAR BOSS DIAMETER IN Y: @999\"]");
      writeBlock("PRINT[\"MEASURED CIRCULAR BOSS AVG DIAMETER : @997\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-xy-circular-partial-boss":
    error(localize("probing-xy-circular-partial-boss is unsupported"));
    /*protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9823,
      "A" + xyzFormat.format(cycle.partialCircleAngleA),
      "B" + xyzFormat.format(cycle.partialCircleAngleB),
      "C" + xyzFormat.format(cycle.partialCircleAngleC),
      "D" + xyzFormat.format(cycle.width1),
      "Z" + xyzFormat.format(z - cycle.depth),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(cycle.probeClearance),
      getProbingArguments(cycle, true)
    ); */
    break;
  case "probing-xy-circular-hole":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE      = getProbingArguments(cycle, probeWorkOffsetCode);
    BORE_DIAMETER = "B" + xyzFormat.format(cycle.width1);
    EXPECTED_X    = xOutput.format(x);
    EXPECTED_Y    = yOutput.format(y);
    EXPECTED_Z    = "Z" + xyzFormat.format(cycle.stock - cycle.depth);

    writeBlock(macroCall, "\"PROBEBORE\"", WCS_CODE[7], WCS_CODE[8], BORE_DIAMETER, "Q0", WCS_CODE[2]);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V4", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    if (getProperty("EnableZeroPointCompensation") == true && WCS_CODE[7] === null) {
      writeBlock(macroCall, "\"COMPZEROPOINT\"", WCS_CODE[8], WCS_CODE[9], EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    }

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED BORE DIAMETER IN X: @998\"]");
      writeBlock("PRINT[\"MEASURED BORE DIAMETER IN Y: @999\"]");
      writeBlock("PRINT[\"MEASURED BORE AVG DIAMETER : @997\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-xy-circular-partial-hole":
    error(localize("probing-xy-circular-partial-hole is unsupported"));
    /* protectedProbeMove(cycle, x, y, z - cycle.depth);
    writeBlock(
      macroCall, "P" + 9823,
      "A" + xyzFormat.format(cycle.partialCircleAngleA),
      "B" + xyzFormat.format(cycle.partialCircleAngleB),
      "C" + xyzFormat.format(cycle.partialCircleAngleC),
      "D" + xyzFormat.format(cycle.width1),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      getProbingArguments(cycle, true)
    ); */
    break;
  case "probing-xy-circular-hole-with-island":
    error(localize("probing-xy-circular-hole-with-island is unsupported"));
    /* protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9814,
      "Z" + xyzFormat.format(z - cycle.depth),
      "D" + xyzFormat.format(cycle.width1),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(-cycle.probeClearance),
      getProbingArguments(cycle, true)
    ); */
    break;
  case "probing-xy-circular-partial-hole-with-island":
    error(localize("probing-xy-circular-partial-hole-with-island is unsupported"));
    /* protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9823,
      "Z" + xyzFormat.format(z - cycle.depth),
      "A" + xyzFormat.format(cycle.partialCircleAngleA),
      "B" + xyzFormat.format(cycle.partialCircleAngleB),
      "C" + xyzFormat.format(cycle.partialCircleAngleC),
      "D" + xyzFormat.format(cycle.width1),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(-cycle.probeClearance),
      getProbingArguments(cycle, true)
    ); */
    break;
  case "probing-xy-rectangular-hole":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE   = getProbingArguments(cycle, probeWorkOffsetCode);
    XWEB_WIDTH = "B" + xyzFormat.format(cycle.width1);
    YWEB_WIDTH = "C" + xyzFormat.format(cycle.width2);
    EXPECTED_X = xOutput.format(x);
    EXPECTED_Y = yOutput.format(y);
    EXPECTED_Z = "Z" + xyzFormat.format(cycle.stock - cycle.depth);

    writeBlock(macroCall, "\"PROBEPOCKET\"", WCS_CODE[7], WCS_CODE[8], XWEB_WIDTH, YWEB_WIDTH, "Q0", WCS_CODE[2]);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V4", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    if (getProperty("EnableZeroPointCompensation") == true && WCS_CODE[7] === null) {
      writeBlock(macroCall, "\"COMPZEROPOINT\"", WCS_CODE[8], WCS_CODE[9], EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    }

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED POCKET LENGTH IN X: @998\"]");
      writeBlock("PRINT[\"MEASURED POCKET WIDTH IN Y: @999\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-xy-rectangular-boss":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z);

    WCS_CODE   = getProbingArguments(cycle, probeWorkOffsetCode);
    XWEB_WIDTH = "B" + xyzFormat.format(cycle.width1);
    YWEB_WIDTH = "C" + xyzFormat.format(cycle.width2);
    EXPECTED_X = xOutput.format(x);
    EXPECTED_Y = yOutput.format(y);
    EXPECTED_Z = "Z" + xyzFormat.format(cycle.stock - cycle.depth);
    Z_DROP     = "D" + xyzFormat.format(cycle.depth);

    writeBlock(macroCall, "\"PROBERECTANGULARBOSS\"", WCS_CODE[7], WCS_CODE[8], XWEB_WIDTH, YWEB_WIDTH, Z_DROP, "Q0", WCS_CODE[2]);
    writeBlock(macroCall, "\"CHECKPOSITIONALTOLERANCE\"", WCS_CODE[8], WCS_CODE[9], WCS_CODE[3], "V4", EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    if (getProperty("EnableZeroPointCompensation") == true && WCS_CODE[7] === null) {
      writeBlock(macroCall, "\"COMPZEROPOINT\"", WCS_CODE[8], WCS_CODE[9], EXPECTED_X, EXPECTED_Y, EXPECTED_Z);
    }

    if (WCS_CODE[7] === "I1.") {
      writeBlock(openString);
      writeBlock("PRINT[\"MEASURED RECTANGULAR BOSS LENGTH IN X: @998\"]");
      writeBlock("PRINT[\"MEASURED RECTANGULAR BOSS WIDTH IN Y: @999\"]");
      writeBlock("CLOSE[]");
    }
    break;
  case "probing-xy-rectangular-hole-with-island":
    error(localize("probing-xy-rectangular-hole-with-island is unsupported"));
    /* protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9812,
      "Z" + xyzFormat.format(z - cycle.depth),
      "X" + xyzFormat.format(cycle.width1),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(-cycle.probeClearance),
      getProbingArguments(cycle, true)
    );
    if (getProperty("useLiveConnection") && (typeof liveConnectionStoreResults == "function")) {
      liveConnectionStoreResults();
    }
    writeBlock(
      macroCall, "P" + 9812,
      "Z" + xyzFormat.format(z - cycle.depth),
      "Y" + xyzFormat.format(cycle.width2),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(-cycle.probeClearance),
      getProbingArguments(cycle, true)
    ); */
    break;

  case "probing-xy-inner-corner":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);

    WCS_CODE         = getProbingArguments(cycle, probeWorkOffsetCode);
    CORNER_POSITION  = "B" + xyzFormat.format(cycle.width1);
    PROBING_DISTANCE = "C" + xyzFormat.format(cycle.width2);

    writeBlock(macroCall, "\"PROBEINSIDECORNER\"", WCS_CODE[8], CORNER_POSITION, PROBING_DISTANCE, "Q0");
    break;
  case "probing-xy-outer-corner":
    forceXYZ();
    protectedProbeMove(cycle, x, y, z - cycle.depth);
    xdir =  approach(cycle.approach1);
    ydir =  approach(cycle.approach2);
    var CORNER_NUM = 0;
    if (xdir == 1 && ydir == 1) {CORNER_NUM = 3;} else if (xdir == 1 && ydir == -1) {CORNER_NUM = 1;} else if (xdir == -1 && ydir == 1) {CORNER_NUM = 4;} else if (xdir == -1 && ydir == -1) {CORNER_NUM = 2;}

    WCS_CODE         = getProbingArguments(cycle, probeWorkOffsetCode);
    CORNER_POSITION  = "B" + CORNER_NUM;
    TRAVEL_DISTANCE  = "C" + xyzFormat.format(2 * cycle.probeClearance + tool.diameter / 2);
    PROBING_DISTANCE = "D" + xyzFormat.format(cycle.probeClearance + cycle.probeOvertravel);

    writeBlock(macroCall, "\"PROBEOUTSIDECORNER\"",
      WCS_CODE[8],
      CORNER_POSITION,
      TRAVEL_DISTANCE,
      PROBING_DISTANCE, "Q0");
    break;
  case "probing-x-plane-angle":
    error(localize("probing-x-plane-angle - Unsupported Probing Cycle"));
    /*protectedProbeMove(cycle, x, y, z - cycle.depth);
    writeBlock(
      macroCall, "P" + 9843,
      "X" + xyzFormat.format(x + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
      "D" + xyzFormat.format(cycle.probeSpacing),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "A" + xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 90),
      getProbingArguments(cycle, false)
    );
    if (currentSection.strategy == "probe") {
      setProbeAngleMethod();
      probeVariables.compensationXY = "X" + xyzFormat.format(0) + " Y" + xyzFormat.format(0);
    } */
    break;
  case "probing-y-plane-angle":
    error(localize("probing-y-plane-angle - Unsupported Probing Cycle"));
    /* protectedProbeMove(cycle, x, y, z - cycle.depth);
    writeBlock(
      macroCall, "P" + 9843,
      "Y" + xyzFormat.format(y + approach(cycle.approach1) * (cycle.probeClearance + tool.diameter / 2)),
      "D" + xyzFormat.format(cycle.probeSpacing),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "A" + xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 0),
      getProbingArguments(cycle, false)
    );
    if (currentSection.strategy == "probe") {
      setProbeAngleMethod();
      probeVariables.compensationXY = "X" + xyzFormat.format(0) + " Y" + xyzFormat.format(0);
    } */
    break;
  case "probing-xy-pcd-hole":
    error(localize("probing-xy-pcd-hole - Unsupported Probing Cycle"));
    /* protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9819,
      "A" + xyzFormat.format(cycle.pcdStartingAngle),
      "B" + xyzFormat.format(cycle.numberOfSubfeatures),
      "C" + xyzFormat.format(cycle.widthPCD),
      "D" + xyzFormat.format(cycle.widthFeature),
      "K" + xyzFormat.format(z - cycle.depth),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      getProbingArguments(cycle, false)
    );
    if (cycle.updateToolWear) {
      error(localize("Action -Update Tool Wear- is not supported with this cycle."));
      return;
    } */
    break;
  case "probing-xy-pcd-boss":
    error(localize("probing-xy-pcd-boss - Unsupported Probing Cycle"));
    /* protectedProbeMove(cycle, x, y, z);
    writeBlock(
      macroCall, "P" + 9819,
      "A" + xyzFormat.format(cycle.pcdStartingAngle),
      "B" + xyzFormat.format(cycle.numberOfSubfeatures),
      "C" + xyzFormat.format(cycle.widthPCD),
      "D" + xyzFormat.format(cycle.widthFeature),
      "Z" + xyzFormat.format(z - cycle.depth),
      "Q" + xyzFormat.format(cycle.probeOvertravel),
      "R" + xyzFormat.format(cycle.probeClearance),
      getProbingArguments(cycle, false)
    );
    if (cycle.updateToolWear) {
      error(localize("Action -Update Tool Wear- is not supported with this cycle."));
      return;
    } */
    break;
  }
}

function printProbeResults() {
  return currentSection.getParameter("printResults", 0) == 1;
}

/** Convert approach to sign. */
function approach(value) {
  validate((value == "positive") || (value == "negative"), "Invalid approach.");
  return (value == "positive") ? 1 : -1;
}
// <<<<< INCLUDED FROM include_files/probeCycles_renishaw.cpi
// >>>>> INCLUDED FROM include_files/getProbingArguments_renishaw.cpi
/* function getProbingArguments(cycle, updateWCS) { // new Autodesk function
  var outputWCSCode = updateWCS && currentSection.strategy == "probe";
  if (outputWCSCode) {
    var maximumWcsNumber = 0;
    for (var i in wcsDefinitions.wcs) {
      maximumWcsNumber = Math.max(maximumWcsNumber, wcsDefinitions.wcs[i].range[1]);
    }
    maximumWcsNumber = probeExtWCSFormat.getResultingValue(maximumWcsNumber);
    var resultingWcsNumber = probeExtWCSFormat.getResultingValue(currentSection.probeWorkOffset - 6);
    validate(resultingWcsNumber <= maximumWcsNumber, subst("Probe work offset %1 is out of range, maximum value is %2.", resultingWcsNumber, maximumWcsNumber));
    var probeOutputWorkOffset = currentSection.probeWorkOffset > 6 ? probeExtWCSFormat.format(currentSection.probeWorkOffset - 6) : probeWCSFormat.format(currentSection.probeWorkOffset);

    var nextWorkOffset = hasNextSection() ? getNextSection().workOffset == 0 ? 1 : getNextSection().workOffset : -1;
    if (currentSection.probeWorkOffset == nextWorkOffset) {
      currentWorkOffset = undefined;
    }
  }
  return [
    (cycle.angleAskewAction == "stop-message" ? "B" + xyzFormat.format(cycle.toleranceAngle ? cycle.toleranceAngle : 0) : undefined),
    ((cycle.updateToolWear && cycle.toolWearErrorCorrection < 100) ? "F" + xyzFormat.format(cycle.toolWearErrorCorrection ? cycle.toolWearErrorCorrection / 100 : 100) : undefined),
    (cycle.wrongSizeAction == "stop-message" ? "H" + xyzFormat.format(cycle.toleranceSize ? cycle.toleranceSize : 0) : undefined),
    (cycle.outOfPositionAction == "stop-message" ? "M" + xyzFormat.format(cycle.tolerancePosition ? cycle.tolerancePosition : 0) : undefined),
    ((cycle.updateToolWear && cycleType == "probing-z") ? "T" + xyzFormat.format(cycle.toolLengthOffset) : undefined),
    ((cycle.updateToolWear && cycleType !== "probing-z") ? "T" + xyzFormat.format(cycle.toolDiameterOffset) : undefined),
    (cycle.updateToolWear ? "V" + xyzFormat.format(cycle.toolWearUpdateThreshold ? cycle.toolWearUpdateThreshold : 0) : undefined),
    (cycle.printResults ? "W" + xyzFormat.format(1 + cycle.incrementComponent) : undefined), // 1 for advance feature, 2 for reset feature count and advance component number. first reported result in a program should use W2.
    conditional(outputWCSCode, probeOutputWorkOffset)
  ];
} */
function getProbingArguments(cycle, probeWorkOffsetCode) { // Old Toolpath Syil function
  var probeWCS = hasParameter("operation-strategy") && (getParameter("operation-strategy") == "probe");

  var PROBE_ARGS = "";
  if (probeOutputWorkOffset < 7) {
    var WCS_NUM = 53 + probeOutputWorkOffset;
    PROBE_ARGS = "A" + WCS_NUM;
  } else {
    var WCS_NUM = probeOutputWorkOffset - 6;
    PROBE_ARGS = "A54." + WCS_NUM;
  }

  var PROBE_OVERRIDE_ARGS = "";
  if (currentWorkOffset < 7) {
    var WCS_NUM = 53 + currentWorkOffset;
    PROBE_OVERRIDE_ARGS = "B" + WCS_NUM;
  } else {
    var WCS_NUM = currentWorkOffset - 6;
    PROBE_OVERRIDE_ARGS = "B54." + WCS_NUM;
  }

  return [
    (cycle.angleAskewAction == "stop-message" ? "B" + xyzFormat.format(cycle.toleranceAngle ? cycle.toleranceAngle : 0) : undefined),
    ((cycle.updateToolWear && cycle.toolWearErrorCorrection < 100) ? "F" + xyzFormat.format(cycle.toolWearErrorCorrection ? cycle.toolWearErrorCorrection / 100 : 100) : undefined),
    (cycle.wrongSizeAction == "stop-message" ? "R" + xyzFormat.format(cycle.toleranceSize ? cycle.toleranceSize : 0) + " S1" : undefined),
    (cycle.outOfPositionAction == "stop-message" ? "T" + xyzFormat.format(cycle.tolerancePosition ? cycle.tolerancePosition : 0) + " U1" : undefined),
    ((cycle.updateToolWear && cycleType == "probing-z") ? "T" + xyzFormat.format(cycle.toolLengthOffset) : undefined),
    ((cycle.updateToolWear && cycleType !== "probing-z") ? "T" + xyzFormat.format(cycle.toolDiameterOffset) : undefined),
    (cycle.updateToolWear ? "V" + xyzFormat.format(cycle.toolWearUpdateThreshold ? cycle.toolWearUpdateThreshold : 0) : undefined),
    (cycle.printResults ? "I" + xyzFormat.format(1 + cycle.incrementComponent) : undefined), // 1 for advance feature, 2 for reset feature count and advance component number. first reported result in a program should use W2.
    conditional(probeWorkOffsetCode && probeWCS, PROBE_ARGS),
    conditional(probeWorkOffsetCode && probeWCS, PROBE_OVERRIDE_ARGS)
  ];
}
// <<<<< INCLUDED FROM include_files/getProbingArguments_renishaw.cpi
// >>>>> INCLUDED FROM include_files/protectedProbeMove_renishaw.cpi
function protectedProbeMove(_cycle, x, y, z) {
  var _x = xOutput.format(x);
  var _y = yOutput.format(y);
  var _z = zOutput.format(z - cycle.depth);
  var macroCall = settings.probing.macroCall;
  if (_z && z >= getCurrentPosition().z) {
    writeBlock(macroCall, "\"PROTECTEDMOVE\"", _z, getFeed(cycle.feedrate)); // protected positioning move
  }
  if (_x || _y) {
    writeBlock(macroCall, "\"PROTECTEDMOVE\"", _x, _y, getFeed(highFeedrate)); // protected positioning move
  }
  if (_z && z < getCurrentPosition().z) {
    writeBlock(macroCall, "\"PROTECTEDMOVE\"", _z, getFeed(cycle.feedrate)); // protected positioning move
  }
}
// <<<<< INCLUDED FROM include_files/protectedProbeMove_renishaw.cpi
// >>>>> INCLUDED FROM include_files/setProbeAngle_fanuc.cpi
function setProbeAngle() {
  if (probeVariables.outputRotationCodes) {
    validate(settings.probing.probeAngleVariables, localize("Setting 'probing.probeAngleVariables' is required for angular probing."));
    var probeAngleVariables = settings.probing.probeAngleVariables;
    var px = probeAngleVariables.x;
    var py = probeAngleVariables.y;
    var pz = probeAngleVariables.z;
    var pi = probeAngleVariables.i;
    var pj = probeAngleVariables.j;
    var pk = probeAngleVariables.k;
    var pr = probeAngleVariables.r;
    var baseParamG54x4 = probeAngleVariables.baseParamG54x4;
    var baseParamAxisRot = probeAngleVariables.baseParamAxisRot;
    var probeOutputWorkOffset = currentSection.probeWorkOffset;

    validate(probeOutputWorkOffset <= 6, "Angular Probing only supports work offsets 1-6.");
    if (probeVariables.probeAngleMethod == "G68" && (Vector.diff(currentSection.getGlobalInitialToolAxis(), new Vector(0, 0, 1)).length > 1e-4)) {
      error(localize("You cannot use multi axis toolpaths while G68 Rotation is in effect."));
    }
    var validateWorkOffset = false;
    switch (probeVariables.probeAngleMethod) {
    case "G54.4":
      var param = baseParamG54x4 + (probeOutputWorkOffset * 10);
      writeBlock("#" + param + "=" + px);
      writeBlock("#" + (param + 1) + "=" + py);
      writeBlock("#" + (param + 5) + "=" + pr);
      writeBlock(gFormat.format(54.4), "P" + probeOutputWorkOffset);
      break;
    case "G68":
      gRotationModal.reset();
      gAbsIncModal.reset();
      var xy = probeVariables.compensationXY || formatWords(formatCompensationParameter("X", px), formatCompensationParameter("Y", py));
      writeBlock(
        gRotationModal.format(68), gAbsIncModal.format(90),
        xy,
        formatCompensationParameter("Z", pz),
        formatCompensationParameter("I", pi),
        formatCompensationParameter("J", pj),
        formatCompensationParameter("K", pk),
        formatCompensationParameter("R", pr)
      );
      validateWorkOffset = true;
      break;
    case "AXIS_ROT":
      var param = baseParamAxisRot + probeOutputWorkOffset * 20 + probeVariables.rotaryTableAxis + 4;
      writeBlock("#" + param + " = " + "[#" + param + " + " + pr + "]");
      forceWorkPlane(); // force workplane to rotate ABC in order to apply rotation offsets
      currentWorkOffset = undefined; // force WCS output to make use of updated parameters
      validateWorkOffset = true;
      break;
    default:
      error(localize("Angular Probing is not supported for this machine configuration."));
      return;
    }
    if (validateWorkOffset) {
      for (var i = currentSection.getId(); i < getNumberOfSections(); ++i) {
        if (getSection(i).workOffset != currentSection.workOffset) {
          error(localize("WCS offset cannot change while using angle rotation compensation."));
          return;
        }
      }
    }
    probeVariables.outputRotationCodes = false;
  }
}

function formatCompensationParameter(label, value) {
  return typeof value == "string" ? label + "[" + value + "]" : typeof value == "number" ? label + xyzFormat.format(value) : "";
}
// <<<<< INCLUDED FROM include_files/setProbeAngle_fanuc.cpi
// >>>>> INCLUDED FROM include_files/setProbeAngleMethod.cpi
function setProbeAngleMethod() {
  var axisRotIsSupported = false;
  var axes = [machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW()];
  for (var i = 0; i < axes.length; ++i) {
    if (axes[i].isEnabled() && isSameDirection((axes[i].getAxis()).getAbsolute(), new Vector(0, 0, 1)) && axes[i].isTable()) {
      axisRotIsSupported = true;
      if (settings.probing.probeAngleVariables.method == 0) { // Fanuc
        validate(i < 2, localize("Rotary table axis is invalid."));
        probeVariables.rotaryTableAxis = i;
      } else { // Haas
        probeVariables.rotaryTableAxis = axes[i].getCoordinate();
      }
      break;
    }
  }
  if (settings.probing.probeAngleMethod == undefined) {
    probeVariables.probeAngleMethod = axisRotIsSupported ? "AXIS_ROT" : getProperty("useG54x4") ? "G54.4" : "G68"; // automatic selection
  } else {
    probeVariables.probeAngleMethod = settings.probing.probeAngleMethod; // use probeAngleMethod from settings
    if (probeVariables.probeAngleMethod == "AXIS_ROT" && !axisRotIsSupported) {
      error(localize("Setting probeAngleMethod 'AXIS_ROT' is not supported on this machine."));
    }
  }
  probeVariables.outputRotationCodes = true;
}
// <<<<< INCLUDED FROM include_files/setProbeAngleMethod.cpi

var now = new Date(); // BJE
