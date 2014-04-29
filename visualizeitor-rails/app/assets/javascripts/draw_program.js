function drawProgram(program, $container)
{
  var programItems = program.program_items;
  var lastProgramItem = programItems[programItems.length - 1];

  numberOfColumns = lastProgramItem.column + 1;

  createCoursesContainers(numberOfColumns, $container);
  createCourses(program.program_items);

  debug(numberOfColumns);
};

function createCoursesContainers(numberOfPeriods, $container) {
  var i = 0;
  var coursesContainer;
  $container.html('');
  for (i = 0; i < numberOfPeriods; i++) {
    coursesContainer = '<div class="courses-container" id="courses-container-' + i +'"></div>';
    $container.append(coursesContainer);
  }
};

function createCourses(courses) {

  var course;
  var i = 0;
  var courseElement;
  for (i = 0; i < courses.length; i++) {
    course = courses[i];
    courseElement = createCourseElement(course, i);
    insertCourseElement(courseElement, course);
  }

};

function insertCourseElement(courseElement, course) {
  var courseContainerId = '#courses-container-' + course.column;
  var courseContainer = $(courseContainerId);
  courseContainer.append(courseElement);

};

function createCourseElement(course, index) {
  var courseElement = '<div class="course-element" id="'+generateElementId('course', index)+'">'+insideOfCourseElement(course)+'</div>'
  return courseElement;
};

function generateElementId(elementName, index) {
  return elementName + '-' + index;
};

function insideOfCourseElement(course) {
  var r = '<div class="course-element-content">'+
  course.course.name+'<div class="course-element-code">'+course.course.code+'</div></div><div class="course-element-control">'+insideOfCourseControl(course)+'</div>'
  return r;
};

function insideOfCourseControl(course) {
  var r = '<div class="button-up" course_id="'+course.id+'"></div><div class="button-down" course_id="'+course.id+'"></div><div class="button-info" course_id="'+course.id+'"></div>';
  return r;
}



function debug(object)
{
  var JSONtext = JSON.stringify(object, null, 2);
  console.log(JSONtext);
}