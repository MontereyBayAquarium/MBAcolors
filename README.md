
# MBAcolors  <img align="right" src="Images/read_me_figures/MBAcolors_hex.jpg" width=300>


Palettes inspired by exhibits at Monterey Bay Aquarium.

Palettes are generated from photos of the animals and exhibits at Monterey Bay Aquarium. Color palettes offer both
discrete and continuous options. [Coolors](https://coolors.co/image-picker) was used to select hex codes from images and the [Chroma.js Color Palette Helper](https://gka.github.io/palettes/#/9|s|00429d,96ffea,ffffe0|ffffe0,ff005e,93003a|1|1) was used to adjust values to ensure that all palettes are <b>color-blind safe</b> for inclusive data viz. 

Structure of the code was inspired by the [`LaCroixColoR`](https://github.com/johannesbjork/LaCroixColoR) 
and [`PNWColors`](https://github.com/jakelawlor/PNWColors/tree/master) packages. 

[Installation](#install-package)  
[Palettes](#palettes)  
[Functions](#building-palettes)  
[Examples](#example-plots)  
[As Seen In](#as-seen-in)  
[Contact](#contact)  


## Install Package
```r

# dev version:
install.packages("devtools") 
devtools::install_github("MontereyBayAquarium/MBAcolors") 
```

## Usage

```r
library(MBAColors)

> names(exhibits)
 [1] "mba"       "mba2"      "mba3"      "kelp"      "rosa"      "stream"    "gpo"    
 [8] "nautilus"  "sandy"     "aviary"    "drifters"  "drifters2" "seapalm"  "coralreef" 
 ```

## Palettes

All images below copyright ©Monterey Bay Aquarium


<img src="Images/read_me_figures/mba.png">

***

<img src="Images/read_me_figures/kelp.png">

***

<img src="Images/read_me_figures/rosa.png">

***

<img src="Images/read_me_figures/stream.png">

***

<img src="Images/read_me_figures/gpo.png">

***
<img src="Images/read_me_figures/nautilus.png">

***
<img src="Images/read_me_figures/sandy.png">

***

<img src="Images/read_me_figures/aviary.png">

***

<img src="Images/read_me_figures/drifters.png">

***
<img src="Images/read_me_figures/seapalm.png">

***
<img src="Images/read_me_figures/coralreef.png">
***


## Building Palettes 

Use the `mba_colors()` function to build and view palettes. Inputs are 'exhibit', 'n_colors', and 'type' (continuous or discrete). 'exhibit' is required. If 'n_colors' is blank, function will assume n is equal to the number of colors in the palette (5-10), but if n_colors > palette length, it will automatically interpolate colors between. If 'type' is missing, the function will assume "discrete" if n_colors < palette length, and "continuous" if n_colors > palette length. 

```r
mba_colors(exhibit="coralreef",n_colors=5,type="discrete")

```

<img src="Images/read_me_figures/coral_pal.png" width=550>


```r
mba_colors(exhibit="gpo",n_colors=100,type="continuous")

```

<img src="Images/read_me_figures/gpo_pal.png" width=550>


## Example Plots


```r
pal <- mba_colors("kelp",100)
image(volcano, col = pal)

```
<center><img src="Images/read_me_figures/kelp_volcano.png"></center>


Palettes can be reversed by setting `rev = TRUE `

```r
pal <- mba_colors("kelp",100, rev = TRUE)
image(volcano, col = pal)

```
<center><img src="Images/read_me_figures/kelp_volcano_rev.png"></center>


Palettes can be easily integrated into `ggplot2`. 
Note:: `scale_fill_mba()` and `scale_color_mba()` are still under development. 
The preferred method is to assign `mba_colors()` to an object, then pass the object
to `ggplot()` (first example below). `scale_fill_mba()` and `scale_color_mba()` are in beta. 


```r

pal=mba_palette("drifters",100)
ggplot(data.frame(x = rnorm(1e4), y = rnorm(1e4)), aes(x = x, y = y)) +
  geom_hex() +
  coord_fixed() +
  scale_fill_gradientn(colours = pal) +
  theme_classic()


```

<center><img src="Images/read_me_figures/drifters_hex.png"></center>

```r
ggplot(diamonds, aes(carat, fill = cut)) +
  geom_density(position = "stack") +
  scale_fill_mba("mba",5, type = "discrete")  +
  theme_classic()

```  
<center><img src="Images/read_me_figures/mba_diamonds.png"></center>


 ```r
 
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) + 
  geom_violin(trim=FALSE)+
  geom_boxplot(width=0.1, fill="white")+
  labs(title="Plot of length by dose",x="Dose (mg)", y = "Length")+
  scale_fill_mba("coralreef",3)+
  theme_classic()

```
<center><img src="Images/read_me_figures/aviary_violin.png"></center>

```r

# Create a scatter plot with color mapped to the continuous MBA palette
ggplot(mtcars, aes(x = mpg, y = wt, color = mpg)) +
  geom_point(size = 3) +
  scale_color_mba("kelp", 200, type = "continuous") +
  theme_classic()
  
```

<center><img src="Images/read_me_figures/cars_mpg.png"></center>


## As Seen In:
Have you used `MBAcolors` in something? Please share to grow the list! 
***
[Smith et al. 2023, In review](INSERTLINK), **mba3** palette <br>
<img src="Images/read_me_figures/Fig4_Smithetal2023.png" width=600>
Figure 4. Changes in species abundance after (2014-2020) vs. before (2007-2013) 
the sea urchin outbreak for persistent (Panel A) and transitioned sites (Panel B).
Only species that significantly contributed (as determined by simultaneous generalized 
linear models) to observed community structure differences between periods (after vs. before) are shown. Each point connected with a horizontal line represents the percent change in abundance. Points to the left of the vertical dashed line indicate a decline in abundance and points to the right of the line indicate an increase in abundance. Line color indicates the trophic function of a given species. Observed mean abundances before vs. after the sea urchin outbreak are parenthetically included next to each species ( † = density, no. individuals per 60 m2 transect; * = percent cover). Finally, sea star species were removed because of the wasting event that occurred in 2013. 

***

### Contact
Reach me at <jossmith@mbayaq.org> 

# Suggested citation
Smith, JG. (2023). MBAColors: themes inspired by Monterey Bay Aquarium. R package version 0.1.0.

