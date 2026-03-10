#import "@THR/Base:1.0.0" as Base: *

#let template(doc, ..args) = [
  #set page(margin: 1.5cm, flipped: true, columns: 2)
  #set par(justify: true)
  #show: Base.template.with(..args)

  #doc
]
