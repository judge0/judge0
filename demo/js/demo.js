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
  var source = sourceEditor.getValue();
  var input = inputEditor.getValue();
  var expectedOutput = expectedOutputEditor.getValue();

  toggleControlsAndLoader();
  setTimeout(toggleControlsAndLoader, 2000); // Ajax call to API
};

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
