#import "@THR/Base:1.0.0" as Base: *

#let template(doc) = [
  #set page(margin: 1.5cm, columns: 2, flipped: true)
  #set par(justify: true)
  #show: Base.template
  #doc
]
