var wordNumber = 0;
var letterNumber = 0;
var url = "http://localhost:8000/";
var word = "";

window.onload = startGame;

function startGame() {
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.open("GET", url + "start", false); // false for synchronous request
  xmlHttp.send(null);
  word = xmlHttp.responseText;
}

function guessGame() {
  var xhr = new XMLHttpRequest();
  xhr.open("POST", url + "verify", true);
  xhr.setRequestHeader("Content-Type", "application/json");

  xhr.onreadystatechange = function () {
    if (xhr.readyState === 4 && xhr.status === 200) {
      var json = JSON.parse(xhr.responseText);
      console.log(json);
    }
  };

  var data = JSON.stringify({ guess: "hiper" });
  xhr.send(data);
}

function letterHandle(letter) {
  if (letterNumber < 5) {
    const word = document.getElementById("word" + wordNumber);
    const letterNode = word.children[letterNumber];
    letterNode.append(letter);

    letterNumber++;
  }
}

function deleteHandle() {
  guessGame();

  if (letterNumber > 0) {
    const word = document.getElementById("word" + wordNumber);
    const letterNode = word.children[letterNumber - 1];
    letterNode.innerHTML = "";
    letterNumber--;
  }
}

function submitHandle() {
  if (letterNumber != 5) {
    return;
  }

  wrongLetter(0, 0);
  RightLetter(1, 0);
  RightLetterPosition(2, 0);

  if (wordNumber < 5) {
    letterNumber = 0;
    wordNumber++;
  } else {
    console.log("enviar");
  }
}

function wrongLetter(idLetter, idWord) {
  const word = document.getElementById("word" + idWord);
  const letterNode = word.children[idLetter];
  letterNode.style.backgroundColor = "#262C38";
}

function RightLetter(idLetter, idWord) {
  const word = document.getElementById("word" + idWord);
  const letterNode = word.children[idLetter];
  letterNode.style.backgroundColor = "#D3AD69";
}

function RightLetterPosition(idLetter, idWord) {
  const word = document.getElementById("word" + idWord);
  const letterNode = word.children[idLetter];
  letterNode.style.backgroundColor = "#7FD4A3";
}
