var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
var recognition = new SpeechRecognition();
var textbox = $("#Content");
var instruction = $("#instruction");
var startBtn = $("#start-btn");
var stopBtn = $("#stop-btn");

var content = '';

recognition.continuous = true;

recognition.onstart = function () {
    instruction.text("Voice Recognition is On");
    startBtn.addClass('hidden');
    stopBtn.removeClass('hidden');
};

recognition.onspeechend = function () {
    instruction.text("No Activity");
};

recognition.onerror = function (event) {
    instruction.text("Try Again: " + event.error);
};

recognition.onresult = function (event) {
    var current = event.resultIndex;
    var transcript = event.results[current][0].transcript;

    content += transcript;
    textbox.val(content);
};

startBtn.click(function () {
    if (content.length) {
        content = ''; // Clear content if it's not empty
        textbox.val(''); // Clear textbox to reflect the change
    }
    recognition.start();
});

stopBtn.click(function () {
    recognition.stop();
    instruction.text("Voice Recognition is Off");
    startBtn.removeClass('hidden');
    stopBtn.addClass('hidden');
});

textbox.on("input", function () {
    content = $(this).val();
});