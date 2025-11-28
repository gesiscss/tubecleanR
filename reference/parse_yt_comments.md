# Parse YouTube Comments

This function processes a dataframe of YouTube comments, extracting and
cleaning various elements such as emojis, emoticons, URLs, timestamps,
and user mentions. It supports comment dataframes created with the
`get_all_comments`,`get_comments` or `Collect` functions.

## Usage

``` r
parse_yt_comments(data, package = "auto", verbose = FALSE)
```

## Arguments

- data:

  A dataframe containing YouTube comments. The structure of this
  dataframe should conform to the output of the 'tuber' or 'vosonSML'
  package.

- package:

  A character string specifying the package that was used to collect the
  comment data. The default value is "auto", which automatically detects
  the package based on the structure of the \`data\`. Other possible
  values are "tuber" and "vosonSML".

- verbose:

  A logical parameter. If TRUE, the function prints progress reports to
  the console.

## Value

A dataframe with the original comment data and additional columns for
cleaned comments, emojis, emoji descriptions, emoticons, URLs,
timestamps, and user mentions. The dataframe also includes metadata as
attributes, such as the origin package, tubecleanR version, and counts
of comments, links, emojis, emoticons, user mentions, and timestamps.

## Note

This function requires the 'tuber' or 'vosonSML' package for data
collection. The 'tubecleanR' minipackage is only meant for processing
YouTube comment data.

## Examples

``` r
# Loading example comments bundled with the package
tuber_comments <- readRDS(system.file("tuberComments.rds", package = "tubecleanR"))

# parsing comments
parsed_comments <- parse_yt_comments(tuber_comments)
```
