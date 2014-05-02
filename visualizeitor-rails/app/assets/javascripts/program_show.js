// TODO: Criar estrutura de controle das rows e columns
// de forma a não precisar iterar 3 vezes sobre os program_items

var _program;

$(document).ready(function() {

  registerCallBacks();
  controlLoading();

	var programId = $('#program_id').val();

	var url = '/programs/'+ programId + '.json';

  $.ajax({
      url: url,
      type: 'get',
      data: {},
      success: function (data) {
        _program = data;
        var $container = $('#program-container');
        drawProgram(data, $container);
      }
    });
});

function controlLoading() {
  $(document).ajaxStart(function () {
    $('#loading').show('slow');
  });

  $(document).ajaxStop(function () {
    $('#loading').hide('slow');

  });
};

function registerCallBacks()
{
  registerClickCallbacks('.button-down', didClickButtonDown);
  registerClickCallbacks('.button-up', didClickButtonUp);
  registerClickCallbacks('.button-info', didClickButtonInfo);
};

function registerClickCallbacks(aSelector, callBackFunction)
{
  $(document).on('click', aSelector, function() {
    callBackFunction($(this));
  });
};

function programItemIdForButton(button) {
  return $(button).attr("course_id");
}

function didClickButtonUp(sender)
{
  var programItemId = programItemIdForButton(sender);
  var programItem = programItemWithId(programItemId);

  var programItemAbove = programItemWithRowAndColumn(programItem.row - 1, programItem.column);

  if (programItemAbove === null) {
    return;
  }

  programItemAbove.row = programItem.row;
  programItem.row = programItem.row - 1;

  programItemAbove.needsUpdate = true;
  programItem.needsUpdate = true;

  var indexAbove = indexForProgramItem(programItemAbove);
  var indexProgramItem = indexForProgramItem(programItem);

  _program.program_items[indexAbove] = programItem;
  _program.program_items[indexProgramItem] = programItemAbove;

  redraw();

};

function redraw()
{
  var $container = $('#program-container');
  $container.html('');
  drawProgram(_program, $container);
};

function didClickButtonDown(sender)
{

  var programItemId = programItemIdForButton(sender);
  var programItem = programItemWithId(programItemId);
  var programItemBelow = programItemWithRowAndColumn(programItem.row + 1, programItem.column);

  if (programItemBelow === null) {
    return;
  }

  programItemBelow.row = programItem.row;
  programItem.row = programItem.row + 1;

  programItem.needsUpdate = true;
  programItemBelow.needsUpdate = true;

  var indexAbove = indexForProgramItem(programItemBelow);
  var indexProgramItem = indexForProgramItem(programItem);

  _program.program_items[indexAbove] = programItem;
  _program.program_items[indexProgramItem] = programItemBelow;

  redraw();

};

function didClickButtonInfo(sender)
{
  var programItemId = courseIdForButton(sender);

};

function programItemWithId(id)
{
  var i = 0;
  var programItems = _program.program_items;
  var programItem;
  var intId = parseInt(id);

  for (i = 0; i < programItems.length; i++) {
    programItem = programItems[i];
    if (programItem.id === intId) {
      return programItem;
    }
  }
  return null;
};

function programItemWithRowAndColumn(row, column) {
  var i = 0;
  var programItems = _program.program_items;
  var programItem;

  for (i = 0; i < programItems.length; i++) {
    programItem = programItems[i];
    if (programItem.row === row && programItem.column === column) {
      return programItem;
    }
  }
  return null;
};

function indexForProgramItem(aProgramItem)
{
  var i = 0;
  var programItems = _program.program_items;
  var programItem;

  for (i = 0; i < programItems.length; i++) {
    programItem = programItems[i];
    if (programItem == aProgramItem) {
      return i;
    }
  }
  return -1;
};

function save()
{
  var programId = $('#program_id').val();
  var url = '/programs/'+ programId + '.json';

  var json = buildJson(_program);

  $.ajax({
      url: url,
      type: 'PUT',
      data: json,
      success: function (data) {
        $('#did-save-alert').show("slow").delay(1000).hide("slow");
      },
      error: function() {
        $('#did-not-save-alert').show("slow").delay(1000).hide("slow");
      }
    });
};

function buildJson(program)
{
  var json = {};
  var t = {};
  t.id = program.id;
  json['program'] = t;
  json['program']['program_items_attributes'] = [];

  var i = 0;
  for (i = 0; i < program.program_items.length; i++) {
    var programItem = program.program_items[i];

    if (programItem.needsUpdate) {
      var hashProgramItem = {};
      hashProgramItem.id = programItem.id;
      hashProgramItem.row = programItem.row;
      hashProgramItem.column = programItem.column;
      json['program']['program_items_attributes'].push(hashProgramItem);
      programItem.needsUpdate = false;
    }

  }

  return json;

};


