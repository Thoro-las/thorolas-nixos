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
