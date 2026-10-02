#import "@preview/lovelace:0.3.1": pseudocode-list

#let code(title: none, link: none, code) = [
  #align(center)[
    #block(
      width: 95%,
      inset: 3mm,
      fill: color.rgb("#fdf6e3"),
      stroke: (left: 1mm + color.rgb("#f1706f").opacify(-20%)),
      align(left)[
        #show raw.line: it => [
          #let n = str(it.number)
          #let disp = " " * (3 - n.len()) + n
          #text(fill: color.rgb("#5c6a72"), [#disp #h(-1mm)- ]) #it.body
        ]

        #set text(style: "normal", weight: "medium", fill: color.rgb("#5c6a72"))
        #code
      ]
    )
  ]
]

#let pseudo(header: none, code-list) = [
  #let is-headed = not header in ([], (:), none)
  #align(center, block(
    width: 90%,
    stroke: (left: 0.4mm + black),
    inset: (x: 2mm, top: if is-headed { 1mm } else { -2mm }, bottom: -1mm),
  )[
    #align(left, [
      #set list(marker: ("•"), indent: 0mm)
      #if is-headed { header } else { none }

      #pseudocode-list(
        line-numbering: i => [*#numbering("1.", i)*],
        code-list
      )
    ])
  ])
]
