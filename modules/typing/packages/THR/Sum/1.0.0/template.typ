#import "@THR/Base:1.0.0" as Base: *

#let template(doc) = [
  #set page(margin: 0.5cm, columns: 2)
  #set par(justify: true)
  #show: Base.template
  #doc
]
