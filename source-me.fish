function build-pdf
 typst compile typst/ats.typst
 mv typst/ats.pdf assets/naufal-razin-ats-resume.pdf 
end

function hot-reload
  bun --watch index.html
end
