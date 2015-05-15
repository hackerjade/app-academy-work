module TracksHelper
  def ugly_lyrics(lyrics)
    output = lyrics.split("\n").map do |line| "&#9835; #{line}" end.join("<br>")
    output += "<br><br><br><br>"

    output.html_safe
  end
end
