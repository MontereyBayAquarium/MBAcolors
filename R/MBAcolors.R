# a collection of color palettes inspired by exhibits at Monterey Bay Aquarium
#
# Joshua G. Smith; jossmith@mbayaq.org
#
#


################################################################################
# Create the color palettes based on the exhibit themes

#' Complete list of palettes
#'
#' Use \code{names(exhibits)} to view list of palette names.
#' Currently:  
#'
#' @export
exhibits <- list(
  mba = rbind(c('#5992A4', '#3D736D', '#E9A272','#8F819D', '#1C1B24'),c(1,2,3,4,5)),
  mba2 = rbind(c('#6BA4AF', '#FFEBCA', '#AA9DB5','#6C2D1C', '#7986A6','#E7A070'),c(1,2,3,4,5,6)),
  mba3 = rbind(c('#1B9E77','#6BA4AF', '#E5C200', '#AA9DB5','#6C2D1C', '#7986A6','#E7A070','#E7298A'),c(1,2,3,4,5,6,7,8)),
  kelp = rbind(c('#FFDD00', '#D48321','#325B1E', '#004B4F', '#007999', '#00CBBD'), c(1, 2, 6, 4, 5, 3)),
  rosa = rbind(c('#90898C', '#B0A39E', '#8B7B72', '#59504D', '#433E40','#29211D','#171618'),c(1,2,3,4,5,6,7)),
  stream = rbind(c('#9DA10A','#5E7811','#243303', '#524D1B','#4D4D46', '#020700'), c(1, 2, 3, 4, 5, 6)),
  gpo = rbind(c('#5B1A0C', '#A03821', '#AA5D48', '#AC908E', '#898086'), c(1,2,3,4,5)),
  nautilus = rbind(c('#EFDBDE','#C3C3D8', '#7C8BB0', '#6F6A8A', '#A84C4E'),c(1,2,3,4,5)),
  sandy = rbind(c('#777F04', '#C1AD7B', '#D2C6AF', '#847E6A', '#524949'),c(1,2,3,4,5)),
  aviary = rbind(c("#D06E0F","#CF4600",'#7F3D0E','#552C1C',"#853D54",'#11140A'),c(1,2,3,4,5,6)),
  drifters = rbind(c('#4992F2', '#0050E2', '#3C3390', '#DF7E33', '#702211'),c(1,2,3,4,5)),
  drifters2 = rbind(c('navyblue', 'gray80', 'indianred'),c(1,2,3)),
  seapalm = rbind(c('#CEC4B2', '#A19374', '#C6AB2C', '#535044', '#423D39'),c(1,2,3,4,5)),
  coralreef = rbind(c('#FFC19D','#C5A7AC', '#C7B4DA', '#3DA3DC', '#222855'),c(1,2,3,4,5))
)

################################################################################
# Palette builder function, adapted from Jake Lawlor (2020). PNWColors: Color Palettes Inspired by Nature in the US Pacific Northwest. R package version 0.1.0. https://CRAN.R-project.org/package=PNWColors

# Custom Palette Generator for MBA-inspired themes
# 
# This function creates custom color palettes for data visualization using 
# themes inspired from exhibits at Monterey Bay Aquarium. The palettes are designed to work
# with ggplot and offer both continuous and discrete color options.
# 
#' @param palette_name The name of the color palette to draw from.
#' @param num_colors The number of colors to include in the palette.
#' @param palette_type The type of palette to generate, either "discrete" or "continuous."
# 
#' @return A vector of colors for data visualization.
# 
#' @examples
# mba_colors("mba", num_colors = 100, palette_type = "continuous")
# mba_colors("Nautilus", num_colors = 5, palette_type = "discrete")
# 
#' @author Joshua G. Smith
#' @version 0.1.0
#' 
mba_colors <- function(exhibit, n_colors, type = c("discrete", "continuous"), rev = FALSE) {
  
  # Retrieve the palette based on the provided name
  custom_pal <- exhibits[[exhibit]]
  
  # Check if the palette exists
  if (is.null(custom_pal)){
    stop("Palette not found.")
  }
  
  # Check if we need to reverse the palette
  if (rev) {
    custom_pal[1,] <- rev(custom_pal[1,])
  }
  
  # If n_colors is not provided, set it to the length of the palette
  if (missing(n_colors)) {
    n_colors <- length(custom_pal[1,])
  }
  
  # If type is not provided, determine it based on the number of colors
  if (missing(type)) {
    if (n_colors > length(custom_pal[1,])) {
      type <- "continuous"
    } else {
      type <- "discrete"
    }
  }
  type <- match.arg(type)
  
  # Check if the requested number of colors is valid for a discrete palette
  if (type == "discrete" && n_colors > length(custom_pal[1,])) {
    stop("Number of requested colors greater than what the discrete palette can offer. Use as continuous instead.")
  }
  
  # Generate the color palette based on the type
  palette_colors <- switch(type,
                           continuous = grDevices::colorRampPalette(custom_pal[1,])(n_colors),
                           discrete = custom_pal[1,][custom_pal[2,] %in% c(1:n_colors)]
  )
  
  # Return the palette with its class and name attributes
  structure(palette_colors, class = "MBAPalette", name = exhibit)
}

#' @export
#' 
#' 

# Function to create a ggplot2 scale for color using MBA palette with alpha
scale_color_mba <- function(exhibit, n_colors, type = c("discrete", "continuous"), rev = FALSE, alpha = 1, limits = NULL, name = NULL, ...) {
  palette_colors <- mba_colors(exhibit, n_colors, type, rev)
  
  if (!is.null(limits)) {
    palette_colors <- palette_colors[limits]
  }
  
  if (type == "discrete") {
    return(ggplot2::scale_color_manual(values = ggplot2::alpha(palette_colors, alpha), limits = limits, name = name, ...))
  } else {
    return(ggplot2::scale_color_gradientn(colors = ggplot2::alpha(palette_colors, alpha), limits = limits, name = name, ...))
  }
}

# Function to create a ggplot2 scale for fill using MBA palette with alpha
scale_fill_mba <- function(exhibit, n_colors, type = c("discrete", "continuous"), rev = FALSE, alpha = 1, limits = NULL, name = NULL, ...) {
  palette_colors <- mba_colors(exhibit, n_colors, type, rev)
  
  if (!is.null(limits)) {
    palette_colors <- palette_colors[limits]
  }
  
  if (type == "discrete") {
    return(ggplot2::scale_fill_manual(values = ggplot2::alpha(palette_colors, alpha), limits = limits, name = name, ...))
  } else {
    return(ggplot2::scale_fill_gradientn(colors = ggplot2::alpha(palette_colors, alpha), limits = limits, name = name, ...))
  }
}





################################################################################
# 3. Palette visualization function

#' @importFrom graphics rect par image text
#' @importFrom stats median
#' 
print_colors <- function(x, ...) {
  pallength <- length(x)
  MBApar <- par(mar = c(0.25, 0.25, 0.25, 0.25))
  on.exit(par(MBApar))
  
  color_matrix <- matrix(1:pallength, ncol = 1)  # Create a single-column matrix
  
  image(1, 1:pallength,
        matrix(1:pallength, ncol = pallength),  # Use the number of colors as the number of columns
        col = rev(x),  # Reverse the order of colors
        axes = FALSE)
  
  #text(1, median(1:pallength),
  #    labels = paste0(attr(x, "name"), ", n=", pallength),
  #   cex = 3, family = "sans")
}

#' @examples
# my_palette <- mba_colors("seapalm", n_colors = 200, type = "continuous")
# print_colors(my_palette)




