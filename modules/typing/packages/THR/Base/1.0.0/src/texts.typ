#import "@preview/droplet:0.3.1": dropcap

#let ooc(body) = [
  #block(
    stroke: (left: 1mm + black),
    inset: (left: 4mm),
    outset: (y: 2mm, left: -1mm),
    width: 100%,
    body
  )
]

#let outlines() = [
  #v(1cm)
  #block(
    stroke: (left: 1mm + black),
    inset: (left: 7mm),
    outset: (y: 2mm, left: -1mm),
    [
      #set par(justify: false)
      #text("Contents", size: 1.9em)
      #v(3mm)
      #set par(justify: true)
      #outline()
    ]
  )
]

#let ctitle(title) = align(center)[
  #v(2mm)
  #text(size: 1.8em, weight: "bold", title)
]

#let chapter(title, body, num: -1) = [
  #{
    pagebreak(weak: true)
    if (num < 0) { counter("title-counter").step() } 
    else { counter("title-counter").update(num) }

    counter("box-counter").update(0)
  }

  #block(inset: (y: 3mm), [
    #context counter("title-counter").display(i => [= #text(size: 1.2em, smallcaps[*Chapter #i*: #title])])
    #text(size: 2em, "Chapter " + context counter("title-counter").display())
    #v(-6mm)
    #text(size: 3em, title)
    #v(-3mm)
    #dropcap(gap: 3pt)[#body]
  ])
]

#let section(title, level: 2, reset-boxes-count: false, count: true) = [
  #if reset-boxes-count { counter("box-counter").update(0) }

  #if count { counter("title-counter").step(level: level) }
  #context counter("title-counter").display((..i) => [== #if count { i.pos().map(str).join(".") + "." } #title])
  #text(context if count { counter("title-counter").display("1.") + " " } else { "" } + title, size: 1.6em, weight: "bold") \
  #v(1mm)
]

#let subsection(title, level: 3, count: true) = [
  #counter("title-counter").step(level: level)
  #context counter("title-counter").display((..i) => [=== #i.pos().map(str).join("."). #title])
  #text(context counter("title-counter").display("1.") + " " + title, size: 1.3em, weight: "bold") \
  #v(0mm)
]


#let follow-bar(message) = {
  grid(
    columns: (1fr, auto, 1fr),
    column-gutter: 1mm,
    align: center + horizon,
    line(length: 100%, stroke: (paint: gray, dash: "densely-dashed")),
    text(message, fill: gray),
    line(length: 100%, stroke: (paint: gray, dash: "densely-dashed")),
  )
}

#let references(..refs) = {
  pagebreak(weak: true)
  [= #text(size: 1.3em, smallcaps[*References*])]
  text(size: 2em, "References")
  v(0cm)
  enum(
    numbering: "[1] ",
    ..(for ref in refs.pos() {
      ([
        #if "author" in ref [ #smallcaps(ref.at("author", default: "??")), ]
        #if "name" in ref [
          #ref.at("name")
          #if "source" in ref [: #link(ref.at("source", default: "")) ]
        ]
      ],)
    })
  )
}

#let scratchpad(body) = [
  #set text(fill: gray.darken(40%))

  #block(
    width: 100%,
    stroke: gray.darken(40%),
    grid(
      block(width: 100%, height: 0.7cm, fill: gray.darken(40%), align(center + horizon, text(fill: white, weight: "bold", [Scratch Pad]))),
      block(inset: 3mm, body)
    )
  )
]
