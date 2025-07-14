# tubecleanR
<img src="man/figures/tubecleanR_stickr.png" align="right" alt="tubecleanR Sticker" width="120">

This is a mini `R` package for cleaning and preprocess *YouTube* comment data collected with the `R` packages [tuber](https://github.com/gojiplus/tuber) or [vosonSML](https://github.com/vosonlab/vosonSML).
The package is a collection of functions that were developed during several workshops on collecting and analyzing *YouTube* data at [GESIS - Leibniz Institute for the Social Sciences](https://www.gesis.org/home). The main function of the package is `parse_yt_comments()` which takes a dataframe containing *YouTube* comments collected with `tuber` or `vosonSML` as input and outputs a processed dataframe in which URLs/links, video timestamps user mentions, emoticons, and emoji have been extracted from the comments into separate columns. In addition to this, the function creates a column containing textual descriptions of the emoji, and another one containing a cleaned version of the comment in which the elements listed before as well as numbers and punctuation have been removed.

**Please note**: The functions in this package are heavily dependent on the structure of the data exports from `tuber` and `vosonSML`, and, by extension, the structure of the *YouTube* API. You can find an introduction to the *YouTube Data API* in the [*GESIS Guide on Digital Behavioral Data* on "How to Collect Data with the YouTube Data API"](https://www.gesis.org/fileadmin/admin/Dateikatalog/pdf/guides/13_Kohne_et_al_How_to_YouTube.pdf). 

If you are interested in becoming a maintainer of this package, feel free to contact us.
 
## 1) Installation

```R
 # GitHub version
 library(remotes)
 remotes::install_github("gesiscss/tubecleanR")
```
 
## 2) Demo data

We have created some simulated *YouTube* comment data in the `tuber` and `vosonSML` formats that is included in this package.

```R
# Attaching package
library(tubecleanR)

# Checking example comments bundled with the package
View(tuberComments)
View(vosonComments)

# Parsing comments
tuber_parsed <- parse_yt_comments(tuberComments)
voson_parsed <- parse_yt_comments(vosonComments)

# Checking parsed versions of example comments
View(tuber_parsed)
View(Voson_parsed)
```
 
## 3) Using your own data

The `parse_yt_comments()` function is meant to be used for *YouTube* comment data collected with the `get_all_comments()` function from `tuber` or the `Collect()` function from `vosonSML`. Both of those require access credentials for the *YouTube API*. Check the documentation of those two packages for further details.

If you want to learn more about getting access to the *YouTube* API, collecting comment (and other) data from the API using `R`, and processing and exploring the resulting data, you can also check out the materials from our [workshop](https://github.com/jobreu/youtube-workshop-gesis-2023).

## 4) Citation
If you are using this package in your research, please cite it as follows:

```R
citation("tubecleanR")
```

```R
To cite package ‘tubecleanR’ in publications use:

  Kohne, J., & Breuer, J. (2024). tubecleanR: Parsing and Preprocessing YouTube Comment
  Data. R package version 0.1.0. <https://gesiscss.github.io/tubecleanR/>.

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {tubecleanR: Parsing and Preprocessing YouTube Comment Data},
    author = {Julian Kohne and Johannes Breuer},
    year = {2024},
    note = {R package version 0.1.0},
    url = {https://gesiscss.github.io/tubecleanR/},
  }
```
