var BASE_URL = "https://api.judge0.com";
var sourceEditor, inputEditor, expectedOutputEditor, actualOutputEditor, statusEditor;

var controlsDisabled = false;
function toggleControlsAndLoader() {
  controlsDisabled = !controlsDisabled;
  $("#loader").css("visibility", controlsDisabled ? "visible" : "hidden");
  $("#run-button").attr("disabled", controlsDisabled);
  $("#select-language").attr("disabled", controlsDisabled);
}

function changeLanguage(e) {
  var $selectTag = $("#select-language");
  sourceEditor.setOption("mode", $selectTag.find(":selected").attr("mode"));
};

function runSource() {
  toggleControlsAndLoader();

  var source = sourceEditor.getValue();
  var input = inputEditor.getValue();
  var expectedOutput = expectedOutputEditor.getValue();
  var language = $("#select-language").val();

  var data = {
    source_code: source,
    language_id: language,
    input: input,
    expected_output: expectedOutput
  };

  var submission_id;
  $.ajax({
      url: BASE_URL + "/submissions",
      type: "POST",
      async: false,
      contentType: "application/json",
      data: JSON.stringify(data),
      success: function(data, textStatus, jqXHR) {
        submission_id = data.id;
      }
  });

  setTimeout(fetchSubmission.bind(null, submission_id), 2000);
};

function fetchSubmission(submission_id) {
  var status;
  var time;
  var memory;
  var actualOutput;
  $.ajax({
      url: BASE_URL + "/submissions/" + submission_id,
      type: "GET",
      async: false,
      success: function(data, textStatus, jqXHR) {
        actualOutput = data.actual_output;
        status = data.status;
        time = data.time;
        memory = data.memory;
      }
  });


  time = (time === null ? "-" : time + "s");
  memory = (memory === null ? "-" : memory + "KB");
  if (status.id === 1) {
    setTimeout(fetchSubmission.bind(null, submission_id), 2000);
  } else {
    statusEditor.setValue("Time: " + time + "\n" + "Memory: " + memory + "\n" + status.description);
    actualOutputEditor.setValue(actualOutput);
    toggleControlsAndLoader();
  }
}

$(document).ready(function() {
  sourceEditor = CodeMirror(document.getElementById("source-editor"), {
    lineNumbers: true,
    mode: "text/x-csrc",
    value: "\
#include <stdio.h>\n\
\n\
int main(void) {\n\
  char name[10];\n\
  scanf(\"%s\", name);\n\
  printf(\"hello, %s\\n\", name);\n\
  return 0;\n\
}"
  });

  inputEditor = CodeMirror(document.getElementById("input-editor"), {
    lineNumbers: true,
    mode: "none",
    value: "world"
  });

  expectedOutputEditor = CodeMirror(document.getElementById("expected-output-editor"), {
    lineNumbers: true,
    mode: "none",
    value: "hello, world"
  });

  actualOutputEditor = CodeMirror(document.getElementById("actual-output-editor"), {
    lineNumbers: true,
    readOnly: true,
    mode: "none"
  });

  statusEditor = CodeMirror(document.getElementById("status-editor"), {
    lineNumbers: false,
    readOnly: true,
    mode: "none"
  });
});
