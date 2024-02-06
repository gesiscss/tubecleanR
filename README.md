# tubecleanR
<img src="man/figures/tubecleanR_stickr.png" align="right" alt="tubecleanR Sticker" width="120">

This is a mini R-package to clean and preprocess YouTube comment data collected with the [tuber](https://github.com/gojiplus/tuber) R-package or the [vosonSML](https://github.com/vosonlab/vosonSML) R-package.
The package is a collection of several function and example data that were developed during several workshops for collecting and
analyzing YouTube data at [GESIS](https://www.gesis.org/home). These functions are heavily dependent on the structure of the data exports from tuber and vosonSML, and by extension on the structure of the YouTube API. If you are interested in becoming a maintainer of this package, feel free to send us an email.

## How to set it up?
 
### 1) Installing it

```R
 # GitHub version
 library(devtools)
 devtools::install_github("gesiscss/tubecleanR")
```
 
### 2) Testing it

```R
# Loading example comments bundled with the package
LastWeekTonight_comments <- readRDS(system.file("RawLWTComments.rds", package = "tubecleanR"))

# parsing comments
parsed_comments <- parse_yt_comments(LastWeekTonight_comments)
```
 
### 3) Using it with your own data

Check out our extensive [workshop materials](https://github.com/jobreu/youtube-workshop-gesis-2023) to learn how to collect your own data using tuber or vosonSML.
