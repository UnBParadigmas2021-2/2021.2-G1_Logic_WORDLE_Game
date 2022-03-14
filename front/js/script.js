var wordNumber = 0;
var letterNumber = 0;
var url = "http://localhost:8000/";
var word = "";
var modal = document.getElementById("modal-win");
var span = document.getElementsByClassName("close")[0];
var attempts = 0;


window.onload = startGame;

function startGame() {
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.open("GET", url + "start", false); // false for synchronous request
  xmlHttp.send(null);
  word = xmlHttp.responseText;
  console.log(word);
}

function guessGame(wordPost) {
  return $.ajax({
    url: url + "verify",
    type: "post",
    contentType: "application/json",
    dataType: "json",
    data: JSON.stringify({ guess: wordPost }),
  });
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
  if (letterNumber > 0) {
    const word = document.getElementById("word" + wordNumber);
    const letterNode = word.children[letterNumber - 1];
    letterNode.innerHTML = "";
    letterNumber--;
  }
}

async function submitHandle() {
  if (letterNumber != 5) {
    console.log("Palavra com menos de 5 letras");
    return;
  }

  if (wordNumber < 5) {
    var wordTemp = "";

    for (let index = 0; index < 5; index++) {
      const word = document.getElementById("word" + wordNumber);
      const letterNode = word.children[index];
      wordTemp += letterNode.innerHTML;
    }

    const data = await guessGame(wordTemp.toLowerCase());

    if (data.status && data.status == "fail") {
      console.log("palavra não existe");
      return;
    } else if (data.status && (data.status == "going" || data.status == "ok")) {
      for (let index = 0; index < 5; index++) {
        const element = data.data[wordNumber].colors[index];
        if (element == "cyan") {
          wrongLetter(index, wordNumber);
        } else if (element == "yellow") {
          RightLetter(index, wordNumber);
        } else if (element == "green") {
          RightLetterPosition(index, wordNumber);
        }
      }
    }

    if (data.status == "ok") {
			winHandler();
    }

    letterNumber = 0;
    wordNumber++;
  } else {
		failHandler();
  }
}

function winHandler(){
	const description = document.getElementById("description-win");
	const header = document.getElementById("header-win");
	header.innerHTML = "Parabéns!! você acertou a palavra";
	description.innerHTML = "Você precisou de " + wordNumber + " tentativas";
	modal.style.display = "block";
}

function failHandler(){
	const description = document.getElementById("description-win");
	const header = document.getElementById("header-win");
	const modalHeader = document.getElementById("modal-header");
	header.innerHTML = "Infelizmente você não conseguiu";
	description.innerHTML = "Você pode tentar novamente a qualquer hora";
	modalHeader.style.background = "#f44336";
	modal.style.display = "block";
}

span.onclick = function() {
  modal.style.display = "none";
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
