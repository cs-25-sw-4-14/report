#import "@preview/showybox:2.0.1": *
#import "@preview/codly:1.0.0": *
#import "@preview/dashy-todo:0.0.1": todo

//####################################//
//############ CODE BLOCK ############//
//####################################//
#let code(lang: "", title, body) = {
  if title != [] {
    [
      #codly(
        smart-indent: true,
        languages: (
          rust: (
            name: [#lang],
            color: rgb("#211A51"),
          ),
        ),
        inset: .32em,
        lang-inset: .5em,
        lang-outset: (x: -3pt, y: 6pt),
        lang-radius: 2pt,
        lang-stroke: (lang) => 1pt + lang.color,
        lang-fill: (lang) => lang.color.lighten(75%)
      )
  
      #showybox(
        frame: (
          border-color: rgb("#211A51"),
          title-color: rgb("#211A51"),
          radius: 2pt,
          title-inset: (x: 1em, y: 1em),
          body-inset: (x: 1pt, y: 1pt),
        ),
        title-style: (
          color: white,
          weight: "regular",
          align: left,
        ),
        shadow: (
          offset: 3pt,
        ),
        title: [*#title*],
        [#body],
      )
    ]
  } else {
    [
      #codly(
        smart-indent: true,
        languages: (
          rust: (
            name: [#lang],
            color: rgb("#211A51"),
          ),
        ),
        inset: .32em,
        lang-inset: .5em,
        lang-outset: (x: -3pt, y: 6pt),
        lang-radius: 2pt,
        lang-stroke: (lang) => 1pt + lang.color,
        lang-fill: (lang) => lang.color.lighten(75%)
      )
  
      #showybox(
        frame: (
          border-color: rgb("#211A51"),
          title-color: rgb("#211A51"),
          radius: 2pt,
          title-inset: (x: 1em, y: 1em),
          body-inset: (x: 1pt, y: 1pt),
        ),
        title-style: (
          color: white,
          weight: "regular",
          align: left,
        ),
        shadow: (
          offset: 3pt,
        ),
        [#body],
      )
    ]
  }
  
}

//#############################//
//############ BOX ############//
//#############################//
#let box(title: "", showy-body, footer) = {
  if footer != [] {
    showybox(
      frame: (
        border-color: rgb("#211A51"),
        title-color: rgb("#211A51"),
        radius: 2pt,
        title-inset: (x: 1em, y: 1em)
      ),
      footer-style: (
        sep-thickness: 0pt,
        color: black,
        align: center
      ),
      title-style: (
        color: white,
        weight: "regular",
        align: left,
        
      ),
      footer: (
        [#footer]
      ),
      shadow: (
        offset: 3pt,
      ),
      title: [*#title*],
      [#showy-body],
    )
  } else {
    showybox(
      frame: (
        border-color: rgb("#211A51"),
        title-color: rgb("#211A51"),
        radius: 2pt,
        title-inset: (x: 1em, y: 1em)
      ),
      title-style: (
        color: white,
        weight: "regular",
        align: left,
      ),
      shadow: (
        offset: 3pt,
      ),
      title: [*#title*],
      [#showy-body],
    )
  }
}

//##############################//
//############ NOTE ############//
//##############################//
#let note(body, title: "") = {
  showybox(
  title-style: (
    weight: 900,
    color: rgb("#211A51"),
    sep-thickness: 0pt,
    align: center
  ),
  frame: (
    title-color: rgb("#211A51").lighten(75%),
    border-color: rgb("#211A51"),
    thickness: (left: 2.5pt),
    radius: 2pt
  ),
  shadow: (
    offset: (x: .5pt, y: .5pt),
    color: rgb("#211A51").lighten(50%)
  ),
  title: [#title]
  )[
    #body
  ]
}


