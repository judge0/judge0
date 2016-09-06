var BASE_URL = "http://api.judge0.tk";
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
    submission: {
      source_code: source,
      language_id: language,
      input: input,
      expected_output: expectedOutput
    }
  };

  var submission_id;
  $.ajax({
      url: BASE_URL + "/submissions",
      type: "POST",
      async: false,
      contentType: "application/json",
      data: JSON.stringify(data),
      success: function(data, textStatus, jqXHR) {
        submission_id = data.data.id;
      }
  });

  setTimeout(fetchSubmission.bind(null, submission_id), 2000);
};

function fetchSubmission(submission_id) {
  var status;
  var time;
  var actualOutput;
  $.ajax({
      url: BASE_URL + "/submissions/" + submission_id,
      type: "GET",
      async: false,
      success: function(data, textStatus, jqXHR) {
        actualOutput = data.data.attributes["actual-output"];
        status = data.data.attributes.status;
        time = data.data.attributes.time;
      }
  });

  if (status === null) {
    setTimeout(fetchSubmission.bind(null, submission_id), 2000);
  } else {
    statusEditor.setValue("Time: " + time + "s\n" + status.attributes.name);
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
