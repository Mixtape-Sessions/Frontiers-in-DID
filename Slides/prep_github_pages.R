library(quarto)
library(R.utils)

# Render qmd
qmds = list.files(
  path = "Slides", pattern = "*.qmd",
)
lapply(qmds, function(file) {
  infile = paste0("Slides/", file)
  quarto::quarto_render(
    input = infile,
    execute_dir = "Slides"
  )
})

# Move to docs folder
pages = list.files(path = "Slides", pattern = "*.html")
folders = list.files(path = "slides", pattern = "*_files")
lapply(pages, function(page) {
  file.copy(
    paste0("Slides/", page), paste0("docs/", page), 
    overwrite = TRUE
  )
  file.remove(paste0("Slides/", page))
})
lapply(
  folders, 
  function(folder) {
    copyDirectory(
      paste0("Slides/", folder), paste0("docs/", folder), 
      recursive = TRUE, overwrite = TRUE
    )
    removeDirectory(paste0("Slides/", folder), recursive = TRUE)
  }
)
