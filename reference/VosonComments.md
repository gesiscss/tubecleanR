# vosonComments

An example dataset to showcase the structure of YouTube comments
extracted using the `Collect` function from the vosonSML package.

## Usage

``` r
VosonComments
```

## Format

A data frame with 24 rows and 12 columns:

- Comment:

  Content of the comment

- AuthorDisplayName:

  Displayed name of the comment author

- AuthorProfileImageUrl:

  URL of the comment author's profile picture

- AuthorChannelUrl:

  URL of the comment author's channel

- AuthorChannelID:

  Unique ID of the comment author's channel

- ReplyCount:

  Number of replies to the comment

- LikeCount:

  Number of likes on the comment

- PublishedAt:

  Date and time the comment was published

- UpdatedAt:

  Date and time the comment was last updated

- CommentID:

  Unique ID of the comment

- ParentID:

  Unique ID of the comment to which the comment is a reply

- VideoID:

  Unique ID of the video to which the comment is a reply

## Source

The data was modeled to resemble a random subset of 24 comments from the
following YouTube video: <https://www.youtube.com/watch?v=1aheRpmurAo>,
exported with the tuber package. It was manually recreated to comply
with YouTube's terms of service while still preserving the general
structure for demonstration purposes.
