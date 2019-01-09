import 'dart:async';

class Cake {}
class Order {
  String type;
  Order(this.type);
}

void main() {
  // Creating new StreamController that has
  // 'sink' and 'stream' properties
  final controller = new StreamController();
  
  final order = new Order('chocolate');
  
  // Implementing the Transformer
  final baker = new StreamTransformer.fromHandlers(
  	handleData: (cakeType, sink) {
      if(cakeType == 'chocolate') {
        sink.add(new Cake());
      } else {
        sink.addError('I can not bake that type');
      }
    }
  );
  
  // Using StreamControllers 'sink' to add values
  // to the Stream
  controller.sink.add(order);
  
  controller.stream
    // We look at the value that is coming to the stream
    // and do something with it in this case we just care
    // what type of cake it is
    .map((order) => order.type)
    // In streamTransformer we can do some more processing on
    // the value that is going through the stream in this case
    // we create new Cake if the order.type is chocolate
    .transform(baker)
    // listen function listen to the values that come from
    // the stream
    .listen(
  		(cake) => print('Here is your cake $cake'),
    	onError: (err) => print(err)
  	);
}

// —————————————————————————————————————————————

import 'dart:html';

void main() {
  final ButtonElement button = querySelector('button');
  final InputElement input = querySelector('input');
  
  button.onClick
    // Take is how many events can pass through
    // this stream in this case user has 4 tries
    // to guess the word
    .take(4)
    // In where function we can check if data meets certain
    // criterias in this case we check if the input value is banana
    .where((event) => input.value == 'banana')
    // Listen function triggers when data comes out of our stream
    // In this case data comes out of our stream only if it contains
    // input value of banana else it is an error. Stream is done when
    // stream is triggered 4 times then onDone function is called
    .listen(
  		(event) => print('You got it!'),
    	onDone: () => print('Nope! bad guesses')
  	);
}

// —————————————————————————————————————————————

import 'dart:html';
import 'dart:async';

// Email validation
void main() {
  final InputElement input = querySelector('input');
  final DivElement div = querySelector('div');
  
  final validator = new StreamTransformer.fromHandlers(
  	handleData: (inputValue, sink) {
      if(inputValue.contains('@')) {
        sink.add(inputValue);
      } else {
        sink.addError('Enter a valid email');
      }
    }
  );
  
  input.onInput
    .map((dynamic event) => event.target.value)
    .transform(validator)
    .listen(
  		(inputValue) => div.innerHtml = '',
    	onError: (err) => div.innerHtml = err
  	);

}