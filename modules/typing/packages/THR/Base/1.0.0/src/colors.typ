#let balanced-color(hue, chroma, brightness) = color.oklch(brightness, chroma, hue * 20deg, 100%)

#let indexed-colors(hue) = {
  return (
    foreground: balanced-color(hue, 10%, 96%),
    background: balanced-color(hue, 40%, 70%),
    text: balanced-color(hue, 40%, 55%)
  )
}
