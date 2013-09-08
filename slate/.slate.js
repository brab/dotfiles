// configs
slate.configAll({
  defaultToCurrentScreen: true,
  nudgePercentOf: 'screenSize',
  resizePercentOf: 'screenSize',
  windowHintsDuration: 5,
  windowHintsIgnoreHiddenWindows: true,
  windowHintsShowIcons: false,
  windowHintsSpread: true
});

// monitors
var monMacbook = '1440x900',
    monExt24 = '1920x1080';

// operations
var macbookFull = slate.op('move', {
  screen: monMacbook,
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY'
});
var ext24Full = slate.op('move', {
  screen: monExt24,
  x: 'screenOriginX',
  y: 'screenOriginY',
  width: 'screenSizeX',
  height: 'screenSizeY'
});

var macbookLeft = macbookFull.dup({ width: 'screenSizeX/2' });
var macbookRight = macbookLeft.dup({ x: 'screenOriginX + screenSizeX/2' });
var macbookLeftBg = macbookFull.dup({ width: 'screenSizeX*3/5' });
var macbookRightSm = macbookFull.dup({
  x: 'screenOriginX + screenSizeX*3/5',
  width: 'screenSizeX*2/5'
});

var ext24Left = ext24Full.dup({ width: 'screenSizeX/2' });
var ext24Right = ext24Left.dup({ x: 'screenOriginX + screenSizeX/2' });
var ext24LeftBg = ext24Full.dup({ width: 'screenSizeX*7/10' });
var ext24RightSm = ext24Full.dup({
  x: 'screenOriginX + screenSizeX*7/10',
  width: 'screenSizeX*3/10'
});

var macbookChainLeft = slate.op('chain', {
  operations: [macbookLeftBg, macbookLeft]
});
var macbookChainRight = slate.op('chain', {
  operations: [macbookRight, macbookRightSm]
});
var ext24ChainLeft = slate.op('chain', {
  operations: [ext24LeftBg, ext24Left]
});
var ext24ChainRight = slate.op('chain', {
  operations: [ext24Right, ext24RightSm]
});

// layout hashes
var chromeHashMacbook = {
  operations: [macbookFull],
  repeat: true,
  'ignore-fail': true
};
var itermHashMacbook = {
  operations: [macbookRightSm],
  repeat: true
};
var mvimHashMacbook = {
  operations: [macbookFull],
  repeat: true
};

var itermHashExt24 = {
  operations: [ext24RightSm],
  repeat: true
};
var mvimHashExt24 = {
  operations: [ext24LeftBg],
  repeat: true
};

// layouts
var oneMonitorLayout = slate.layout('oneMonitor', {
  'Google Chrome': chromeHashMacbook,
  'MacVim': mvimHashMacbook,
  'iTerm': itermHashMacbook
});
var twoMonitorLayout = slate.layout('twoMonitors', {
  'Google Chrome': chromeHashMacbook,
  'MacVim': mvimHashExt24,
  'iTerm': itermHashExt24
});

slate.def([monMacbook], oneMonitorLayout);
slate.def([monMacbook, monExt24], twoMonitorLayout);

var oneMonitor = slate.op('layout', { name: oneMonitorLayout });
var twoMonitors = slate.op('layout', { name: twoMonitorLayout });
var universalLayout = function() {
  if (slate.screenCount() === 1) {
    oneMonitor.run();
  } else if (slate.screenCount() === 2) {
    twoMonitors.run();
  }
};

// bindings
slate.bindAll({
  'h:ctrl;alt;cmd': slate.op('hint', { characters: '1234567890' }),
  'g:ctrl;alt;cmd': slate.op('grid'),
  'l:ctrl;alt;cmd': universalLayout,
  '/:ctrl;alt;cmd': function(currentWindow) {
    var screen = slate.screen(),
        screenSize = screen.rect().width + 'x' + screen.rect().height;
    if (screenSize == monMacbook) {
      macbookFull.run();
    } else if (screenSize == monExt24) {
      ext24Full.run();
    }
  },
  'left:ctrl;alt;cmd': function(currentWindow) {
    var screen = slate.screen(),
        screenSize = screen.rect().width + 'x' + screen.rect().height;
    if (screenSize == monMacbook) {
      macbookChainLeft.run();
    } else if (screenSize == monExt24) {
      ext24ChainLeft.run();
    }
  },
  'right:ctrl;alt;cmd': function(currentWindow) {
    var screen = slate.screen(),
        screenSize = screen.rect().width + 'x' + screen.rect().height;
    if (screenSize == monMacbook) {
      macbookChainRight.run();
    } else if (screenSize == monExt24) {
      ext24ChainRight.run();
    }
  }
});
