# tubecleanR
<img src="man/figures/tubecleanR_stickr.png" align="right" alt="tubecleanR Sticker" width="120">

This is a mini `R` package for cleaning and preprocess *YouTube* comment data collected with the `R` packages [tuber](https://github.com/gojiplus/tuber) or [vosonSML](https://github.com/vosonlab/vosonSML).
The package is a collection of several functions that were developed during several workshops on collecting and analyzing *YouTube* data at [GESIS - Leibniz Institute for the Social Sciences](https://www.gesis.org/home). The main function of the package is `parse_yt_comments()` which takes a dataframe containing *YouTube* comments collected with `tuber` or `vosonSML` as input and outputs a processed dataframe in which URLs/links, video timestamps user mentions, emoticons, and emoji have been extracted from the comments into separate colums. In addition to this, the function creates a columns containing textual descriptions of the emoji, and another one containing a cleaned version of the comment in which the elements listed before as well as numbers and punctuation have been removed.

**Please note**: The functions in this package are heavily dependent on the structure of the data exports from `tuber` and `vosonSML`, and, by extension, the structure of the *YouTube* API. 

If you are interested in becoming a maintainer of this package, feel free to contact us.
 
## 1) Installation

```R
 # GitHub version
 library(remotes)
 remotes::install_github("gesiscss/tubecleanR")
```
 
## 2) Demo data

We have created some simulated *YouTube* comment data in the `tuber` and `vosonSML` formats

```R
# Loading example comments bundled with the package
tuber_demo <- readRDS(system.file("tuberComments.rds", package = "tubecleanR"))
voson_demo <- readRDS(system.file("vosonComments.rds", package = "tubecleanR"))

# Parsing comments
tuber_parsed <- parse_yt_comments(tuber_demo)
voson_parsed <- parse_yt_comments(voson_demo)
```
 
## 3) Using your own data

The `parse_yt_comments()` function is meant to be used for *YouTube* comment data collected with the `get_all_comments()` function from `tuber` or the `Collect()` function from `vosonSML`. Both of those require access credentials for the *YouTube API*. Check the documentation of those two packages for further details.

If you want to learn more about getting access to the *YouTube* API, collecting comment (and other) data from the API using `R`, and processing and exploring the resulting data, you can also check out the materials from our [workshop](https://github.com/jobreu/youtube-workshop-gesis-2023).
