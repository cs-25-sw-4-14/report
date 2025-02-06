#import "../custom.typ": *

= Components
#box(title: "Title for Text Box with Footer")[
  The main content of the text box goes here!  
][Footer text goes here]

#box(title: "Title for Text Box")[
  The main content of the text box goes here! 
][]

#code(lang: "Rust")[Code Block Title][
  ```rust
    fn main() {
        println!("Hello, world!");
    }
  ```
]

#code(lang: "Rust")[][
  ```rust
    fn main() {
        println!("Hello, world!");
    }
  ```
]

#note(title: "Note Title")[Inside a Carnot cycle, the efficiency $eta$ is defined to be:

  $ eta = W/Q_H = frac(Q_H + Q_C, Q_H) = 1 - T_C/T_H $]