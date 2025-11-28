# parsetuber

Processed version of tuberComments dataset.

## Usage

``` r
parsetuber
```

## Format

A data frame with 24 rows and 15 columns:

- VideoID:

  ID of the YouTube video the comment was posted under.

- Author:

  Username of the commenter.

- OriginalText:

  Comment text including user mentions, timestamps, emoji, numbers,
  ascii-art etc.

- CleanedText:

  Preprocessed version of comments, excluding all non-word strings and
  characters.

- Emoji:

  List of emoji extracted from comments

- EmojiDescription:

  List of textual descriptions for emoji extracted from comments.

- Emoticons:

  List of emoticons extracted from comments.

- LikeCount:

  Number of likes the comment received.

- URL:

  List of URLs extracted from comments.

- Timestamps:

  List of timestamps extracted from comments.

- UserMentions:

  List of user mentions extracted from comments.

- Published:

  Timestamp of when the comment was posted.

- Updated:

  Timestamp of when the comment was last updated.

- ParentId:

  ID of the parent comment, if comment is a reply to a previous comment.

- CommentID:

  Unique ID of the comment

## Source

Result of running parse_yt_comments(tuberComments)
