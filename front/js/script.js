var wordNumber = 0;
var letterNumber = 0;

function letterHandle(letter) {
  if (letterNumber < 5) {
    const word = document.getElementById("word" + wordNumber);
    const letterNode = word.children[letterNumber];
    letterNode.append(letter);

    letterNumber++;
  }
}

function deleteHandle() {
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

  if (wordNumber < 5) {
    letterNumber = 0;
    wordNumber++;
  } else {
    console.log("enviar");
  }

  function wrongLetter(idLetter, idWord) {
    const word = document.getElementById("word" + idWord);
    const letterNode = word.children[idLetter];
    letterNode.style.backgroundColor = "red";
  }

  function RightLetter(idLetter, idWord) {
    const word = document.getElementById("word" + idWord);
    const letterNode = word.children[idLetter];
    letterNode.style.backgroundColor = "yellow";
  }

  function RightLetterPosition(idLetter, idWord) {
    const word = document.getElementById("word" + idWord);
    const letterNode = word.children[idLetter];
    letterNode.style.backgroundColor = "green";
  }
}
