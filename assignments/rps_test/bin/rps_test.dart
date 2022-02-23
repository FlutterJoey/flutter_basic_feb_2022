import 'dart:math';

int numberToGuess = 0;
int guesses = 0;

List<int> numbersToGuess = [];

void main(List<String> arguments) {
  startGame();

  guess();
}

void guess() {
  int number = getRandomNumber();
  int result = guessNumber(number);
  if (result > 0) {
    numbersToGuess.removeWhere((val) => val <= number);
    guess();
  } else if (result < 0) {
    numbersToGuess.removeWhere((val) => val >= number);
    guess();
  }
}

int getRandomNumber() {
  return numbersToGuess[Random().nextInt(numbersToGuess.length)];
}

int guessNumber(int number) {
  guesses++;
  print('Gok $guesses');
  if (number < numberToGuess) {
    print('$number: is hoger');
    return 1;
  } else if (number > numberToGuess) {
    print('$number is lager');
    return -1;
  } else {
    print('$number geraden');
    return 0;
  }
}

void startGame() {
  numberToGuess = Random().nextInt(100);
  numbersToGuess = List.generate(100, (index) => index);
}
