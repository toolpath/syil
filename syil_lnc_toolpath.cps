/**
  Copyright (C) 2012-2020 by Autodesk, Inc.
  All rights reserved.

  FANUC post processor configuration.

  $Revision: 42831 17c7160294bbeecc46faa18c5e7a2c703384f949 $
  $Date: 2020-06-18 05:04:27 $
  
  FORKID {CB457AE9-77B4-4F88-B95A-4DC6980DBE3D}
*/

description = "SYIL_LNC - Toolpath Post";
vendor = "LNC";
vendorUrl = "http://www.toolpath.com";
legal = "Copyright (C) 2021-2023 Toolpath Labs Inc.";
certificationLevel = 2;
minimumRevision = 11;

longDescription = "Generic Fanuc post illustrating inverse time feed with an A-axis.";

extension = "nc";
programNameIsInteger = false;
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
highFeedrate = (unit == IN) ? 500 : 5000;

// user-defined properties
properties = {
  writeMachine: true, // write machine
  writeTools: true, // writes the tools
  preloadTool: false, // preloads next tool on tool change if any
  showSequenceNumbers: true, // show sequence numbers
  sequenceNumberStart: 10, // first sequence number
  sequenceNumberIncrement: 5, // increment for sequence numbers
  optionalStop: false, // optional stop
  o8: false, // specifies 8-digit program number
  separateWordsWithSpace: true, // specifies that the words should be separated with a white space
  allow3DArcs: false, // specifies that 3D circular arcs are allowed
  useRadius: false, // specifies that arcs should be output using the radius (R word) instead of the I, J, and K words
  forceIJK: false, // force output of IJK for G2/G3 when not using R word
  showNotes: false, // specifies that operation notes should be output
  useSmoothing: false, // specifies if smoothing should be used or not
  usePitchForTapping: false, // enable to use pitch instead of feed for the F-word for canned tapping cycles - note that your CNC control must be setup for pitch mode!
  useG54x4: false, // Fanuc 30i supports G54.4 for Workpiece Error Compensation
  makeAAxisOtherWay: false, // make the A-axis rotate the opposite way
  useSubroutines: false, // specifies that subroutines per each operation should be generated
  useFilesForSubprograms: false, // specifies that one file should be generated to section
  useSubroutinePatterns: false, // generates subroutines for patterned operation
  useSubroutineCycles: false, // generates subroutines for cycle operations on same holes
  useRigidTapping: "yes", // output rigid tapping block
  multiaxislocking: false, // Use M11 Lock and M10 Unlock
  useAAxis: true, // Output code with A Axis included
  useInverseTime: false, // Use inverse time on multi axis moves
  useG53saferetract: false, // Uses G53 for safe retract instead of G28
  g53homeX: 0, // G53 Safe retract for X plane
  g53homeY: 0, // G53 Safe retract for Y plane
  breakControlError: 0.05, // Break Control Max Error
  ForceTCPosition: false, // Change Position Prior to Toolchange
  TCposX: 0, // Toolchange Position On X Axis
  TCposY: 0, // Toolchange Position On Y Axis
};

// user-defined property definitions
propertyDefinitions = {
  writeMachine: {title:"Write machine", description:"Output the machine settings in the header of the code.", group:0, type:"boolean"},
  writeTools: {title:"Write tool list", description:"Output a tool list in the header of the code.", group:0, type:"boolean"},
  preloadTool: {title:"Preload tool", description:"Preloads the next tool at a tool change (if any).", group:1, type:"boolean"},
  showSequenceNumbers: {title:"Use sequence numbers", description:"Use sequence numbers for each block of outputted code.", group:1, type:"boolean"},
  sequenceNumberStart: {title:"Start sequence number", description:"The number at which to start the sequence numbers.", group:1, type:"integer"},
  sequenceNumberIncrement: {title:"Sequence number increment", description:"The amount by which the sequence number is incremented by in each block.", group:1, type:"integer"},
  optionalStop: {title:"Optional stop", description:"Outputs optional stop code during when necessary in the code.", type:"boolean"},
  o8: {title:"8 Digit program number", description:"Specifies that an 8 digit program number is needed.", type:"boolean"},
  separateWordsWithSpace: {title:"Separate words with space", description:"Adds spaces between words if 'yes' is selected.", type:"boolean"},
  allow3DArcs: {title:"Allow 3D arcs", description:"Specifies whether 3D circular arcs are allowed.", type:"boolean"},
  useRadius: {title:"Radius arcs", description:"If yes is selected, arcs are outputted using radius values rather than IJK.", type:"boolean"},
  forceIJK: {title:"Force IJK", description:"Force the output of IJK for G2/G3 when not using R mode.", type:"boolean"},
  showNotes: {title:"Show notes", description:"Writes operation notes as comments in the outputted code.", type:"boolean"},
  useSmoothing: {title:"Use smoothing", description:"Specifies if smoothing should be used or not.", type:"boolean"},
  usePitchForTapping: {title:"Use pitch for tapping", description:"Enables the use of pitch instead of feed for the F-word in canned tapping cycles. Your CNC control must be setup for pitch mode!", type:"boolean"},
  useG54x4: {title:"Use G54.4", description:"Fanuc 30i supports G54.4 for workpiece error compensation.", type:"boolean"},
  makeAAxisOtherWay: {title:"Reverse A-axis", description:"Makes the A-axis rotate the opposite way.", type:"boolean"},
  useSubroutines: {title:"Use subroutines", description:"Specifies that subroutines per each operation should be generated.", type:"boolean"},
  useFilesForSubprograms: {title:"Use files for subroutines", description:"If enabled, subroutines will be saved as individual files.", type:"boolean"},
  useSubroutinePatterns: {title:"Use subroutine patterns", description:"Generates subroutines for patterned operation.", type:"boolean"},
  useSubroutineCycles: {title:"Use subroutine cycles", description:"Generates subroutines for cycle operations on same holes.", type:"boolean"},
  useRigidTapping: {
    title: "Use rigid tapping",
    description: "Select 'Yes' to enable, 'No' to disable, or 'Without spindle direction' to enable rigid tapping without outputting the spindle direction block.",
    type: "enum",
    values:[
      {title:"Yes", id:"yes"},
      {title:"No", id:"no"},
      {title:"Without spindle direction", id:"without"}
    ]
  },
  multiaxislocking: {title:"Use M10/M11 Rotational Axis Lock", description:"Unlock and Lock A, B and C Axis using M10/M11 Command.", group:2, type:"boolean"},
  useAAxis: {title:"Output A Axis", description:"Select 'No' for 3 axis machining only, without A00.", group:2, type:"boolean"},
  useInverseTime: {title:"Use Inverse Time Feedrate", description:"Use Inverse Time Feed On Multi Axis Moves. Select 'No' for FPM/DPM Feedrates.", group:2, type:"boolean"},
  useG53saferetract: {title:"Use G53 for Retract and Home", description:"Use G53 machine coordinates instead of G28 for retraction and homing.", group:3, type:"boolean"},
  g53homeX: {title:"G53 X Home - Machine Coordinate", description:"Machine Coordinate for G53 Home on X Axis.", group:3, type:"number"},
  g53homeY: {title:"G53 Y Home - Machine Coordinate", description:"Machine Coordinate for G53 Home on Y Axis.", group:3, type:"number"},
  breakControlError: {title:"Max. Break Control Error", description:"Maximum Allowable Error for Break Control.", type:"number"},
  ForceTCPosition: {title:"Change Position Before Toolchange", description:"Change the machine position before executing a toolchange.", group:4, type:"boolean"},
  TCposX: {title:"Toolchange Position X Axis - Machine Coordinate", description:"Machine Coordinate for toolchange on X Axis.", group:4, type:"number"},
  TCposY: {title:"Toolchange Position Y Axis - Machine Coordinate", description:"Machine Coordinate for toolchange on Y Axis.", group:4, type:"number"},
};

// wcs definiton
wcsDefinitions = {
  useZeroOffset: false,
  wcs          : [
    {name:"Standard", format:"G", range:[54, 59]},
    {name:"Extended", format:"G54P#", range:[1, 106]}
  ]
};

var singleLineCoolant = false; // specifies to output multiple coolant codes in one line rather than in separate lines
// samples:
// {id: COOLANT_THROUGH_TOOL, on: 88, off: 89}
// {id: COOLANT_THROUGH_TOOL, on: [8, 88], off: [9, 89]}
var coolants = [
  {id: COOLANT_FLOOD, on: 8},
  {id: COOLANT_MIST},
  {id: COOLANT_THROUGH_TOOL, on: 88, off: 89},
  {id: COOLANT_AIR, on: 7},
  {id: COOLANT_AIR_THROUGH_TOOL},
  {id: COOLANT_SUCTION},
  {id: COOLANT_FLOOD_MIST},
  {id: COOLANT_FLOOD_THROUGH_TOOL},
  {id: COOLANT_OFF, off: 9}
];

var permittedCommentChars = " ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,=_-";

var gFormat = createFormat({prefix:"G", width:2, zeropad:true, decimals:1});
var mFormat = createFormat({prefix:"M", width:2, zeropad:true, decimals:1});
var hFormat = createFormat({prefix:"H", width:2, zeropad:true, decimals:1});
var dFormat = createFormat({prefix:"D", width:2, zeropad:true, decimals:1});
var probe100Format = createFormat({decimals:3, zeropad:true, width:3, forceDecimal:true});

var xyzFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var rFormat = xyzFormat; // radius
var abcFormat = createFormat({decimals:3, forceDecimal:true, scale:DEG});
var feedFormat = createFormat({decimals:(unit == MM ? 1 : 2), forceDecimal:true});
var pitchFormat = createFormat({decimals:(unit == MM ? 3 : 4), forceDecimal:true});
var toolFormat = createFormat({decimals:0});
var rpmFormat = createFormat({decimals:0});
var secFormat = createFormat({decimals:3, forceDecimal:true}); // seconds - range 0.001-99999.999
var milliFormat = createFormat({decimals:0}); // milliseconds // range 1-9999
var taperFormat = createFormat({decimals:1, scale:DEG});
var oFormat = createFormat({width:4, zeropad:true, decimals:0});
var now = new Date (); // BJE

var xOutput = createVariable({prefix:"X"}, xyzFormat);
var yOutput = createVariable({prefix:"Y"}, xyzFormat);
var zOutput = createVariable({onchange: function() {retracted = false;}, prefix:"Z"}, xyzFormat);
var aOutput = createVariable({prefix:"A"}, abcFormat);
var bOutput = createVariable({prefix:"B"}, abcFormat);
var cOutput = createVariable({prefix:"C"}, abcFormat);
var feedOutput = createVariable({prefix:"F"}, feedFormat);
var pitchOutput = createVariable({prefix:"F", force:true}, pitchFormat);
var sOutput = createVariable({prefix:"S", force:true}, rpmFormat);
var dOutput = createVariable({}, dFormat);

// circular output
var iOutput = createReferenceVariable({prefix:"I"}, xyzFormat);
var jOutput = createReferenceVariable({prefix:"J"}, xyzFormat);
var kOutput = createReferenceVariable({prefix:"K"}, xyzFormat);

var gMotionModal = createModal({}, gFormat); // modal group 1 // G0-G3, ...
var gPlaneModal = createModal({onchange:function () {gMotionModal.reset();}}, gFormat); // modal group 2 // G17-19
var gAbsIncModal = createModal({}, gFormat); // modal group 3 // G90-91
var gFeedModeModal = createModal({}, gFormat); // modal group 5 // G94-95
var gUnitModal = createModal({}, gFormat); // modal group 6 // G20-21
var gCycleModal = createModal({}, gFormat); // modal group 9 // G81, ...
var gRetractModal = createModal({}, gFormat); // modal group 10 // G98-99
var gRotationModal = createModal({}, gFormat); // modal group 16 // G68-G69

// fixed settings
var useMultiAxisFeatures = false;
var forceMultiAxisIndexing = false; // force multi-axis indexing for 3D programs
var maximumLineLength = 80; // the maximum number of charaters allowed in a line
var minimumCyclePoints = 5; // minimum number of points in cycle operation to consider for subprogram
var cancelTiltFirst = false; // cancel G68.2 with G69 prior to G54-G59 WCS block
var useABCPrepositioning = false; // position ABC axes prior to G68.2 block

var WARNING_WORK_OFFSET = 0;

var ANGLE_PROBE_NOT_SUPPORTED = 0;
var ANGLE_PROBE_USE_ROTATION = 1;
var ANGLE_PROBE_USE_CAXIS = 2;

var SUB_UNKNOWN = 0;
var SUB_PATTERN = 1;
var SUB_CYCLE = 2;

// collected state
var sequenceNumber;
var currentWorkOffset;
var optionalSection = false;
var forceSpindleSpeed = false;
var g68RotationMode = 0;
var angularProbingMode;
var subprograms = [];
var currentPattern = -1;
var firstPattern = false;
var currentSubprogram;
var lastSubprogram;
var definedPatterns = new Array();
var incrementalMode = false;
var saveShowSequenceNumbers;
var cycleSubprogramIsActive = false;
var patternIsActive = false;
var lastOperationComment = "";
var incrementalSubprogram;
var retracted = false; // specifies that the tool has been retracted to the safe plane
probeMultipleFeatures = true;

// LNC5800 macro variable addresses - Added by mlm
// These locations are set by default by Syil for the LNC5800
var GV_PROBE_SPEED_FAST = 1;
var GV_PROBE_SPEED_SLOW = 2;
var GV_PROBE_SLOW_DISTANCE = 3;
var GV_PROBE_TYPE = 4;
var GV_TOOL_DIA = 8;
var GV_FEEDRATE = 9;
var GV_DEPTH = 882;
var GV_APPROACH1 = 880;
var GV_APPROACH2 = 881;
var GV_CLEARANCE = 820;
var GV_WCS = 860;
var GV_WIDTH1 = 880;
var GV_WIDTH2 = 881;
var GV_PROBE_SPACING = 883;
var GV_TOL_POSITION = 20;  //the tolerance for the position
var GV_NOM_ANGLE = 884;  //the tolerance for the angle
var GV_TOL_SIZE = 22;  //the tolerance for the size


/**
  Writes the specified block.
*/
function writeBlock() {
  var text = formatWords(arguments);
  if (!text) {
    return;
  }
  if (properties.showSequenceNumbers) {
    if (optionalSection) {
      if (text) {
        writeWords("/", "N" + sequenceNumber, text);
      }
    } else {
      writeWords2("N" + sequenceNumber, arguments);
    }
    sequenceNumber += properties.sequenceNumberIncrement;
  } else {
    if (optionalSection) {
      writeWords2("/", arguments);
    } else {
      writeWords(arguments);
    }
  }
}

/**
  PASS THRU CREATED 9/1/2023 BJE
*/
function onPassThrough(text) {
  var commands = String(text).split(",");
  for (text in commands) {
    writeBlock(commands[text]);
  }
}

/**
  Writes the specified optional block.
*/
function writeOptionalBlock() {
  if (properties.showSequenceNumbers) {
    var words = formatWords(arguments);
    if (words) {
      writeWords("/", "N" + sequenceNumber, words);
      sequenceNumber += properties.sequenceNumberIncrement;
    }
  } else {
    writeWords2("/", arguments);
  }
}

function formatComment(text) {
  return "(" + filterText(String(text).toUpperCase(), permittedCommentChars).replace(/[()]/g, "") + ")";
}

function formatSetVar(gVar, val)  //added by ua
{
	return "@" + gVar + "=" + val;
}

/**
  Output a comment.
*/
function writeComment(text) {
  writeln(formatComment(text));
}

function onOpen() {
  if (properties.useRadius) {
    maximumCircularSweep = toRad(90); // avoid potential center calculation errors for CNC
  }
  gRotationModal.format(69); // Default to G69 Rotation Off

  if (true) {
    var aAxis = createAxis({coordinate:0, table:true, axis:[(properties.makeAAxisOtherWay ? -1 : 1) * -1, 0, 0], cyclic:true, preference:1});
    machineConfiguration = new MachineConfiguration(aAxis);

    setMachineConfiguration(machineConfiguration);
    optimizeMachineAngles2(1); // map tip mode
  }

  if (!machineConfiguration.isMachineCoordinate(0)) {
    aOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(1)) {
    bOutput.disable();
  }
  if (!machineConfiguration.isMachineCoordinate(2)) {
    cOutput.disable();
  }
  
  if (!properties.separateWordsWithSpace) {
    setWordSeparator("");
  }

  if (properties.forceIJK) {
    iOutput = createReferenceVariable({prefix:"I", force:true}, xyzFormat);
    jOutput = createReferenceVariable({prefix:"J", force:true}, xyzFormat);
    kOutput = createReferenceVariable({prefix:"K", force:true}, xyzFormat);
  }

  sequenceNumber = properties.sequenceNumberStart;
  writeln("%");

  if (programName) {
    writeComment(programName);
    writeComment((now.getMonth()+1) + "/" + now.getDate() + "/" + now.getFullYear() + " " + now.getHours() + ":" + ('0'+now.getMinutes()).slice(-2)); //BJE
    }
  if (programComment) {
    writeComment(programComment);
    }
    
  // dump machine configuration
  var vendor = machineConfiguration.getVendor();
  var model = machineConfiguration.getModel();
  var description = machineConfiguration.getDescription();

  if (properties.writeMachine && (vendor || model || description)) {
    writeComment(localize("Machine"));
    if (vendor) {
      writeComment("  " + localize("vendor") + ": " + vendor);
    }
    if (model) {
      writeComment("  " + localize("model") + ": " + model);
    }
    if (description) {
      writeComment("  " + localize("description") + ": "  + description);
    }
  }

  // dump tool information
  if (properties.writeTools) {
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
        var comment = "T" + toolFormat.format(tool.number) + " " +
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
  
  if (false) {
    // check for duplicate tool number
    for (var i = 0; i < getNumberOfSections(); ++i) {
      var sectioni = getSection(i);
      var tooli = sectioni.getTool();
      for (var j = i + 1; j < getNumberOfSections(); ++j) {
        var sectionj = getSection(j);
        var toolj = sectionj.getTool();
        if (tooli.number == toolj.number) {
          if (xyzFormat.areDifferent(tooli.diameter, toolj.diameter) ||
              xyzFormat.areDifferent(tooli.cornerRadius, toolj.cornerRadius) ||
              abcFormat.areDifferent(tooli.taperAngle, toolj.taperAngle) ||
              (tooli.numberOfFlutes != toolj.numberOfFlutes)) {
            error(
              subst(
                localize("Using the same tool number for different cutter geometry for operation '%1' and '%2'."),
                sectioni.hasParameter("operation-comment") ? sectioni.getParameter("operation-comment") : ("#" + (i + 1)),
                sectionj.hasParameter("operation-comment") ? sectionj.getParameter("operation-comment") : ("#" + (j + 1))
              )
            );
            return;
          }
        }
      }
    }
  }

  if ((getNumberOfSections() > 0) && (getSection(0).workOffset == 0)) {
    for (var i = 0; i < getNumberOfSections(); ++i) {
      if (getSection(i).workOffset > 0) {
        error(localize("Using multiple work offsets is not possible if the initial work offset is 0."));
        return;
      }
    }
  }

  // absolute coordinates and feed per min
  writeBlock(gAbsIncModal.format(90), gFeedModeModal.format(94), gPlaneModal.format(17), gFormat.format(49), gFormat.format(40), gFormat.format(80));

  switch (unit) {
  case IN:
    writeBlock(gUnitModal.format(20));
    break;
  case MM:
    writeBlock(gUnitModal.format(21));
    break;
  }

}

function onComment(message) {
  var comments = String(message).split(";");
  for (comment in comments) {
    writeComment(comments[comment]);
  }
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

function forceFeed() {
  previousDPMFeed = 0;
  feedOutput.reset();
}

/** Force output of X, Y, Z, A, B, C, and F on next output. */
function forceAny() {
  forceXYZ();
  forceABC();
  forceFeed();
}

var lengthCompensationActive = false;
var retracted = false; // specifies that the tool has been retracted to the safe plane

/** Disables length compensation if currently active or if forced. */
function disableLengthCompensation(force) {
  if (lengthCompensationActive || force) {
    validate(retracted, "Cannot cancel length compensation if the machine is not fully retracted.");
    writeBlock(gFormat.format(49));
    lengthCompensationActive = false;
  }
}

var currentSmoothing = false;

function setSmoothing(mode) {
  if (mode == currentSmoothing) {
    return false;
  }

  // 1) Make sure G49 is called before the execution of G05.1 Q1 Rx
  // 2) G05.1 Q1 Rx must be engaged BEFORE G43-Tool Length Comp
  // 3) AICC and AIAPC need to be turned on and off for each tool
  // 4) AICC and AIAPC does not apply to canned drilling cycles
  validate(!lengthCompensationActive, "Length compensation is active while trying to update smoothing.");

  currentSmoothing = mode;
  writeBlock(gFormat.format(5.1), mode ? "Q1" : "Q0");
  return true;
}

var currentWorkPlaneABC = undefined;

function forceWorkPlane() {
  currentWorkPlaneABC = undefined;
}

function defineWorkPlane(_section, _setWorkPlane) {
  var abc = new Vector(0, 0, 0);
  if (forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) { // use 5-axis indexing for multi-axis mode
    // set working plane after datum shift

    if (_section.isMultiAxis()) {
      cancelTransformation();
      abc = _section.getInitialToolAxisABC();
      if (_setWorkPlane) {
        if (!retracted) {
          writeRetract(Z);
        }
        forceWorkPlane();
        onCommand(COMMAND_UNLOCK_MULTI_AXIS);
        gMotionModal.reset();
        writeBlock(
          gMotionModal.format(0),
          conditional(machineConfiguration.isMachineCoordinate(0), "A" + abcFormat.format(abc.x)),
          conditional(machineConfiguration.isMachineCoordinate(1), "B" + abcFormat.format(abc.y)),
          conditional(machineConfiguration.isMachineCoordinate(2), "C" + abcFormat.format(abc.z))
        );
      }
    } else {
      if (useMultiAxisFeatures) {
        var euler = _section.workPlane.getEuler2(EULER_ZXZ_R);
        abc = new Vector(euler.x, euler.y, euler.z);
        cancelTransformation();
      } else {
        abc = getWorkPlaneMachineABC(_section.workPlane, _setWorkPlane, true);
      }
      if (_setWorkPlane) {
        setWorkPlane(abc);
      }
    }
  } else { // pure 3D
    var remaining = _section.workPlane;
    if (!isSameDirection(remaining.forward, new Vector(0, 0, 1))) {
      error(localize("Tool orientation is not supported."));
      return abc;
    }
    setRotation(remaining);
  }
  return abc;
}

function cancelWorkPlane() {
  writeBlock(gRotationModal.format(69)); // cancel frame
  forceWorkPlane();
}

function setWorkPlane(abc) {
  if (!forceMultiAxisIndexing && is3D() && !machineConfiguration.isMultiAxisConfiguration()) {
    return; // ignore
  }

  if (!((currentWorkPlaneABC == undefined) ||
        abcFormat.areDifferent(abc.x, currentWorkPlaneABC.x) ||
        abcFormat.areDifferent(abc.y, currentWorkPlaneABC.y) ||
        abcFormat.areDifferent(abc.z, currentWorkPlaneABC.z))) {
    return; // no change
  }

  onCommand(COMMAND_UNLOCK_MULTI_AXIS);
  if (!retracted) {
    writeRetract(Z);
  }

  if (useMultiAxisFeatures) {
    if (cancelTiltFirst) {
      cancelWorkPlane();
    }
    if (machineConfiguration.isMultiAxisConfiguration() && useABCPrepositioning) {
      var angles = abc.isNonZero() ? getWorkPlaneMachineABC(currentSection.workPlane, false, false) : abc;
      gMotionModal.reset();
      writeBlock(
        gMotionModal.format(0),
        conditional(machineConfiguration.isMachineCoordinate(0), "A" + abcFormat.format(angles.x)),
        conditional(machineConfiguration.isMachineCoordinate(1), "B" + abcFormat.format(angles.y)),
        conditional(machineConfiguration.isMachineCoordinate(2), "C" + abcFormat.format(angles.z))
      );
    }
    if (abc.isNonZero()) {
      gRotationModal.reset();
      writeBlock(gRotationModal.format(68.2), "X" + xyzFormat.format(0), "Y" + xyzFormat.format(0), "Z" + xyzFormat.format(0), "A" + abcFormat.format(abc.x), "B" + abcFormat.format(abc.y), "C" + abcFormat.format(abc.z)); // set frame
      writeBlock(gFormat.format(53.1)); // turn machine
    } else {
      if (!cancelTiltFirst) {
        cancelWorkPlane();
      }
    }
  } else {
    gMotionModal.reset();
    writeBlock(
      gMotionModal.format(0),
      conditional(machineConfiguration.isMachineCoordinate(0), "A" + abcFormat.format(abc.x)),
      conditional(machineConfiguration.isMachineCoordinate(1), "B" + abcFormat.format(abc.y)),
      conditional(machineConfiguration.isMachineCoordinate(2), "C" + abcFormat.format(abc.z))
    );
  }
  
  onCommand(COMMAND_LOCK_MULTI_AXIS);

  currentWorkPlaneABC = abc;
}

var closestABC = false; // choose closest machine angles
var currentMachineABC;

function getWorkPlaneMachineABC(workPlane, _setWorkPlane, rotate) {
  var W = workPlane; // map to global frame

  var abc = machineConfiguration.getABC(W);
  if (closestABC) {
    if (currentMachineABC) {
      abc = machineConfiguration.remapToABC(abc, currentMachineABC);
    } else {
      abc = machineConfiguration.getPreferredABC(abc);
    }
  } else {
    abc = machineConfiguration.getPreferredABC(abc);
  }
  
  try {
    abc = machineConfiguration.remapABC(abc);
    if (_setWorkPlane) {
      currentMachineABC = abc;
    }
  } catch (e) {
    error(
      localize("Machine angles not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }
  
  var direction = machineConfiguration.getDirection(abc);
  if (!isSameDirection(direction, W.forward)) {
    error(localize("Orientation not supported."));
  }
  
  if (!machineConfiguration.isABCSupported(abc)) {
    error(
      localize("Work plane is not supported") + ":"
      + conditional(machineConfiguration.isMachineCoordinate(0), " A" + abcFormat.format(abc.x))
      + conditional(machineConfiguration.isMachineCoordinate(1), " B" + abcFormat.format(abc.y))
      + conditional(machineConfiguration.isMachineCoordinate(2), " C" + abcFormat.format(abc.z))
    );
  }

  if (rotate) {
    var tcp = false;
    if (tcp) {
      setRotation(W); // TCP mode
    } else {
      var O = machineConfiguration.getOrientation(abc);
      var R = machineConfiguration.getRemainingOrientation(abc, W);
      setRotation(R);
    }
  }
  
  return abc;
}

function isProbeOperation() {
  return hasParameter("operation-strategy") && ((getParameter("operation-strategy") == "probe" || getParameter("operation-strategy") == "probe_geometry"));
}

var probeOutputWorkOffset = 1;

function onParameter(name, value) {
  if (name == "probe-output-work-offset") {
    probeOutputWorkOffset = (value > 0) ? value : 1;
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

function subprogramDefine(_initialPosition, _abc, _retracted, _zIsOutput) {
  // convert patterns into subprograms
  var usePattern = false;
  patternIsActive = false;
  if (currentSection.isPatterned && currentSection.isPatterned() && properties.useSubroutinePatterns) {
    currentPattern = currentSection.getPatternId();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if ((definedPatterns[i].patternType == SUB_PATTERN) && (currentPattern == definedPatterns[i].patternId)) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_PATTERN);
      if (usePattern) {
        currentSubprogram = ++lastSubprogram;
      }
      definedPatterns.push({
        patternType: SUB_PATTERN,
        patternId: currentPattern,
        subProgram: currentSubprogram,
        validPattern: usePattern,
        initialPosition: _initialPosition,
        finalPosition: _initialPosition
      });
    }

    if (usePattern) {
      // make sure Z-position is output prior to subprogram call
      if (!_retracted && !_zIsOutput) {
        writeBlock(gMotionModal.format(0), zOutput.format(_initialPosition.z));
      }

      // call subprogram
      writeBlock(mFormat.format(98), "P" + oFormat.format(currentSubprogram));
      patternIsActive = true;

      if (firstPattern) {
        subprogramStart(_initialPosition, _abc, incrementalSubprogram);
      } else {
        skipRemainingSection();
        setCurrentPosition(getFramePosition(currentSection.getFinalPosition()));
      }
    }
  }

  // Output cycle operation as subprogram
  if (!usePattern && properties.useSubroutineCycles && currentSection.doesStrictCycle &&
      (currentSection.getNumberOfCycles() == 1) && currentSection.getNumberOfCyclePoints() >= minimumCyclePoints) {
    var finalPosition = getFramePosition(currentSection.getFinalPosition());
    currentPattern = currentSection.getNumberOfCyclePoints();
    firstPattern = true;
    for (var i = 0; i < definedPatterns.length; ++i) {
      if ((definedPatterns[i].patternType == SUB_CYCLE) && (currentPattern == definedPatterns[i].patternId) &&
          !areSpatialVectorsDifferent(_initialPosition, definedPatterns[i].initialPosition) &&
          !areSpatialVectorsDifferent(finalPosition, definedPatterns[i].finalPosition)) {
        currentSubprogram = definedPatterns[i].subProgram;
        usePattern = definedPatterns[i].validPattern;
        firstPattern = false;
        break;
      }
    }

    if (firstPattern) {
      // determine if this is a valid pattern for creating a subprogram
      usePattern = subprogramIsValid(currentSection, currentPattern, SUB_CYCLE);
      if (usePattern) {
        currentSubprogram = ++lastSubprogram;
      }
      definedPatterns.push({
        patternType: SUB_CYCLE,
        patternId: currentPattern,
        subProgram: currentSubprogram,
        validPattern: usePattern,
        initialPosition: _initialPosition,
        finalPosition: finalPosition
      });
    }
    cycleSubprogramIsActive = usePattern;
  }

  // Output each operation as a subprogram
  if (!usePattern && properties.useSubroutines) {
    currentSubprogram = ++lastSubprogram;
    writeBlock(mFormat.format(98), "P" + oFormat.format(currentSubprogram));
    firstPattern = true;
    subprogramStart(_initialPosition, _abc, false);
  }
}

function subprogramStart(_initialPosition, _abc, _incremental) {
  if (properties.useFilesForSubprograms) {
    var path = FileSystem.getCombinedPath(FileSystem.getFolderPath(getOutputPath()), currentSubprogram + "." + extension);
    redirectToFile(path);
    writeln("%");
  } else {
    redirectToBuffer();
  }
  var comment = "";
  if (hasParameter("operation-comment")) {
    comment = getParameter("operation-comment");
  }
  writeln(
    "O" + oFormat.format(currentSubprogram) +
    conditional(comment, formatComment(comment.substr(0, maximumLineLength - 2 - 6 - 1)))
  );
  saveShowSequenceNumbers = properties.showSequenceNumbers;
  properties.showSequenceNumbers = false;
  if (_incremental) {
    setIncrementalMode(_initialPosition, _abc);
  }
  gPlaneModal.reset();
  gMotionModal.reset();
}

function subprogramEnd() {
  if (firstPattern) {
    writeBlock(mFormat.format(99));
    if (properties.useFilesForSubprograms) {
      writeln("%");
    } else {
      writeln("");
      subprograms += getRedirectionBuffer();
    }
  }
  forceAny();
  firstPattern = false;
  properties.showSequenceNumbers = saveShowSequenceNumbers;
  closeRedirection();
}

function subprogramIsValid(_section, _patternId, _patternType) {
  var sectionId = _section.getId();
  var numberOfSections = getNumberOfSections();
  var validSubprogram = _patternType != SUB_CYCLE;

  var masterPosition = new Array();
  masterPosition[0] = getFramePosition(_section.getInitialPosition());
  masterPosition[1] = getFramePosition(_section.getFinalPosition());
  var tempBox = _section.getBoundingBox();
  var masterBox = new Array();
  masterBox[0] = getFramePosition(tempBox[0]);
  masterBox[1] = getFramePosition(tempBox[1]);

  var rotation = getRotation();
  var translation = getTranslation();
  incrementalSubprogram = undefined;

  for (var i = 0; i < numberOfSections; ++i) {
    var section = getSection(i);
    if (section.getId() != sectionId) {
      defineWorkPlane(section, false);
      // check for valid pattern
      if (_patternType == SUB_PATTERN) {
        if (section.getPatternId() == _patternId) {
          var patternPosition = new Array();
          patternPosition[0] = getFramePosition(section.getInitialPosition());
          patternPosition[1] = getFramePosition(section.getFinalPosition());
          tempBox = section.getBoundingBox();
          var patternBox = new Array();
          patternBox[0] = getFramePosition(tempBox[0]);
          patternBox[1] = getFramePosition(tempBox[1]);

          if (areSpatialBoxesSame(masterPosition, patternPosition) && areSpatialBoxesSame(masterBox, patternBox)) {
            incrementalSubprogram = incrementalSubprogram ? incrementalSubprogram : false;
          } else if (!areSpatialBoxesTranslated(masterPosition, patternPosition) || !areSpatialBoxesTranslated(masterBox, patternBox)) {
            validSubprogram = false;
            break;
          } else {
            incrementalSubprogram = true;
          }
        }

      // check for valid cycle operation
      } else if (_patternType == SUB_CYCLE) {
        if ((section.getNumberOfCyclePoints() == _patternId) && (section.getNumberOfCycles() == 1)) {
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

function setAxisMode(_format, _output, _prefix, _value, _incr) {
  var i = _output.isEnabled();
  _output = _incr ? createIncrementalVariable({prefix: _prefix}, _format) : createVariable({prefix: _prefix}, _format);
  _output.format(_value);
  _output.format(_value);
  i = i ? _output.enable() : _output.disable();
  return _output;
}

function setIncrementalMode(xyz, abc) {
  xOutput = setAxisMode(xyzFormat, xOutput, "X", xyz.x, true);
  yOutput = setAxisMode(xyzFormat, yOutput, "Y", xyz.y, true);
  zOutput = setAxisMode(xyzFormat, zOutput, "Z", xyz.z, true);
  aOutput = setAxisMode(abcFormat, aOutput, "A", abc.x, true);
  bOutput = setAxisMode(abcFormat, bOutput, "B", abc.y, true);
  cOutput = setAxisMode(abcFormat, cOutput, "C", abc.z, true);
  gAbsIncModal.reset();
  writeBlock(gAbsIncModal.format(91));
  incrementalMode = true;
}

function setAbsoluteMode(xyz, abc) {
  if (incrementalMode) {
    xOutput = setAxisMode(xyzFormat, xOutput, "X", xyz.x, false);
    yOutput = setAxisMode(xyzFormat, yOutput, "Y", xyz.y, false);
    zOutput = setAxisMode(xyzFormat, zOutput, "Z", xyz.z, false);
    aOutput = setAxisMode(abcFormat, aOutput, "A", abc.x, false);
    bOutput = setAxisMode(abcFormat, bOutput, "B", abc.y, false);
    cOutput = setAxisMode(abcFormat, cOutput, "C", abc.z, false);
    gAbsIncModal.reset();
    writeBlock(gAbsIncModal.format(90));
    incrementalMode = false;
  }
}

function onSection() {
  var forceToolAndRetract = optionalSection && !currentSection.isOptional();
  optionalSection = currentSection.isOptional();

  var insertToolCall = forceToolAndRetract || isFirstSection() ||
    currentSection.getForceToolChange && currentSection.getForceToolChange() ||
    (tool.number != getPreviousSection().getTool().number);
  
  var newWorkOffset = isFirstSection() ||
    (getPreviousSection().workOffset != currentSection.workOffset); // work offset changes
  var newWorkPlane = isFirstSection() ||
    !isSameDirection(getPreviousSection().getGlobalFinalToolAxis(), currentSection.getGlobalInitialToolAxis()) ||
    (currentSection.isOptimizedForMachine() && getPreviousSection().isOptimizedForMachine() &&
      Vector.diff(getPreviousSection().getFinalToolAxisABC(), currentSection.getInitialToolAxisABC()).length > 1e-4) ||
    (!machineConfiguration.isMultiAxisConfiguration() && currentSection.isMultiAxis()) ||
    (!getPreviousSection().isMultiAxis() && currentSection.isMultiAxis() ||
      getPreviousSection().isMultiAxis() && !currentSection.isMultiAxis()); // force newWorkPlane between indexing and simultaneous operations
  var forceSmoothing =  properties.useSmoothing &&
    (hasParameter("operation-strategy") && (getParameter("operation-strategy") == "drill") ||
    !isFirstSection() && getPreviousSection().hasParameter("operation-strategy") && (getPreviousSection().getParameter("operation-strategy") == "drill")); // force smoothing in case !insertToolCall (2d chamfer)
  var zIsOutput = false; // true if the Z-position has been output, used for patterns
  
  if (insertToolCall || newWorkOffset || newWorkPlane || forceSmoothing) {

    nullProbeAngle(true);
    // stop spindle before retract during tool change
    if (insertToolCall && !isFirstSection()) {
      onCommand(COMMAND_STOP_SPINDLE);
    }
    
    // retract to safe plane
    writeRetract(Z);
    forceXYZ();
    if ((insertToolCall && !isFirstSection()) || forceSmoothing) {
      disableLengthCompensation();
      setSmoothing(false);
    }
    // Tool Breakage Detection
    if (insertToolCall && !isFirstSection()) {
      if(getPreviousSection().getTool().breakControl != false) {
        setCoolant(COOLANT_OFF);
        writeBlock(mFormat.format(106) + "T" + getPreviousSection().getTool().number + "E"+ properties.breakControlError +"D" + getPreviousSection().getTool().diameter);
        writeRetract(Z)
      }
    }
    // Manual Tool Change Tool Removal
    if (insertToolCall && !isFirstSection()) {
      if(getPreviousSection().getTool().manualToolChange != false) {
        setCoolant(COOLANT_OFF);
        writeBlock(mFormat.format(0))
        writeComment("MANUAL TC REMOVE TOOL PRESS CYCLE START TO RESUME")
      }
    }
  }


  if (hasParameter("operation-comment")) {
    var comment = getParameter("operation-comment");
    if (comment && ((comment !== lastOperationComment) || !patternIsActive || insertToolCall)) {
      writeln("");
      writeComment(comment);
      lastOperationComment = comment;
    } else if (!patternIsActive || insertToolCall) {
      writeln("");
    }
  } else {
    writeln("");
  }
  
  if (properties.showNotes && hasParameter("notes")) {
    var notes = getParameter("notes");
    if (notes) {
      var lines = String(notes).split("\n");
      var r1 = new RegExp("^[\\s]+", "g");
      var r2 = new RegExp("[\\s]+$", "g");
      for (line in lines) {
        var comment = lines[line].replace(r1, "").replace(r2, "");
        if (comment) {
          writeComment(comment);
        }
      }
    }
  }
  
  if (insertToolCall) {
    forceWorkPlane();
    
    setCoolant(COOLANT_OFF);
    
    if (tool.number > 99) {
      warning(localize("Tool number exceeds maximum value."));
    }
    if (!isFirstSection() && properties.optionalStop) {
      onCommand(COMMAND_OPTIONAL_STOP);
    }

    disableLengthCompensation();
    if(properties.ForceTCPosition) {
      writeRetract(Z)
      writeBlock(gFormat.format(53), gFormat.format(90), gFormat.format(0), "X" + xyzFormat.format(properties.TCposX), "Y" + xyzFormat.format(properties.TCposY))
    }
    writeBlock("T" + toolFormat.format(tool.number), mFormat.format(6));

    // Implement Manual Tool Change Option
    var manualToolChange = tool.manualToolChange
    if (tool.manualToolChange != false) {
      writeBlock(mFormat.format(0));
      writeComment("MANUAL TC INSERT TOOL & PRESS CYCLE START TO RESUME");

    }
    //Update Tool Length for breakage detection at end of use
    if(tool.breakControl != false){
      onCommand(COMMAND_TOOL_MEASURE)
      writeRetract(Z)
    }
    if (tool.comment) {
      writeComment(tool.comment);
    }
    var showToolZMin = false;
    if (showToolZMin) {
      if (is3D()) {
        var numberOfSections = getNumberOfSections();
        var zRange = currentSection.getGlobalZRange();
        var number = tool.number;
        for (var i = currentSection.getId() + 1; i < numberOfSections; ++i) {
          var section = getSection(i);
          if (section.getTool().number != number) {
            break;
          }
          zRange.expandToRange(section.getGlobalZRange());
        }
        writeComment(localize("ZMIN") + "=" + zRange.getMinimum());
      }
    }

    if (properties.preloadTool) {
      var nextTool = getNextTool(tool.number);
      if (nextTool) {
        writeBlock("T" + toolFormat.format(nextTool.number));
      } else {
        // preload first tool
        var section = getSection(0);
        var firstToolNumber = section.getTool().number;
        if (tool.number != firstToolNumber) {
          writeBlock("T" + toolFormat.format(firstToolNumber));
        }
      }
    }
  }
  
  if (!isProbeOperation() &&
      (insertToolCall ||
      forceSpindleSpeed ||
      isFirstSection() ||
      (rpmFormat.areDifferent(spindleSpeed, sOutput.getCurrent())) ||
      (tool.clockwise != getPreviousSection().getTool().clockwise))) {
    forceSpindleSpeed = false;
    
    if (spindleSpeed < 1) {
      error(localize("Spindle speed out of range."));
      return;
    }
    if (spindleSpeed > 99999) {
      warning(localize("Spindle speed exceeds maximum value."));
    }
    var tapping = hasParameter("operation:cycleType") &&
      ((getParameter("operation:cycleType") == "tapping") ||
      (getParameter("operation:cycleType") == "right-tapping") ||
      (getParameter("operation:cycleType") == "left-tapping") ||
      (getParameter("operation:cycleType") == "tapping-with-chip-breaking"));
    if (!tapping || (tapping && !(properties.useRigidTapping == "without"))) {
      writeBlock(
        sOutput.format(spindleSpeed), mFormat.format(tool.clockwise ? 3 : 4)
      );
    }

    onCommand(COMMAND_START_CHIP_TRANSPORT);
    if (forceMultiAxisIndexing || !is3D() || machineConfiguration.isMultiAxisConfiguration()) {
      // writeBlock(mFormat.format(xxx)); // shortest path traverse
    }
  }

  // wcs
  if (insertToolCall) { // force work offset when changing tool
    currentWorkOffset = undefined;
  }
  var workOffset = currentSection.workOffset;
  if (workOffset == 0) {
    warningOnce(localize("Work offset has not been specified. Using G54 as WCS."), WARNING_WORK_OFFSET);
    workOffset = 1;
  }
  if (workOffset != currentWorkOffset) {
    if (cancelTiltFirst) {
      cancelWorkPlane();
    }
    forceWorkPlane();
  }
     
  if (workOffset != currentWorkOffset) {
    writeBlock(currentSection.wcs);
    currentWorkOffset = workOffset;
  }

  forceXYZ();

  var abc = defineWorkPlane(currentSection, properties.useAAxis);

  if (g68RotationMode != 0 && (insertToolCall || gRotationModal.getCurrent() == 69)) {
    setProbingAngle();
  }

  // set coolant after we have positioned at Z
  setCoolant(tool.coolant);

  if (properties.useSmoothing) {
    if (hasParameter("operation-strategy") && (getParameter("operation-strategy") != "drill")) {
      if (setSmoothing(true)) {
        // we force G43 using lengthCompensationActive
      }
    } else {
      if (setSmoothing(false)) {
        // we force G43 using lengthCompensationActive
      }
    }
  }

  forceAny();
  gMotionModal.reset();

  var initialPosition = getFramePosition(currentSection.getInitialPosition());
  if (!retracted && !insertToolCall) {
    if (getCurrentPosition().z < initialPosition.z) {
      writeBlock(gMotionModal.format(0), zOutput.format(initialPosition.z));
      zIsOutput = true;
    }
  }

  if (insertToolCall || !lengthCompensationActive || retracted || (!isFirstSection() && getPreviousSection().isMultiAxis())) {
    var lengthOffset = tool.lengthOffset;
    if (lengthOffset > 199) {
      error(localize("Length offset out of range."));
      return;
    }

    gMotionModal.reset();
    writeBlock(gPlaneModal.format(17));
    
    if (!machineConfiguration.isHeadConfiguration()) {
      writeBlock(
        gAbsIncModal.format(90),
        gMotionModal.format(0), xOutput.format(initialPosition.x), yOutput.format(initialPosition.y)
      );
      writeBlock(gMotionModal.format(0), gFormat.format(43), zOutput.format(initialPosition.z), hFormat.format(lengthOffset));
      lengthCompensationActive = true;
    } else {
      writeBlock(
        gAbsIncModal.format(90),
        gMotionModal.format(0),
        gFormat.format(43), xOutput.format(initialPosition.x),
        yOutput.format(initialPosition.y),
        zOutput.format(initialPosition.z), hFormat.format(lengthOffset)
      );
      lengthCompensationActive = true;
    }
    zIsOutput = true;

    gMotionModal.reset();
  } else {
    writeBlock(
      gAbsIncModal.format(90),
      gMotionModal.format(0),
      xOutput.format(initialPosition.x),
      yOutput.format(initialPosition.y)
    );
  }

  validate(lengthCompensationActive, "Length compensation is not active.");

  if (isProbeOperation()) {
    if (g68RotationMode != 0) {
      error(localize("You cannot probe while G68 Rotation is in effect."));
      return;
    }
    angularProbingMode = getAngularProbingMode();
    //writeBlock(mFormat.format(00));// Program pause
    //writeBlock("M" + 10719); // probe on
  }

  // define subprogram
  subprogramDefine(initialPosition, abc, retracted, zIsOutput);

  retracted = false;
}

function onDwell(seconds) {
  if (seconds > 99999.999) {
    warning(localize("Dwelling time is out of range."));
  }
  milliseconds = clamp(1, seconds * 1000, 99999999);
  writeBlock(gFeedModeModal.format(94), gFormat.format(4), "P" + milliFormat.format(milliseconds));
}

function onSpindleSpeed(spindleSpeed) {
  writeBlock(sOutput.format(spindleSpeed));
}

function onCycle() {
  writeBlock(gPlaneModal.format(17));
}

function getCommonCycle(x, y, z, r, c) {
  forceXYZ(); // force xyz on first drill hole of any cycle
  if (incrementalMode) {
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

function setCyclePosition(_position) {
  switch (gPlaneModal.getCurrent()) {
  case 17: // XY
    zOutput.format(_position);
    break;
  case 18: // ZX
    yOutput.format(_position);
    break;
  case 19: // YZ
    xOutput.format(_position);
    break;
  }
}

/** Convert approach to sign. */
function approach(value) {
  validate((value == "positive") || (value == "negative"), "Invalid approach.");
  return (value == "positive") ? 1 : -1;
}

function getRotationalAxis() {
  if (machineConfiguration.getAxisU().isEnabled() &&
      isSameDirection((machineConfiguration.getAxisU().getAxis()).getAbsolute(), new Vector(0, 0, 1)) &&
      machineConfiguration.getAxisU().isTable()) {
    return (machineConfiguration.getAxisU().getCoordinate());
  } else if (machineConfiguration.getAxisV().isEnabled() &&
      isSameDirection((machineConfiguration.getAxisV().getAxis()).getAbsolute(), new Vector(0, 0, 1)) &&
      machineConfiguration.getAxisV().isTable()) {
    return (machineConfiguration.getAxisV().getCoordinate());
  } else if (machineConfiguration.getAxisW().isEnabled() &&
      isSameDirection((machineConfiguration.getAxisW().getAxis()).getAbsolute(), new Vector(0, 0, 1)) &&
      machineConfiguration.getAxisW().isTable()) {
    return (machineConfiguration.getAxisW().getCoordinate());
  } else {
    return -1;
  }
}

/**
  Determine if angular probing is supported.
*/
var rotationalAxis = -1;
var isWCSProbing = false;
var isG54x4Used = false;

function getAngularProbingMode() {
  rotationalAxis = getRotationalAxis();
  isWCSProbing = (hasParameter("operation-strategy") && (getParameter("operation-strategy") == "probe"));
  if (rotationalAxis != -1) {
    return (ANGLE_PROBE_USE_CAXIS);
  } else if (machineConfiguration.getNumberOfAxes() < 5 || is3D()) {
    return (ANGLE_PROBE_USE_ROTATION);
  } else {
    return (ANGLE_PROBE_NOT_SUPPORTED);
  }
}

/**
  Output rotation offset based on angular probing cycle.
*/
function setProbingAngle() {
  if (((g68RotationMode == 1) || (g68RotationMode == 2)) && isWCSProbing) { // Rotate coordinate system for Angle Probing
    if (!properties.useG54x4) {
      if (angularProbingMode == ANGLE_PROBE_USE_ROTATION) {
        gRotationModal.reset();
        gAbsIncModal.reset();
        writeBlock(
          gRotationModal.format(68), gAbsIncModal.format(90),
          (g68RotationMode == 1) ? "X0" : "X[#135]",
          (g68RotationMode == 1) ? "Y0" : "Y[#136]",
          "Z0", "I0.0", "J0.0", "K1.0", "R[#144]"
        );
      } else if (angularProbingMode == ANGLE_PROBE_USE_CAXIS) {
        var workOffset = probeOutputWorkOffset ? probeOutputWorkOffset : currentWorkOffset;
        if (workOffset > 6) {
          error(localize("Angle Probing only supports work offsets 1-6."));
          return;
        }
        var param = 5200 + workOffset * 20 + 5;
        writeBlock("#" + param + " = " + "[#" + param + " + #144]");
        g68RotationMode = 0;
      } else {
        error(localize("Angular Probing is not supported for this machine configuration."));
        return;
      }
    } else if (angularProbingMode != ANGLE_PROBE_NOT_SUPPORTED) {
      isG54x4Used = true;
      writeBlock("#26010=#135");
      writeBlock("#26011=#136");
      writeBlock("#26015=#144");
      writeBlock(gFormat.format(54.4), "P1");
      g68RotationMode = 0;
    } else {
      error(localize("Angular probing is not supported for this machine configuration."));
      return;
    }
  }
}

function protectedProbeMove(_cycle, x, y, z) {
  var _x = xOutput.format(x);
  var _y = yOutput.format(y);
  var _z = zOutput.format(z);
  if (_z && z >= getCurrentPosition().z) {
    writeBlock(gFormat.format(31), _z, feedOutput.format(cycle.feedrate)); // protected positioning move
  }
  if (_x || _y) {
    writeBlock(gFormat.format(31), _x, _y, feedOutput.format(highFeedrate)); // protected positioning move
  }
  if (_z && z < getCurrentPosition().z) {
    writeBlock(gFormat.format(31), _z, feedOutput.format(cycle.feedrate)); // protected positioning move
  }
}

/**
  Null the probing angle when needed.
*/
function nullProbeAngle(force) {
  var cycleType = currentSection.getFirstCycle();
  if (g68RotationMode != 0) {
    writeBlock(gRotationModal.format(69));
  } else if (force && cycleType.indexOf("probing") != -1) {
    gRotationModal.reset();
    forceXYZ();
    writeBlock(gRotationModal.format(69));
  }
}

function onCyclePoint(x, y, z) {
  if (!isSameDirection(getRotation().forward, new Vector(0, 0, 1))) {
    expandCyclePoint(x, y, z);
    return;
  }
  var probeWorkOffsetCode;
  if (isProbeOperation()) {
    if (!useMultiAxisFeatures && !isSameDirection(currentSection.workPlane.forward, new Vector(0, 0, 1)) && (!cycle.probeMode || (cycle.probeMode == 0))) {
      error(localize("Updating WCS / work offset using probing is only supported by the CNC in the WCS frame."));
      return;
    }

    var workOffset = probeOutputWorkOffset ? probeOutputWorkOffset : currentWorkOffset;
    if (workOffset > 106) {
      error(localize("Work offset is out of range." + workOffset));
      return;
    } else {
      probeWorkOffsetCode = workOffset;
    }
  }

  if (isFirstCyclePoint() || isProbeOperation()) {
    if (!isProbeOperation()) {
      // return to initial Z which is clearance plane and set absolute mode
      repositionToCycleClearance(cycle, x, y, z);
    }

    var F = cycle.feedrate;
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
          "Q" + xyzFormat.format(cycle.incrementalDepth),
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
          "Q" + xyzFormat.format(cycle.incrementalDepth),
          // conditional(P > 0, "P" + milliFormat.format(P)),
          feedOutput.format(F)
        );
      }
      break;
    case "tapping":
      if (properties.useRigidTapping != "no") {
        writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
      }
      if (properties.usePitchForTapping) {
        writeBlock(
          gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          pitchOutput.format(tool.threadPitch)
        );
        forceFeed();
      } else {
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (tappingFPM);
        writeBlock(
          gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND) ? 74 : 84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      }
      break;
    case "left-tapping":
      if (properties.useRigidTapping != "no") {
        writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
      }
      if (properties.usePitchForTapping) {
        writeBlock(
          gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          pitchOutput.format(tool.threadPitch)
        );
        forceFeed();
      } else {
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (tappingFPM);
        writeBlock(
          gRetractModal.format(98), gCycleModal.format(74),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          feedOutput.format(F)
        );
      }
      break;
    case "right-tapping":
      if (properties.useRigidTapping != "no") {
        writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
      }
      if (properties.usePitchForTapping) {
        writeBlock(
          gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format(84),
          getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
          "P" + milliFormat.format(P),
          pitchOutput.format(tool.threadPitch)
        );
        forceFeed();
      } else {
        var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
        F = (tappingFPM);
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
        if (properties.useRigidTapping != "no") {
          writeBlock(mFormat.format(29), sOutput.format(spindleSpeed));
        }
        if (properties.usePitchForTapping) {
          writeBlock(
            gRetractModal.format(98), gFeedModeModal.format(95), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84)),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
            pitchOutput.format(tool.threadPitch)
          );
          forceFeed();
        } else {
          var tappingFPM = tool.getThreadPitch() * rpmFormat.getResultingValue(spindleSpeed);
          F = (tappingFPM);
          writeBlock(
            gRetractModal.format(98), gCycleModal.format((tool.type == TOOL_TAP_LEFT_HAND ? 74 : 84)),
            getCommonCycle(x, y, z, cycle.retract, cycle.clearance),
            "P" + milliFormat.format(P),
            "Q" + xyzFormat.format(cycle.incrementalDepth),
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

    case "probing-x":
      forceXYZ();
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(z - cycle.depth), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      SIGN = "B"+approach(cycle.approach1)

      writeBlock(gFormat.format(65), '"PROBEX"', WCS_CODE, SIGN, "D1");
      break;
    case "probing-y":
      forceXYZ();
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(z - cycle.depth), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      SIGN = "B"+approach(cycle.approach1)

      writeBlock(gFormat.format(65), '"PROBEY"', WCS_CODE, SIGN, "D1");
      break;
    case "probing-z":
      forceXYZ();
      Z_START = Math.min(z - cycle.depth + cycle.probeClearance, cycle.retract)
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(Z_START), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      writeBlock(gFormat.format(65), '"PROBEZ"', WCS_CODE);
      break;
    case "probing-x-wall":
      forceXYZ();
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(z), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      WEB_WIDTH="B"+xyzFormat.format(cycle.width1)
      Z_DROP = "C"+xyzFormat.format(cycle.depth),

      writeBlock(gFormat.format(65), '"PROBEXWEB"', WCS_CODE, WEB_WIDTH, Z_DROP, "D1");
      break;
    case "probing-y-wall":
      forceXYZ();
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(z), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      WEB_WIDTH="B"+xyzFormat.format(cycle.width1)
      Z_DROP = "C"+xyzFormat.format(cycle.depth),

      writeBlock(gFormat.format(65), '"PROBEYWEB"', WCS_CODE, WEB_WIDTH, Z_DROP, "D1");
      break;
    case "probing-x-channel":
      error(localize("Unsupported Probing Cycle"));
      GV_X_APPROACH = xyzFormat.format(cycle.width1),
      X_data = formatSetVar(GV_APPROACH1, GV_X_APPROACH),
      
      writeBlock(
        X_data
      );
      writeBlock(
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
        "M" + 10812,
        "X@880 S@860 " + feedOutput.format(cycle.feedrate) + ";"
      );
      break;
    case "probing-x-channel-with-island":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z);
      writeBlock(
        gFormat.format(65), "P" + 9812,
        "X" + xyzFormat.format(cycle.width1),
        zOutput.format(z - cycle.depth),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;
    case "probing-y-channel":
      error(localize("Unsupported Probing Cycle"));
      GV_Y_APPROACH = xyzFormat.format(cycle.width1),
      Y_data = formatSetVar(GV_APPROACH1, GV_Y_APPROACH),
      
      writeBlock(
        Y_data
      );
      writeBlock(
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
        "M" + 10812,
        "Y@880 S@860 " + feedOutput.format(cycle.feedrate) + ";"
      );
      break;
    case "probing-y-channel-with-island":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z);
      writeBlock(
        gFormat.format(65), "P" + 9812,
        "Y" + xyzFormat.format(cycle.width1),
        zOutput.format(z - cycle.depth),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;
    case "probing-xy-circular-boss":
      error(localize("Unsupported Probing Cycle"));
      GV_D_WIDTH = xyzFormat.format(cycle.width1),
      GV_Z_DEPTH = xyzFormat.format(z - cycle.depth),
      GV_Z_CLEARANCE = xyzFormat.format(cycle.probeClearance),
      D_data = formatSetVar(GV_APPROACH1, GV_D_WIDTH),
      Z_data = formatSetVar(GV_DEPTH, GV_Z_DEPTH),
      Z_clearance_data = formatSetVar(GV_CLEARANCE, GV_Z_CLEARANCE),
      writeBlock(
          D_data
      );
      writeBlock(
          Z_data
        );
      writeBlock(
          getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
          "M" + 10814,
          "D@880 Z@882 S@860 " + feedOutput.format(cycle.feedrate) + ";"
      );
      break;
    case "probing-xy-circular-partial-boss":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z);
      writeBlock(
        gFormat.format(65), "P" + 9823,
        "A" + xyzFormat.format(cycle.partialCircleAngleA),
        "B" + xyzFormat.format(cycle.partialCircleAngleB),
        "C" + xyzFormat.format(cycle.partialCircleAngleC),
        "D" + xyzFormat.format(cycle.width1),
        "Z" + xyzFormat.format(z - cycle.depth),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;
    case "probing-xy-circular-hole":
      error(localize("Unsupported Probing Cycle"));
      GV_D_WIDTH = xyzFormat.format(cycle.width1),
      GV_Z_CLEARANCE = xyzFormat.format(cycle.probeClearance),
      D_data = formatSetVar(GV_APPROACH1, GV_D_WIDTH),
      Z_clearance_data = formatSetVar(GV_CLEARANCE, GV_Z_CLEARANCE),
      writeBlock(
          D_data
      );
      writeBlock(
          getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
          "M" + 10814,
          "D@880 S@860 " + feedOutput.format(cycle.feedrate) + ";"
      );
      break;
    case "probing-xy-circular-hole-with-island":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z);
      writeBlock(
        gFormat.format(65), "P" + 9814,
        "Z" + xyzFormat.format(z - cycle.depth),
        "D" + xyzFormat.format(cycle.width1),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;
    case "probing-xy-circular-partial-hole-with-island":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z);
      writeBlock(
        gFormat.format(65), "P" + 9823,
        "Z" + xyzFormat.format(z - cycle.depth),
        "A" + xyzFormat.format(cycle.partialCircleAngleA),
        "B" + xyzFormat.format(cycle.partialCircleAngleB),
        "C" + xyzFormat.format(cycle.partialCircleAngleC),
        "D" + xyzFormat.format(cycle.width1),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;
    case "probing-xy-rectangular-hole":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z - cycle.depth);
      writeBlock(
        gFormat.format(65), "M" + 9812,
        "X" + xyzFormat.format(cycle.width1),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        // not required "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
        "M" + 9812,
        "Y" + xyzFormat.format(cycle.width2),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        // not required "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;
    case "probing-xy-rectangular-boss":
      forceXYZ();
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(z), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      XWEB_WIDTH="B"+xyzFormat.format(cycle.width1)
      YWEB_WIDTH="B"+xyzFormat.format(cycle.width2)
      Z_DROP = "C"+xyzFormat.format(cycle.depth),

      writeBlock(gFormat.format(65), '"PROBEXWEB"', WCS_CODE, XWEB_WIDTH, Z_DROP, "D1");

      writeBlock(gFormat.format(65), '"PROBEYWEB"', WCS_CODE, YWEB_WIDTH, Z_DROP, "D1");
      break;
    case "probing-xy-rectangular-hole-with-island":
      error(localize("Unsupported Probing Cycle"));
      protectedProbeMove(cycle, x, y, z);
      writeBlock(
        "M" + 9812,
        "Z" + xyzFormat.format(z - cycle.depth),
        "X" + xyzFormat.format(cycle.width1),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
        gFormat.format(65), "P" + 9812,
        "Z" + xyzFormat.format(z - cycle.depth),
        "Y" + xyzFormat.format(cycle.width2),
        "Q" + xyzFormat.format(cycle.probeOvertravel),
        "R" + xyzFormat.format(-cycle.probeClearance),
        getProbingArguments(cycle, probeWorkOffsetCode)
      );
      break;

    case "probing-xy-inner-corner":
      error(localize("Unsupported Probing Cycle"));
      GV_X_APPROACH = 0,
      GV_Y_APPROACH = 0,
      GV_Z_DEPTH = xyzFormat.format(z - cycle.depth),
      GV_Z_CLEARANCE = xyzFormat.format(cycle.probeClearance),
      X_data = formatSetVar(GV_APPROACH1, GV_X_APPROACH),
      Y_data = formatSetVar(GV_APPROACH2, GV_X_APPROACH),
      Z_data = formatSetVar(GV_DEPTH, GV_Z_DEPTH),
      Z_clearance_data = formatSetVar(GV_CLEARANCE, GV_Z_CLEARANCE),
      writeBlock(
          X_data
      );
      writeBlock(
          Y_data
        );
      writeBlock(
          getProbingArguments(cycle, probeWorkOffsetCode)
      );
      writeBlock(
          "M" + 10815,
          "X@880 Y@881 S@860 " + feedOutput.format(cycle.feedrate) + ";"
      );
      break;
    case "probing-xy-outer-corner":

      x_approach = approach(cycle.approach1)
      y_approach = approach(cycle.approach2)

      /* corner numbering (as if looking down from top)
      1 2
      4 3
      */

      CORNER_NUM = 0
      if (x_approach > 0 && y_approach < 0) {
        CORNER_NUM = 1
      }
      else if (x_approach < 0 && y_approach < 0) {
        CORNER_NUM = 2
      }
      else if (x_approach < 0 && y_approach > 0) {
        CORNER_NUM = 3
      }
      else if (x_approach > 0 && y_approach > 0) {
        CORNER_NUM = 4
      }

      forceXYZ();
      writeBlock(gFormat.format(31), "P2 ", zOutput.format(z - cycle.depth), "F50");  // protected positioning move 

      WCS_CODE = getProbingArguments(cycle, probeWorkOffsetCode);

      IOCORNER = "B1"

      NUM = "C" + CORNER_NUM

      SPACING = "D"+xyzFormat.format((cycle.probeClearance + tool.diameter / 2 + cycle.probeOvertravel))

      //writeBlock("foo  "+ x +" "+ y+ " "+(cycle.probeClearance + tool.diameter / 2))

      writeBlock(gFormat.format(65), '"PROBEXY"', WCS_CODE, IOCORNER, NUM, SPACING, "E1");
      break;

    case "probing-x-plane-angle":
        error(localize("Unsupported Probing Cycle"));
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        GV_X_APPROACH = xyzFormat.format(cycle.approach1),
        X_data = formatSetVar(GV_APPROACH1, GV_X_APPROACH),
        GV_PROBE_GAP = xyzFormat.format(cycle.probeSpacing),
        GV_PROBE_SPACING_DATA = formatSetVar(GV_PROBE_SPACING, GV_PROBE_GAP),
        X_data = formatSetVar(GV_APPROACH1, GV_X_APPROACH),
        GV_NOMINAL_ANGLE = xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 90),
        GV_NOM_ANG_DATA = formatSetVar(GV_NOM_ANGLE, GV_NOMINAL_ANGLE),
        writeBlock(
          X_data
        );
        writeBlock(
          GV_PROBE_SPACING_DATA
        );
        writeBlock(
          GV_NOM_ANG_DATA
        );
        writeBlock(
          "M" + 10843,
          "X@880 D@883 A@884" + feedOutput.format(cycle.feedrate) + ";"
        );
        g68RotationMode = 1;
        break;
    case "probing-y-plane-angle":
        /*
        protectedProbeMove(cycle, x, y, z - cycle.depth);
        GV_X_APPROACH = xyzFormat.format(cycle.approach1),
        X_data = formatSetVar(GV_APPROACH1, GV_X_APPROACH),
        GV_PROBE_GAP = xyzFormat.format(cycle.probeSpacing),
        GV_PROBE_SPACING_DATA = formatSetVar(GV_PROBE_SPACING, GV_PROBE_GAP),
        X_data = formatSetVar(GV_APPROACH1, GV_X_APPROACH),
        GV_NOMINAL_ANGLE = xyzFormat.format(cycle.nominalAngle != undefined ? cycle.nominalAngle : 90),
        GV_NOM_ANG_DATA = formatSetVar(GV_NOM_ANGLE, GV_NOMINAL_ANGLE),
        writeBlock(
          X_data
        );
        writeBlock(
          GV_PROBE_SPACING_DATA
        );
        writeBlock(
          GV_NOM_ANG_DATA
        );
        writeBlock(
          "M" + 10843,
          "Y@880 D@883 A@884" + feedOutput.format(cycle.feedrate) + ";"
        );
        g68RotationMode = 1;
        */
        error(localize("Unsupported Probing Cycle"));
        break;
      case "probing-xy-pcd-hole":
        error(localize("Unsupported Probing Cycle"));
        break;
      case "probing-xy-pcd-boss":
        error(localize("Unsupported Probing Cycle"));
        break;
      default:
        expandCyclePoint(x, y, z);
      }

      // place cycle operation in subprogram
      if (cycleSubprogramIsActive) {
        if (cycleExpanded || isProbeOperation()) {
          cycleSubprogramIsActive = false;
        } else {
          // call subprogram
          writeBlock(mFormat.format(98), "P" + oFormat.format(currentSubprogram));
          subprogramStart(new Vector(x, y, z), new Vector(0, 0, 0), false);
        }
      }
      if (incrementalMode) { // set current position to clearance height
        setCyclePosition(cycle.clearance);
      }

      // 2nd through nth cycle point
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
          if (incrementalMode) { // set current position to retract height
            setCyclePosition(cycle.retract);
          }
          writeBlock(xOutput.format(x), yOutput.format(y));
          if (incrementalMode) { // set current position to clearance height
            setCyclePosition(cycle.clearance);
          }
        }
      }
}

function getProbingArguments(cycle, probeWorkOffsetCode) {
  var probeWCS = hasParameter("operation-strategy") && (getParameter("operation-strategy") == "probe");

  var PROBE_ARGS = "";
  if (probeOutputWorkOffset < 7) {
    var WCS_NUM = 53+probeOutputWorkOffset;
    PROBE_ARGS = "A"+ WCS_NUM;
  }
  else{
    var WCS_NUM = probeOutputWorkOffset-6;
    PROBE_ARGS = "A54."+ WCS_NUM;
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
    conditional(probeWorkOffsetCode && probeWCS, PROBE_ARGS)
  ];
}

function onCycleEnd() {
  if (isProbeOperation()) {
    zOutput.reset();
    gMotionModal.reset();
  } else {
    if (cycleSubprogramIsActive) {
      subprogramEnd();
      cycleSubprogramIsActive = false;
    }
    if (!cycleExpanded) {
      writeBlock(conditional(properties.usePitchForTapping, gFeedModeModal.format(94)), gCycleModal.format(80));
      zOutput.reset();
    }
  }
}

var pendingRadiusCompensation = -1;

function onRadiusCompensation() {
  pendingRadiusCompensation = radiusCompensation;
}

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

function onLinear(_x, _y, _z, feed) {
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var f = feedOutput.format(feed);
  if (x || y || z) {
    if (pendingRadiusCompensation >= 0) {
      pendingRadiusCompensation = -1;
      var d = tool.diameterOffset;
      if (d > 99) {
        warning(localize("The diameter offset exceeds the maximum value."));
      }
      writeBlock(gPlaneModal.format(17));
      switch (radiusCompensation) {
      case RADIUS_COMPENSATION_LEFT:
        dOutput.reset();
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(41), x, y, z, dOutput.format(d), f);
        break;
      case RADIUS_COMPENSATION_RIGHT:
        dOutput.reset();
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(42), x, y, z, dOutput.format(d), f);
        break;
      default:
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), gFormat.format(40), x, y, z, f);
      }
    } else {
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), x, y, z, f);
    }
  } else if (f) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      forceFeed(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(94), gMotionModal.format(1), f);
    }
  }
}

function onRapid5D(_x, _y, _z, _a, _b, _c) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation mode cannot be changed at rapid traversal."));
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);
  writeBlock(gMotionModal.format(0), x, y, z, a, b, c);
  feedOutput.reset();
}

function onLinear5D(_x, _y, _z, _a, _b, _c, feed) {
  if (!currentSection.isOptimizedForMachine()) {
    error(localize("This post configuration has not been customized for 5-axis simultaneous toolpath."));
    return;
  }
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for 5-axis move."));
    return;
  }
  var x = xOutput.format(_x);
  var y = yOutput.format(_y);
  var z = zOutput.format(_z);
  var a = aOutput.format(_a);
  var b = bOutput.format(_b);
  var c = cOutput.format(_c);

  // get feedrate number
  var f = {frn:0, fmode:0};
  if (a || b || c) {
    f = getMultiaxisFeed(_x, _y, _z, _a, _b, _c, feed);
    if (useInverseTimeFeed) {
      f.frn = inverseTimeOutput.format(f.frn);
    } else {
      f.frn = feedOutput.format(f.frn);
    }
  } else {
    f.frn = feedOutput.format(feed);
    f.fmode = 94;
  }

  if (x || y || z || a || b || c) {
    writeBlock(gFeedModeModal.format(f.fmode), gMotionModal.format(1), x, y, z, a, b, c, f.frn);
  } else if (f.frn) {
    if (getNextRecord().isMotion()) { // try not to output feed without motion
      feedOutput.reset(); // force feed on next line
    } else {
      writeBlock(gFeedModeModal.format(f.fmode), gMotionModal.format(1), f.frn);
    }
  }
}

// Start of multi-axis feedrate logic
/***** Be sure to add 'useInverseTime' to post properties if necessary. *****/
/***** 'inverseTimeOutput' must be defined. *****/
/***** 'headOffset' should be defined when a head rotary axis is defined. *****/
/***** The feedrate mode must be included in motion block output (linear, circular, etc. *****/
var dpmBPW = 0.1; // ratio of rotary accuracy to linear accuracy for DPM calculations
var inverseTimeUnits = 1.0; // 1.0 = minutes, 60.0 = seconds
var maxInverseTime = 9999; // maximum value to output for Inverse Time feeds

// Start of multi-axis feedrate logic
/***** You can add 'properties.useInverseTime' if desired. *****/
/***** 'previousABC' can be added throughout to maintain previous rotary positions. Required for Mill/Turn machines. *****/
/***** 'headOffset' should be defined when a head rotary axis is defined. *****/
/***** The feedrate mode must be included in motion block output (linear, circular, etc.) for Inverse Time feedrate support. *****/
var dpmBPW = 0.1; // ratio of rotary accuracy to linear accuracy for DPM calculations
var inverseTimeUnits = 1.0; // 1.0 = minutes, 60.0 = seconds
var maxInverseTime = 9999; // maximum value to output for Inverse Time feeds
var maxDPM = 9999.99; // maximum value to output for DPM feeds
var useInverseTimeFeed = properties.useInverseTime; // use 1/T feeds
var inverseTimeFormat = createFormat({decimals:(unit == MM ? 1 : 2), forceDecimal:true});
var inverseTimeOutput = createVariable({prefix:"F", force:true}, inverseTimeFormat);
var previousDPMFeed = 0; // previously output DPM feed
var dpmFeedToler = 0.5; // tolerance to determine when the DPM feed has changed
// var previousABC = new Vector(0, 0, 0); // previous ABC position if maintained in post, don't define if not used
var forceOptimized = undefined; // used to override optimized-for-angles points (XZC-mode)

/** Calculate the multi-axis feedrate number. */
function getMultiaxisFeed(_x, _y, _z, _a, _b, _c, feed) {
  var f = {frn:0, fmode:0};
  if (feed <= 0) {
    error(localize("Feedrate is less than or equal to 0."));
    return f;
  }
  
  var length = getMoveLength(_x, _y, _z, _a, _b, _c);
  
  if (useInverseTimeFeed) { // inverse time
    f.frn = getInverseTime(length.tool, feed);
    f.fmode = 93;
    feedOutput.reset();
  } else { // degrees per minute
    f.frn = getFeedDPM(length, feed);
    f.fmode = 94;
  }
  return f;
}

/** Returns point optimization mode. */
function getOptimizedMode() {
  if (forceOptimized != undefined) {
    return forceOptimized;
  }
  // return (currentSection.getOptimizedTCPMode() != 0); // TAG:doesn't return correct value
  return true; // always return false for non-TCP based heads
}
  
/** Calculate the DPM feedrate number. */
function getFeedDPM(_moveLength, _feed) {
  if ((_feed == 0) || (_moveLength.tool < 0.0001) || (toDeg(_moveLength.abcLength) < 0.0005)) {
    previousDPMFeed = 0;
    return _feed;
  }
  var moveTime = _moveLength.tool / _feed;
  if (moveTime == 0) {
    previousDPMFeed = 0;
    return _feed;
  }

  var dpmFeed;
  var tcp = false; // !getOptimizedMode() && (forceOptimized == undefined);   // set to false for rotary heads
  if (tcp) { // TCP mode is supported, output feed as FPM
    dpmFeed = _feed;
  } else if (false) { // standard DPM
    dpmFeed = Math.min(toDeg(_moveLength.abcLength) / moveTime, maxDPM);
    if (Math.abs(dpmFeed - previousDPMFeed) < dpmFeedToler) {
      dpmFeed = previousDPMFeed;
    }
  } else if (true) { // combination FPM/DPM
    var length = Math.sqrt(Math.pow(_moveLength.xyzLength, 2.0) + Math.pow((toDeg(_moveLength.abcLength) * dpmBPW), 2.0));
    dpmFeed = Math.min((length / moveTime), maxDPM);
    if (Math.abs(dpmFeed - previousDPMFeed) < dpmFeedToler) {
      dpmFeed = previousDPMFeed;
    }
  } else { // machine specific calculation
    dpmFeed = _feed;
  }
  previousDPMFeed = dpmFeed;
  return dpmFeed;
}

/** Calculate the Inverse time feedrate number. */
function getInverseTime(_length, _feed) {
  var inverseTime;
  if (_length < 1.e-6) { // tool doesn't move
    if (typeof maxInverseTime === "number") {
      inverseTime = maxInverseTime;
    } else {
      inverseTime = 999999;
    }
  } else {
    inverseTime = _feed / _length / inverseTimeUnits;
    if (typeof maxInverseTime === "number") {
      if (inverseTime > maxInverseTime) {
        inverseTime = maxInverseTime;
      }
    }
  }
  return inverseTime;
}

/** Calculate radius for each rotary axis. */
function getRotaryRadii(startTool, endTool, startABC, endABC) {
  var radii = new Vector(0, 0, 0);
  var startRadius;
  var endRadius;
  var axis = new Array(machineConfiguration.getAxisU(), machineConfiguration.getAxisV(), machineConfiguration.getAxisW());
  for (var i = 0; i < 3; ++i) {
    if (axis[i].isEnabled()) {
      var startRadius = getRotaryRadius(axis[i], startTool, startABC);
      var endRadius = getRotaryRadius(axis[i], endTool, endABC);
      radii.setCoordinate(axis[i].getCoordinate(), Math.max(startRadius, endRadius));
    }
  }
  return radii;
}

/** Calculate the distance of the tool position to the center of a rotary axis. */
function getRotaryRadius(axis, toolPosition, abc) {
  if (!axis.isEnabled()) {
    return 0;
  }

  var direction = axis.getEffectiveAxis();
  var normal = direction.getNormalized();
  // calculate the rotary center based on head/table
  var center;
  var radius;
  if (axis.isHead()) {
    var pivot;
    if (typeof headOffset === "number") {
      pivot = headOffset;
    } else {
      pivot = tool.getBodyLength();
    }
    if (axis.getCoordinate() == machineConfiguration.getAxisU().getCoordinate()) { // rider
      center = Vector.sum(toolPosition, Vector.product(machineConfiguration.getDirection(abc), pivot));
      center = Vector.sum(center, axis.getOffset());
      radius = Vector.diff(toolPosition, center).length;
    } else { // carrier
      var angle = abc.getCoordinate(machineConfiguration.getAxisU().getCoordinate());
      radius = Math.abs(pivot * Math.sin(angle));
      radius += axis.getOffset().length;
    }
  } else {
    center = axis.getOffset();
    var d1 = toolPosition.x - center.x;
    var d2 = toolPosition.y - center.y;
    var d3 = toolPosition.z - center.z;
    var radius = Math.sqrt(
      Math.pow((d1 * normal.y) - (d2 * normal.x), 2.0) +
      Math.pow((d2 * normal.z) - (d3 * normal.y), 2.0) +
      Math.pow((d3 * normal.x) - (d1 * normal.z), 2.0)
    );
  }
  return radius;
}
  
/** Calculate the linear distance based on the rotation of a rotary axis. */
function getRadialDistance(radius, startABC, endABC) {
  // calculate length of radial move
  var delta = Math.abs(endABC - startABC);
  if (delta > Math.PI) {
    delta = 2 * Math.PI - delta;
  }
  var radialLength = (2 * Math.PI * radius) * (delta / (2 * Math.PI));
  return radialLength;
}
  
/** Calculate tooltip, XYZ, and rotary move lengths. */
function getMoveLength(_x, _y, _z, _a, _b, _c) {
  // get starting and ending positions
  var moveLength = {};
  var startTool;
  var endTool;
  var startXYZ;
  var endXYZ;
  var startABC;
  if (typeof previousABC !== "undefined") {
    startABC = new Vector(previousABC.x, previousABC.y, previousABC.z);
  } else {
    startABC = getCurrentDirection();
  }
  var endABC = new Vector(_a, _b, _c);
    
  if (!getOptimizedMode()) { // calculate XYZ from tool tip
    startTool = getCurrentPosition();
    endTool = new Vector(_x, _y, _z);
    startXYZ = startTool;
    endXYZ = endTool;

    // adjust points for tables
    if (!machineConfiguration.getTableABC(startABC).isZero() || !machineConfiguration.getTableABC(endABC).isZero()) {
      startXYZ = machineConfiguration.getOrientation(machineConfiguration.getTableABC(startABC)).getTransposed().multiply(startXYZ);
      endXYZ = machineConfiguration.getOrientation(machineConfiguration.getTableABC(endABC)).getTransposed().multiply(endXYZ);
    }

    // adjust points for heads
    if (machineConfiguration.getAxisU().isEnabled() && machineConfiguration.getAxisU().isHead()) {
      if (typeof getOptimizedHeads === "function") { // use post processor function to adjust heads
        startXYZ = getOptimizedHeads(startXYZ.x, startXYZ.y, startXYZ.z, startABC.x, startABC.y, startABC.z);
        endXYZ = getOptimizedHeads(endXYZ.x, endXYZ.y, endXYZ.z, endABC.x, endABC.y, endABC.z);
      } else { // guess at head adjustments
        var startDisplacement = machineConfiguration.getDirection(startABC);
        startDisplacement.multiply(headOffset);
        var endDisplacement = machineConfiguration.getDirection(endABC);
        endDisplacement.multiply(headOffset);
        startXYZ = Vector.sum(startTool, startDisplacement);
        endXYZ = Vector.sum(endTool, endDisplacement);
      }
    }
  } else { // calculate tool tip from XYZ, heads are always programmed in TCP mode, so not handled here
    startXYZ = getCurrentPosition();
    endXYZ = new Vector(_x, _y, _z);
    startTool = machineConfiguration.getOrientation(machineConfiguration.getTableABC(startABC)).multiply(startXYZ);
    endTool = machineConfiguration.getOrientation(machineConfiguration.getTableABC(endABC)).multiply(endXYZ);
  }

  // calculate axes movements
  moveLength.xyz = Vector.diff(endXYZ, startXYZ).abs;
  moveLength.xyzLength = moveLength.xyz.length;
  moveLength.abc = Vector.diff(endABC, startABC).abs;
  for (var i = 0; i < 3; ++i) {
    if (moveLength.abc.getCoordinate(i) > Math.PI) {
      moveLength.abc.setCoordinate(i, 2 * Math.PI - moveLength.abc.getCoordinate(i));
    }
  }
  moveLength.abcLength = moveLength.abc.length;

  // calculate radii
  moveLength.radius = getRotaryRadii(startTool, endTool, startABC, endABC);
  
  // calculate the radial portion of the tool tip movement
  var radialLength = Math.sqrt(
    Math.pow(getRadialDistance(moveLength.radius.x, startABC.x, endABC.x), 2.0) +
    Math.pow(getRadialDistance(moveLength.radius.y, startABC.y, endABC.y), 2.0) +
    Math.pow(getRadialDistance(moveLength.radius.z, startABC.z, endABC.z), 2.0)
  );
  
  // calculate the tool tip move length
  // tool tip distance is the move distance based on a combination of linear and rotary axes movement
  moveLength.tool = moveLength.xyzLength + radialLength;

  // debug
  if (false) {
    writeComment("DEBUG - tool   = " + moveLength.tool);
    writeComment("DEBUG - xyz    = " + moveLength.xyz);
    var temp = Vector.product(moveLength.abc, 180 / Math.PI);
    writeComment("DEBUG - abc    = " + temp);
    writeComment("DEBUG - radius = " + moveLength.radius);
  }
  return moveLength;
}
// End of multi-axis feedrate logic

function onCircular(clockwise, cx, cy, cz, x, y, z, feed) {
  if (pendingRadiusCompensation >= 0) {
    error(localize("Radius compensation cannot be activated/deactivated for a circular move."));
    return;
  }

  var start = getCurrentPosition();

  if (isFullCircle()) {
    if (properties.useRadius || isHelical()) { // radius mode does not support full arcs
      linearize(tolerance);
      return;
    }
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), feedOutput.format(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), feedOutput.format(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), feedOutput.format(feed));
      break;
    default:
      linearize(tolerance);
    }
  } else if (!properties.useRadius) {
    switch (getCircularPlane()) {
    case PLANE_XY:
      writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), jOutput.format(cy - start.y, 0), feedOutput.format(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), iOutput.format(cx - start.x, 0), kOutput.format(cz - start.z, 0), feedOutput.format(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), jOutput.format(cy - start.y, 0), kOutput.format(cz - start.z, 0), feedOutput.format(feed));
      break;
    default:
      if (properties.allow3DArcs) {
        // make sure maximumCircularSweep is well below 360deg
        // we could use G02.4 or G03.4 - direction is calculated
        var ip = getPositionU(0.5);
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2.4 : 3.4), xOutput.format(ip.x), yOutput.format(ip.y), zOutput.format(ip.z), feedOutput.format(feed));
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
      writeBlock(gPlaneModal.format(17), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), feedOutput.format(feed));
      break;
    case PLANE_ZX:
      writeBlock(gPlaneModal.format(18), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), feedOutput.format(feed));
      break;
    case PLANE_YZ:
      writeBlock(gPlaneModal.format(19), gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2 : 3), xOutput.format(x), yOutput.format(y), zOutput.format(z), "R" + rFormat.format(r), feedOutput.format(feed));
      break;
    default:
      if (properties.allow3DArcs) {
        // make sure maximumCircularSweep is well below 360deg
        // we could use G02.4 or G03.4 - direction is calculated
        var ip = getPositionU(0.5);
        writeBlock(gFeedModeModal.format(94), gMotionModal.format(clockwise ? 2.4 : 3.4), xOutput.format(ip.x), yOutput.format(ip.y), zOutput.format(ip.z), feedOutput.format(feed));
        writeBlock(xOutput.format(x), yOutput.format(y), zOutput.format(z));
      } else {
        linearize(tolerance);
      }
    }
  }
}

var currentCoolantMode = COOLANT_OFF;
var coolantOff = undefined;

function setCoolant(coolant) {
  var coolantCodes = getCoolantCodes(coolant);
  if (Array.isArray(coolantCodes)) {
    if (singleLineCoolant) {
      writeBlock(coolantCodes.join(getWordSeparator()));
    } else {
      for (var c in coolantCodes) {
        writeBlock(coolantCodes[c]);
      }
    }
    return undefined;
  }
  return coolantCodes;
}

function getCoolantCodes(coolant) {
  var multipleCoolantBlocks = new Array(); // create a formatted array to be passed into the outputted line
  if (!coolants) {
    error(localize("Coolants have not been defined."));
  }
  if (isProbeOperation()) { // avoid coolant output for probing
    coolant = COOLANT_OFF;
  }
  if (coolant == currentCoolantMode) {
    return undefined; // coolant is already active
  }
  if ((coolant != COOLANT_OFF) && (currentCoolantMode != COOLANT_OFF) && (coolantOff != undefined)) {
    if (Array.isArray(coolantOff)) {
      for (var i in coolantOff) {
        multipleCoolantBlocks.push(mFormat.format(coolantOff[i]));
      }
    } else {
      multipleCoolantBlocks.push(mFormat.format(coolantOff));
    }
  }

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
        multipleCoolantBlocks.push(mFormat.format(m[i]));
      }
    } else {
      multipleCoolantBlocks.push(mFormat.format(m));
    }
    currentCoolantMode = coolant;
    return multipleCoolantBlocks; // return the single formatted coolant value
  }
  return undefined;
}

var mapCommand = {
  COMMAND_STOP:0,
  COMMAND_OPTIONAL_STOP:1,
  COMMAND_END:2,
  COMMAND_SPINDLE_CLOCKWISE:3,
  COMMAND_SPINDLE_COUNTERCLOCKWISE:4,
  COMMAND_STOP_SPINDLE:5,
  COMMAND_ORIENTATE_SPINDLE:19
};

function onCommand(command) {
  switch (command) {
  case COMMAND_STOP:
    writeBlock(mFormat.format(0));
    forceSpindleSpeed = true;
    return;
  case COMMAND_START_SPINDLE:
    onCommand(tool.clockwise ? COMMAND_SPINDLE_CLOCKWISE : COMMAND_SPINDLE_COUNTERCLOCKWISE);
    return;
  case COMMAND_LOCK_MULTI_AXIS:
    if (properties.multiaxislocking){
      writeBlock(mFormat.format(11));
    }
    return;
  case COMMAND_UNLOCK_MULTI_AXIS:
    if (properties.multiaxislocking){
      writeBlock(mFormat.format(10));
    }
    return;
  case COMMAND_START_CHIP_TRANSPORT:
    return;
  case COMMAND_STOP_CHIP_TRANSPORT:
    return;
  case COMMAND_BREAK_CONTROL:
    writeRetract(Z)
    onCommand(COMMAND_STOP_SPINDLE);
    setCoolant(COOLANT_OFF)
    writeBlock(mFormat.format(106) + "T" + tool.number + "E"+ properties.breakControlError +"D" + tool.diameter);
    writeRetract(Z)
    return;
  case COMMAND_TOOL_MEASURE:
    writeBlock(mFormat.format(103) + "T" + tool.number + "D" + tool.diameter);
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
  writeBlock(gPlaneModal.format(17));
  
  if (currentSection.isMultiAxis()) {
    writeBlock(gFeedModeModal.format(94)); // inverse time feed off
  }
  if (!isLastSection() && (getNextSection().getTool().coolant != tool.coolant)) {
    setCoolant(COOLANT_OFF);
  }

  if (true) {
    if (isRedirecting()) {
      if (firstPattern) {
        var finalPosition = getFramePosition(currentSection.getFinalPosition());
        var abc;
        if (currentSection.isMultiAxis() && machineConfiguration.isMultiAxisConfiguration()) {
          abc = currentSection.getFinalToolAxisABC();
        } else {
          abc = currentWorkPlaneABC;
        }
        if (abc == undefined) {
          abc = new Vector(0, 0, 0);
        }
        setAbsoluteMode(finalPosition, abc);
        subprogramEnd();
      }
    }
  }
  if (isProbeOperation()) {
    //writeBlock("M" + 10720); // probe off
    //writeBlock(mFormat.format(00)); // program pause
    if (properties.useG54x4 || angularProbingMode == ANGLE_PROBE_USE_CAXIS) {
      setProbingAngle(); // define rotation of part
    }
  }
  forceAny();
}

/** Output block to do safe retract and/or move to home position. */
function writeRetract() {
  if (arguments.length == 0) {
    error(localize("No axis specified for writeRetract()."));
    return;
  }
  if (properties.useG53saferetract){
    var words = []; // store all retracted axes in an array
    for (var i = 0; i < arguments.length; ++i) {
      let instances = 0; // checks for duplicate retract calls
      for (var j = 0; j < arguments.length; ++j) {
        if (arguments[i] == arguments[j]) {
          ++instances;
        }
      }
      if (instances > 1) { // error if there are multiple retract calls for the same axis
        error(localize("Cannot retract the same axis twice in one line"));
        return;
      }
      switch (arguments[i]) {
      case X:
        words.push("X" + xyzFormat.format(properties.g53homeX));
        break;
      case Y:
        words.push("Y" + xyzFormat.format(properties.g53homeY));
        break;
      case Z:
        words.push("Z" + xyzFormat.format(0));
        retracted = true; // specifies that the tool has been retracted to the safe plane
        break;
      default:
        error(localize("Bad axis specified for writeRetract()."));
        return;
      }
    }
    if (words.length > 0) {
      gMotionModal.reset();
      gAbsIncModal.reset();
      writeBlock(gFormat.format(53), gAbsIncModal.format(90), gFormat.format(0), words); // G53 retract & Home
    }
  
  } else {
    var words = []; // store all retracted axes in an array
    for (var i = 0; i < arguments.length; ++i) {
      let instances = 0; // checks for duplicate retract calls
      for (var j = 0; j < arguments.length; ++j) {
        if (arguments[i] == arguments[j]) {
          ++instances;
        }
      }
      if (instances > 1) { // error if there are multiple retract calls for the same axis
        error(localize("Cannot retract the same axis twice in one line"));
        return;
      }
      switch (arguments[i]) {
      case X:
        words.push("X" + xyzFormat.format(machineConfiguration.hasHomePositionX() ? machineConfiguration.getHomePositionX() : 0));
        break;
      case Y:
        words.push("Y" + xyzFormat.format(machineConfiguration.hasHomePositionY() ? machineConfiguration.getHomePositionY() : 0));
        break;
      case Z:
        words.push("Z" + xyzFormat.format(machineConfiguration.getRetractPlane()));
        retracted = true; // specifies that the tool has been retracted to the safe plane
        break;
      default:
        error(localize("Bad axis specified for writeRetract()."));
        return;
      }
    }
    if (words.length > 0) {
      gMotionModal.reset();
      gAbsIncModal.reset();
      writeBlock(gFormat.format(28), gAbsIncModal.format(91), words); // retract
      writeBlock(gAbsIncModal.format(90));
    }
  }  
  zOutput.reset();
}

function onClose() {
  nullProbeAngle(false);
  writeln("");
  optionalSection = false;

  setCoolant(COOLANT_OFF);

  writeRetract(Z);
  
  disableLengthCompensation(true);
  setSmoothing(false);
  zOutput.reset();

  setWorkPlane(new Vector(0, 0, 0)); // reset working plane
  
  if (isG54x4Used) {
    writeBlock(gFormat.format(54.4), "P0");
  }

  writeRetract(X, Y);

  onImpliedCommand(COMMAND_END);
  onImpliedCommand(COMMAND_STOP_SPINDLE);
  writeBlock(mFormat.format(30)); // stop program, spindle stop, coolant off
  if (subprograms.length > 0) {
    writeln("");
    write(subprograms);
  }
  writeln("%");
}