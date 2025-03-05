#import "custom.typ": *
#import "template.typ": *

#import "@preview/codly:1.0.0": *
#show: codly-init.with()

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  meta: (
    title: "Memory Safety",
    theme: "Memory Safe Programming Language",
    project_period: "Spring Semester 2025",
    project_group: "cs-25-sw-4-14",
    participants: (
      (name: "Kristoffer Vestergård Johansson", email: "kjohan23@student.aau.dk"),
      (name: "Mads Ludvig Timm Fagerlund", email: "mfager23@student.aau.dk"),
      (name: "Marc Nygaard", email: "mnygaa23@student.aau.dk"),
      (name: "Rasmus Hilmar Precht Christensen", email: "rhpc23@student.aau.dk"),
      (name: "Sebastian Kjældgaard Andersen", email: "skan23@student.aau.dk"),
      (name: "Thorbjørn Dige Larsen", email: "tdla23@student.aau.dk")
    ),
    supervisor: (
      (name: "Lukas Holik", email: "lukasholik@cs.aau.dk"),
    ),
    date: datetime.today().display()
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract: [This is the abstract, please write something here. #lorem(59)],
  department: "Computer Science",
)

// This is the primary file in the project.
// Commonly referred to as 'master' in LaTeX, and wokenly called 'main' in Typst.

#let render = false

#if render == false [
  #include "chapters/styleguide.typ"
  #pagebreak(weak: true)
]

#include "chapters/theory.typ"
#pagebreak(weak: true)

#include "chapters/introduction.typ"
#pagebreak(weak: true)

#include "chapters/problem_analysis.typ"
#pagebreak(weak: true)

#include "chapters/language_design.typ"
#pagebreak(weak: true)

#include "chapters/compiler_design.typ"
#pagebreak(weak: true)

#include "chapters/implementation.typ"
#pagebreak(weak: true)

#include "chapters/testing.typ"
#pagebreak(weak: true)

#include "chapters/discussion.typ"
#pagebreak(weak: true)

#include "chapters/future_work.typ"
#pagebreak(weak: true)

#include "chapters/conclusion.typ"
#pagebreak(weak: true)

#bibliography("sources/sources1.bib")

